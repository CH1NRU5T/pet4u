import 'package:flutter/material.dart';
import 'package:pet4u/constants/custom_colors.dart';

ThemeData customLightTheme = ThemeData(
  chipTheme: const ChipThemeData(
    selectedColor: Colors.red,
    padding: EdgeInsets.all(8),
    shape: StadiumBorder(),
    labelStyle: TextStyle(color: Colors.black),
    brightness: Brightness.dark,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: CustomColors.textButtonBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    scrolledUnderElevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.scaffoldBackgroundColorLight,
  ),
  useMaterial3: true,
);
ThemeData customDarkTheme = ThemeData(
  chipTheme: const ChipThemeData(
    selectedColor: Colors.red,
    padding: EdgeInsets.all(8),
    shape: StadiumBorder(),
    labelStyle: TextStyle(color: Colors.black),
    brightness: Brightness.dark,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: CustomColors.textButtonBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    scrolledUnderElevation: 0,
  ),
  scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColorDark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.scaffoldBackgroundColorDark,
  ),
  useMaterial3: true,
);