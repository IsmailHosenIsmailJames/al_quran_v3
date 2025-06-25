import "package:al_quran_v3/src/screen/settings/theme_settings.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/functions/theme_functions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeFunctions.getThemeState(
          ThemeFunctions.getColorFromDB() ?? defaultPrimary,
          ThemeFunctions.loadThemeMode(),
        ),
      );

  void setTheme(ThemeMode themeMode) async {
    ThemeFunctions.setThemeMode(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

  void changePrimaryColor(Color color) async {
    await ThemeFunctions.setColorToDB(color);
    emit(ThemeFunctions.getThemeState(color, state.themeMode));
  }
}
