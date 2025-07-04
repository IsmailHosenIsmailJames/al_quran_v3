import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/app_languages/cubit/language_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

class LanguageState {
  final Locale locale;
  LanguageState(this.locale);
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale) : super(LanguageState(initialLocale));

  static const String _selectedLanguageCodeKey = "selectedLanguageCode";

  final List<AppLanguage> supportedLanguages =
      usedAppLanguageMap.map((e) => AppLanguage.fromMap(e)).toList();

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageCodeKey, languageCode);
    emit(LanguageState(Locale(languageCode)));
  }

  static Future<Locale?> getInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageCodeKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }
}
