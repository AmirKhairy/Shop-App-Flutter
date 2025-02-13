import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    foregroundColor: Colors.black,
    titleTextStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 25,
      weight: 500,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 249, 89, 0),
    selectedItemColor: Color.fromARGB(255, 35, 59, 93),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    unselectedItemColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
    type: BottomNavigationBarType.fixed,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 249, 89, 0),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 35, 59, 93),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  hintColor: Colors.grey,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      animationDuration: Duration(milliseconds: 250),
      iconColor: WidgetStatePropertyAll(
        Colors.black,
      ),
    ),
  ),
  primaryColor: const Color.fromARGB(255, 249, 89, 0),
  primaryColorLight: const Color.fromARGB(255, 249, 89, 0),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color.fromARGB(255, 249, 89, 0),
    linearMinHeight: 5,
    linearTrackColor: Color.fromARGB(255, 249, 89, 0),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color.fromARGB(255, 249, 89, 0),
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Color.fromARGB(255, 249, 89, 0),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.white38,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 249, 89, 0),
      ),
    ),
  ),
  hoverColor:
      const Color.fromARGB(255, 35, 59, 93), //  for the button background color
  cardColor: Colors.white, // for the product item background color
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 35, 59, 93),
    foregroundColor: Color.fromARGB(255, 249, 89, 0),
  ),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 35, 59, 93),
    surfaceTintColor: Color.fromARGB(255, 35, 59, 93),
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
      weight: 500,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 35, 59, 93),
    selectedItemColor: Color.fromARGB(255, 249, 89, 0),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    unselectedItemColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
    type: BottomNavigationBarType.fixed,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 35, 59, 93),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 249, 89, 0),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  hintColor: Colors.grey,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      animationDuration: Duration(milliseconds: 250),
      iconColor: WidgetStatePropertyAll(
        Colors.white,
      ),
    ),
  ),
  primaryColor: const Color.fromARGB(255, 35, 59, 93),
  primaryColorLight: const Color.fromARGB(255, 35, 59, 93),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color.fromARGB(255, 249, 89, 0),
    linearMinHeight: 5,
    linearTrackColor: Color.fromARGB(255, 249, 89, 0),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 35, 59, 93),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color.fromARGB(255, 249, 89, 0),
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Color.fromARGB(255, 249, 89, 0),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.white38,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 249, 89, 0),
      ),
    ),
  ),
  hoverColor: Colors.white, //  for the button background color
  cardColor: const Color.fromARGB(
      255, 35, 59, 93), // for the product item background color
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 249, 89, 0),
    foregroundColor: Color.fromARGB(255, 35, 59, 93),
  ),
);
