import "dart:ui";

import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeFunctions {
  static SharedPreferences? preferences;

  static Future<void> initThemeFunction() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    systemChromeSetting(themeMode);
    await preferences!.setString("app_theme_mode", themeMode.toString());
  }

  static ThemeMode loadThemeMode() {
    assert(preferences != null, "Theme Function need to be init first");
    final String? savedThemeName = preferences!.getString("app_theme_mode");
    ThemeMode themeMode =
        savedThemeName == null
            ? ThemeMode.system
            : ThemeMode.values.firstWhere(
              (e) => e.toString() == savedThemeName,
            );
    systemChromeSetting(themeMode);
    return themeMode;
  }

  static void systemChromeSetting(ThemeMode themeMode) {
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

  static Color? getColorFromDB() {
    assert(preferences != null, "Theme Function need to be init first");
    int? colorValue = preferences!.getInt("color_primary");
    return colorValue == null ? null : Color(colorValue);
  }

  static Future<void> setColorToDB(Color color) async {
    assert(preferences != null, "Theme Function need to be init first");
    int colorString = color.toARGB32();
    preferences!.setInt("color_primary", colorString);
  }

  static ThemeState getThemeState(Color primary, ThemeMode mode) {
    return ThemeState(
      themeMode: mode,
      primary: primary,
      primaryShade100: primary.withValues(alpha: 0.1),
      primaryShade200: primary.withValues(alpha: 0.2),
      primaryShade300: primary.withValues(alpha: 0.3),
      secondary: Colors.orange,
      mutedGray: Colors.grey.withValues(alpha: 0.2),
    );
  }
}
