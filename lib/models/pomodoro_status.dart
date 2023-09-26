import 'package:pomodoro/theme.dart';

enum PomodoroStatus {
  runingPomodoro,
  resetedPomodoro,
  readyToStart,
  setFinished,
}

Map<PomodoroStatus, List<dynamic>> statusDescription = {
  PomodoroStatus.runingPomodoro: [
    "Pomodoro is running ...",
    colorScheme.onPrimary
  ],
  PomodoroStatus.resetedPomodoro: [
    "Pomodoro has been reseted",
    colorScheme.primary
  ],
  PomodoroStatus.readyToStart: [
    "Pomodoro is ready to start !",
    colorScheme.primary
  ],
  PomodoroStatus.setFinished: ["Time is up.", colorScheme.primary]
};
