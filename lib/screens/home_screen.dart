import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/pomodoro_duration_cubit.dart';
import 'package:pomodoro/theme.dart';
import 'package:pomodoro/widgets/pomodoro_duration_input.dart';
// import 'package:pomodoro/widgets/progress_icons.dart';
import 'package:pomodoro/models/pomodoro_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final player = AudioPlayer();
  Timer? countdownTimer;
  Duration pomodoroTime = const Duration(minutes: 0);

  PomodoroStatus pomodoroStatus = PomodoroStatus.readyToStart;
  String _btnStart = 'Start';
  double _progressPercent = 0.0;
  Duration pomodoroTimeEntered = const Duration(minutes: 0);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    var settingDuration = context.watch<PomodoroDurationCubit>();
    (settingDuration.state != '')
        ? pomodoroTimeEntered =
            Duration(minutes: int.parse(settingDuration.state))
        : pomodoroTimeEntered = const Duration(minutes: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  const PomodoroDurationInput(),
                  SizedBox(height: screenHeight * 0.05),
                  CircularPercentIndicator(
                    radius: 110.0,
                    lineWidth: 15.0,
                    percent: _progressPercent,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      _secondToFormatedString(pomodoroTime.inSeconds),
                      style:
                          TextStyle(fontSize: 35, color: colorScheme.onPrimary),
                    ),
                    progressColor: statusDescription[pomodoroStatus]![1],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    statusDescription[pomodoroStatus]![0],
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.45,
                    child: ElevatedButton(
                      onPressed: _startPomodoroCountdown,
                      child: Text(_btnStart),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.45,
                    child: ElevatedButton(
                      onPressed: resetTimer,
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startPomodoroCountdown() {
    if (pomodoroTimeEntered.inSeconds != 0) {
      if (_btnStart == 'Start') {
        countdownTimer =
            Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
        setState(() {
          pomodoroStatus = PomodoroStatus.runingPomodoro;
          pomodoroTime = pomodoroTimeEntered;
          _btnStart = 'Running';
        });
      }
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    setState(() {
      final seconds = pomodoroTime.inSeconds - reduceSecondsBy;
      (seconds < 0)
          ? {
              countdownTimer!.cancel(),
              pomodoroStatus = PomodoroStatus.setFinished,
              _btnStart = 'Start',
              player.play(AssetSource('bicycle-bell-155622.mp3')),
            }
          : {
              pomodoroTime = Duration(seconds: seconds),
              _progressPercent =
                  1 - pomodoroTime.inSeconds / pomodoroTimeEntered.inSeconds
            };
    });
  }

  void resetTimer() {
    setState(() {
      countdownTimer!.cancel();
      pomodoroTime = const Duration(minutes: 0);
      _btnStart = 'Start';
      pomodoroStatus = PomodoroStatus.resetedPomodoro;
      _progressPercent = 0.0;
      context.read<PomodoroDurationCubit>().durationInput('');
    });
  }
}

String _secondToFormatedString(int seconds) {
  String remainingSecondsFormated = '';
  String remainingMinutesFormated = '';
  String remainingHoursFormated = '';
  String timeString = "";
  int nbHours = seconds ~/ 3600;
  int nbMinutes = (seconds - nbHours * 3600) ~/ 60;
  int nbSeconds = seconds % 60;
  (nbSeconds < 10)
      ? remainingSecondsFormated = '0$nbSeconds'
      : remainingSecondsFormated = nbSeconds.toString();
  (nbMinutes < 10)
      ? remainingMinutesFormated = '0$nbMinutes'
      : remainingMinutesFormated = nbMinutes.toString();

  (nbHours == 0)
      ? {
          remainingHoursFormated = '',
          timeString = '$remainingMinutesFormated : $remainingSecondsFormated'
        }
      : {
          remainingHoursFormated = nbHours.toString(),
          timeString =
              '$remainingHoursFormated : $remainingMinutesFormated : $remainingSecondsFormated'
        };

  return timeString;
}
