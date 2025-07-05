import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

import "dart:convert";

class AppLanguage {
  final String english;
  final String native;
  final String code;

  AppLanguage({
    required this.english,
    required this.native,
    required this.code,
  });

  AppLanguage copyWith({String? english, String? native, String? code}) =>
      AppLanguage(
        english: english ?? this.english,
        native: native ?? this.native,
        code: code ?? this.code,
      );

  factory AppLanguage.fromJson(String str) =>
      AppLanguage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppLanguage.fromMap(Map<String, dynamic> json) => AppLanguage(
    english: json["English"],
    native: json["Native"],
    code: json["Code"],
  );

  Map<String, dynamic> toMap() => {
    "English": english,
    "Native": native,
    "Code": code,
  };
}

// Define the state for LanguageCubit
class LanguageState {
  final Locale locale;
  final AppLanguage appLanguage;
  LanguageState(this.locale, this.appLanguage);
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale)
    : super(
        LanguageState(
          initialLocale,
          AppLanguage.fromMap(
            usedAppLanguageMap.firstWhere(
              (element) => element["Code"] == initialLocale.languageCode,
            ),
          ),
        ),
      );

  static const String _selectedLanguageCodeKey = "selectedLanguageCode";

  // List of supported languages
  final List<AppLanguage> supportedLanguages =
      usedAppLanguageMap
          .map(
            (e) => AppLanguage(
              english: e["English"]!,
              native: e["Native"]!,
              code: e["Code"]!,
            ),
          )
          .toList();

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLanguageCodeKey, languageCode);
    Map<String, dynamic> language = usedAppLanguageMap.firstWhere(
      (element) => element["Code"] == languageCode,
    );
    emit(LanguageState(Locale(languageCode), AppLanguage.fromMap(language)));
  }

  static Future<Locale> getInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageCodeKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return const Locale("en");
  }
}
