sealed class ThemeEvent {}

class ThemeChangeEvent extends ThemeEvent {
  ThemeChangeEvent();
}

class ThemeInitEvent extends ThemeEvent {}

class ThemeGetEvent extends ThemeEvent {}
