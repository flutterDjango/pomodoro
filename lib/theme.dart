import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 255, 152, 0),
  background: const Color.fromARGB(255, 165, 162, 170),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    backgroundColor: colorScheme.primary,
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: colorScheme.primary,
          fontSize: 25,
        ),
      ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    counterStyle: TextStyle(color: colorScheme.onPrimary)
  )
);
