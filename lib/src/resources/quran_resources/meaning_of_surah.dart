import "dart:convert";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Map<String, dynamic> surahNameLocalization = {};
Map<String, dynamic> surahMeaningLocalization = {};

Future<void> loadMetaSurah() async {
  if (surahNameLocalization.isEmpty) {
    surahNameLocalization = jsonDecode(
      await rootBundle.loadString(
        "assets/meta_data/surah_name_localization.json",
      ),
    );
  }

  if (surahMeaningLocalization.isEmpty) {
    surahMeaningLocalization = jsonDecode(
      await rootBundle.loadString(
        "assets/meta_data/surah_meaning_localization.json",
      ),
    );
  }
}

String getSurahName(BuildContext? context, int index) {
  context ??= navigatorKey.currentContext!;
  Locale locale = context.read<LanguageCubit>().state.locale;
  return List<String>.from(
    surahNameLocalization[locale.languageCode] ?? surahNameLocalization["en"],
  )[index - 1];
}

String getSurahNameArabic(int index) {
  return List<String>.from(surahNameLocalization["ar"])[index - 1];
}

String getSurahMeaning(BuildContext? context, int index) {
  context ??= navigatorKey.currentContext!;
  Locale locale = context.read<LanguageCubit>().state.locale;
  return List<String>.from(
    surahMeaningLocalization[locale.languageCode] ??
        surahNameLocalization["en"],
  )[index - 1];
}
