import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/features/theme/bloc/theme_state.dart';
import 'package:pet4u/features/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool? isDark;
  ThemeBloc() : super(ThemeLoadingState()) {
    on<ThemeInitEvent>((event, emit) async {
      Completer<ThemeState> completer = Completer();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isDark = prefs.getBool('isDark') ?? false;
      completer.complete(ThemeChangedState(currentTheme));
      emit(await completer.future);
    });
    on<ThemeChangeEvent>((event, emit) async {
      Completer<ThemeState> completer = Completer();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', !isDark!);
      isDark = !isDark!;
      completer.complete(ThemeChangedState(currentTheme));
      emit(await completer.future);
    });
    on<ThemeGetEvent>((event, emit) {
      emit(ThemeCurrentState(currentTheme));
    });
  }
  ThemeData get currentTheme {
    return isDark! ? customDarkTheme : customLightTheme;
  }
}
