import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:dartx/dartx.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

class LanguageCubit extends Cubit<MyAppLocalization> {
  LanguageCubit(MyAppLocalization initialLocale)
    : super(
        usedAppLanguageMap.firstOrNullWhere(
              (element) =>
                  element.locale.languageCode ==
                  initialLocale.locale.languageCode,
            ) ??
            usedAppLanguageMap.first,
      );

  static const String _selectedLanguageCodeKey = "selectedLanguageCode";

  Future<void> changeLanguage(MyAppLocalization localeInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _selectedLanguageCodeKey,
      localeInfo.locale.languageCode,
    );

    emit(localeInfo);
  }

  static Future<MyAppLocalization> getInitialLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_selectedLanguageCodeKey);
    if (languageCode != null) {
      return usedAppLanguageMap.firstOrNullWhere(
            (element) => element.locale.languageCode == languageCode,
          ) ??
          usedAppLanguageMap.first;
    }
    return usedAppLanguageMap.first;
  }
}
