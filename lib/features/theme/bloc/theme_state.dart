import 'package:flutter/material.dart';

sealed class ThemeState {}

class ThemeInit extends ThemeState {}

class ThemeChangedState extends ThemeState {
  final ThemeData themeData;
  ThemeChangedState(this.themeData);
}

class ThemeCurrentState extends ThemeState {
  final ThemeData themeData;
  ThemeCurrentState(this.themeData);
}

class ThemeLoadingState extends ThemeState {}
