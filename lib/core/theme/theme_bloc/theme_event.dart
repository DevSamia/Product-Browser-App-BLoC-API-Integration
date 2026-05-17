import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ChangedTheme extends ThemeEvent {
  final ThemeMode themeMode;
  ChangedTheme(this.themeMode);
}
