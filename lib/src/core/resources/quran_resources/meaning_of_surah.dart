import "dart:convert";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

const List<String> canonicalSurahTransliterations = [
  "Al-Fatihah", "Al-Baqarah", "Ali 'Imran", "An-Nisa", "Al-Ma'idah", "Al-An'am",
  "Al-A'raf", "Al-Anfal", "At-Tawbah", "Yunus", "Hud", "Yusuf", "Ar-Ra'd",
  "Ibrahim", "Al-Hijr", "An-Nahl", "Al-Isra", "Al-Kahf", "Maryam", "Taha",
  "Al-Anbya", "Al-Hajj", "Al-Mu'minun", "An-Nur", "Al-Furqan", "Ash-Shu'ara",
  "An-Naml", "Al-Qasas", "Al-'Ankabut", "Ar-Rum", "Luqman", "As-Sajdah",
  "Al-Ahzab", "Saba", "Fatir", "Ya-Sin", "As-Saffat", "Sad", "Az-Zumar",
  "Ghafir", "Fussilat", "Ash-Shuraa", "Az-Zukhruf", "Ad-Dukhan", "Al-Jathiyah",
  "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujurat", "Qaf", "Adh-Dhariyat",
  "At-Tur", "An-Najm", "Al-Qamar", "Ar-Rahman", "Al-Waqi'ah", "Al-Hadid",
  "Al-Mujadila", "Al-Hashr", "Al-Mumtahanah", "As-Saf", "Al-Jumu'ah",
  "Al-Munafiqun", "At-Taghabun", "At-Talaq", "At-Tahrim", "Al-Mulk", "Al-Qalam",
  "Al-Haqqah", "Al-Ma'arij", "Nuh", "Al-Jinn", "Al-Muzzammil", "Al-Muddaththir",
  "Al-Qiyamah", "Al-Insan", "Al-Mursalat", "An-Naba", "An-Nazi'at", "'Abasa",
  "At-Takwir", "Al-Infitar", "Al-Mutaffifin", "Al-Inshiqaq", "Al-Buruj",
  "At-Tariq", "Al-A'la", "Al-Ghashiyah", "Al-Fajr", "Al-Balad", "Ash-Shams",
  "Al-Layl", "Ad-Duhaa", "Ash-Sharh", "At-Tin", "Al-'Alaq", "Al-Qadr",
  "Al-Bayyinah", "Az-Zalzalah", "Al-'Adiyat", "Al-Qari'ah", "At-Takathur",
  "Al-'Asr", "Al-Humazah", "Al-Fil", "Quraysh", "Al-Ma'un", "Al-Kawthar",
  "Al-Kafirun", "An-Nasr", "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas"
];

const List<String> canonicalSurahArabicNames = [
  "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام", "الأعراف",
  "الأنفال", "التوبة", "يونس", "هود", "يوسف", "الرعد", "إبراهيم", "الحجر",
  "النحل", "الإسراء", "الكهف", "مريم", "طه", "الأنبياء", "الحج", "المؤمنون",
  "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت", "الروم", "لقمان",
  "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر",
  "فصّلت", "الشورى", "الزخرف", "الدخان", "الجاثية", "الأحقاف", "محمد", "الفتح",
  "الحجرات", "ق", "الذاريات", "الطور", "النجم", "القمر", "الرحمن", "الواقعة",
  "الحديد", "المجادلة", "الحشر", "الممتحنة", "الصف", "الجمعة", "المنافقون",
  "التغابن", "الطلاق", "التحريم", "الملك", "القلم", "الحاقة", "المعارج", "نوح",
  "الجن", "المزّمّل", "المدّثّر", "القيامة", "الإنسان", "المرسلات", "النبأ",
  "النازعات", "عبس", "التكوير", "الانفطار", "المطفّفين", "الانشقاق", "البروج",
  "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد", "الشمس", "الليل", "الضحى",
  "الشرح", "التين", "العلق", "القدر", "البينة", "الزلزلة", "العاديات", "القارعة",
  "التكاثر", "العصر", "الهمزة", "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون",
  "النصر", "المسد", "الإخلاص", "الفلق", "الناس"
];

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
  if (index < 1 || index > 114) return "Surah $index";

  Locale? locale;
  if (context != null) {
    try {
      locale = context.read<LanguageCubit>().state.locale;
    } catch (_) {}
  } else if (navigatorKey.currentContext != null) {
    try {
      locale = navigatorKey.currentContext!.read<LanguageCubit>().state.locale;
    } catch (_) {}
  }

  final langCode = locale?.languageCode ?? "en";
  try {
    if (surahNameLocalization.isNotEmpty) {
      final list = List<String>.from(
        surahNameLocalization[langCode] ?? surahNameLocalization["en"] ?? [],
      );
      if (index >= 1 && index <= list.length) {
        return list[index - 1];
      }
    }
  } catch (_) {}

  // Fallback to canonical transliterations
  return canonicalSurahTransliterations[index - 1];
}

String getSurahNameArabic(int index) {
  if (index < 1 || index > 114) return "";
  try {
    if (surahNameLocalization.isNotEmpty && surahNameLocalization.containsKey("ar")) {
      return List<String>.from(surahNameLocalization["ar"])[index - 1];
    }
  } catch (_) {}

  return canonicalSurahArabicNames[index - 1];
}

String getSurahMeaning(BuildContext? context, int index) {
  if (index < 1 || index > 114) return "";

  Locale? locale;
  if (context != null) {
    try {
      locale = context.read<LanguageCubit>().state.locale;
    } catch (_) {}
  } else if (navigatorKey.currentContext != null) {
    try {
      locale = navigatorKey.currentContext!.read<LanguageCubit>().state.locale;
    } catch (_) {}
  }

  final langCode = locale?.languageCode ?? "en";
  try {
    if (surahMeaningLocalization.isNotEmpty) {
      final list = List<String>.from(
        surahMeaningLocalization[langCode] ??
            surahMeaningLocalization["en"] ??
            [],
      );
      if (index >= 1 && index <= list.length) {
        return list[index - 1];
      }
    }
  } catch (_) {}

  final fallback = metaDataSurah[index.toString()];
  return fallback?["name_translated"]?.toString() ?? "";
}
