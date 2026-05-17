import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';

  ThemeBloc(this._prefs) : super(ThemeState(ThemeMode.system)) {
    on<LoadTheme>((event, emit) {
      final String? themeStr = _prefs.getString(_themeKey);
      if (themeStr != null) {
        final mode = ThemeMode.values.firstWhere(
          (e) => e.toString() == themeStr,
          orElse: () => ThemeMode.system,
        );
        emit(ThemeState(mode));
      }
    });

    on<ChangedTheme>((event, emit) async {
      await _prefs.setString(_themeKey, event.themeMode.toString());
      emit(ThemeState(event.themeMode));
    });
  }
}
