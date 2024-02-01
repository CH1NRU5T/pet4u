import 'package:flutter/material.dart';
import 'package:pet4u/constants/custom_colors.dart';

ThemeData customTheme = ThemeData(
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
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);
