import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a simple model for Language
class Language {
  final String name;
  final String code;

  Language(this.name, this.code);
}

// Define the state for LanguageCubit
class LanguageState {
  final Locale locale;
  LanguageState(this.locale);
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale) : super(LanguageState(initialLocale));

  static const String _selectedLanguageCodeKey = 'selectedLanguageCode';

  // List of supported languages
  final List<Language> supportedLanguages = [
    Language('English', 'en'),
    Language('বাংলা (Bengali)', 'bn'),
    Language('العربية (Arabic)', 'ar'),
    Language('हिन्दी (Hindi)', 'hi'),
    Language('اردو (Urdu)', 'ur'),
    Language('Español (Spanish)', 'es'),
  ];

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageCodeKey, languageCode);
    emit(LanguageState(Locale(languageCode)));
  }

  static Future<Locale> getInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageCodeKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    // Fallback to English if no preference is set
    // Or, could use WidgetsBinding.instance.window.locale for system default
    return const Locale('en');
  }
}
