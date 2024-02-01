import 'package:flutter/material.dart';
import 'package:pet4u/constants/custom_colors.dart';

ThemeData customLightTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: CustomColors.scaffoldBackgroundColorLight,
    selectedItemColor: CustomColors.scaffoldBackgroundColorDark,
    unselectedItemColor: Colors.grey,
    elevation: 0,
  ),
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
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: CustomColors.textButtonBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
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
      disabledBackgroundColor: Colors.grey,
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
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: CustomColors.scaffoldBackgroundColorDark,
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColorDark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.scaffoldBackgroundColorDark,
  ),
  useMaterial3: true,
);
