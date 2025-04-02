import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themePreferenceKey = 'app_theme_mode';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final String? savedThemeName = _prefs.getString(_themePreferenceKey);
    ThemeMode initialMode = ThemeMode.system;

    if (savedThemeName != null) {
      try {
        initialMode = ThemeMode.values.firstWhere(
          (e) => e.toString() == savedThemeName,
        );
      } catch (e) {
        log(
          "Error loading theme: Invalid value '$savedThemeName'. Using system default.",
          name: 'ThemeCubit',
        );
        initialMode = ThemeMode.system;
      }
    }
    _systemChromeSetting(initialMode);

    emit(initialMode);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    if (state != themeMode) {
      _systemChromeSetting(themeMode);
      emit(themeMode);

      try {
        await _prefs.setString(_themePreferenceKey, themeMode.toString());
        log('Theme saved: ${themeMode.toString()}', name: 'ThemeCubit');
      } catch (e) {
        log('Error saving theme: $e', name: 'ThemeCubit');
      }
    }
  }

  void _systemChromeSetting(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else if (themeMode == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else {
      if (PlatformDispatcher.instance.platformBrightness == Brightness.dark) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    }
  }
}
