import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:dartx/dartx.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";
import "package:shared_preferences/shared_preferences.dart";

@injectable
class LanguageCubit extends Cubit<MyAppLocalization> {
  LanguageCubit(@factoryParam MyAppLocalization? initialLocale)
    : super(
        initialLocale != null
            ? (usedAppLanguageMap.firstOrNullWhere(
                  (element) =>
                      element.locale.languageCode ==
                      initialLocale.locale.languageCode,
                ) ??
                usedAppLanguageMap.first)
            : usedAppLanguageMap.first,
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
