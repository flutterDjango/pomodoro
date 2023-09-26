import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/pomodoro_duration_cubit.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroDurationCubit(),
      child: MaterialApp(
        title: 'Pomodoro',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const HomeScreen(),
      ),
    );
  }
}
