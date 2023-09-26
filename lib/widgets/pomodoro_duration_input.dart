import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/pomodoro_duration_cubit.dart';

class PomodoroDurationInput extends StatefulWidget {
  const PomodoroDurationInput({super.key});

  @override
  State<PomodoroDurationInput> createState() => _PomodoroDurationInputState();
}

class _PomodoroDurationInputState extends State<PomodoroDurationInput> {
  final TextEditingController _durationInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var resetDuration = context.watch<PomodoroDurationCubit>();
    _durationInputController.text = resetDuration.state ;
    return TextFormField(
        controller: _durationInputController,
        maxLength: 4,
        style: const TextStyle(fontSize: 30),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.timer,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30,
          ),
          labelText: 'Duration in minutes (max 180 mn):',
          labelStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 10),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => (int.tryParse(value) == null ||
                int.tryParse(value)! > 180 ||
                int.tryParse(value)! <= 0)
            ? {
                if (value.isNotEmpty)
                  {
                    _durationInputController.text = '',
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Enter a strictly positive integer less than 180 minutes.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        duration: const Duration(seconds: 4),
                      ),
                    ),
                  }
              }
            : {
                // _durationInputController.text = settingDuration.toString(),
                context.read<PomodoroDurationCubit>().durationInput(value),
              });

    //   Row(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     TextButton(
    //       onPressed: () {
    //         _formKey.currentState!.reset();
    //       },
    //       child: const Text('Reset'),
    //     ),
    //     ElevatedButton(
    //       onPressed: (){},
    //       child: const Text('Add Person'),
    //     ),
    //   ],
    // ),
  }
}
