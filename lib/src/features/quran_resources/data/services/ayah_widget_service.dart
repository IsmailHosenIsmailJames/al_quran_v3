import "dart:convert";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/quran_resources/data/curated_ayahs.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_text_preser.dart";
import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:home_widget/home_widget.dart";
import "package:intl/intl.dart";

/// Service responsible for synchronizing Quran Ayah data with native
/// Home Screen and Lock Screen widgets on Android and iOS.
class AyahWidgetService {
  static const String appGroupId = "group.com.ismail_hosen_james.al_bayan_quran";
  static const String smallWidgetAndroid = "AyahWidgetSmallProvider";
  static const String mediumWidgetAndroid = "AyahWidgetMediumProvider";
  static const String largeWidgetAndroid = "AyahWidgetLargeProvider";
  static const String iosWidget = "AyahWidget";

  static bool _isInitialized = false;

  /// Initializes HomeWidget configuration (App Group ID for iOS).
  static Future<void> init() async {
    if (_isInitialized) return;
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      _isInitialized = true;
    } catch (e) {
      debugPrint("AyahWidgetService.init error: $e");
    }
  }

  /// Calculates and updates all active Quran Ayah widgets.
  static Future<void> updateWidgets({
    DateTime? currentTime,
    int? customSurah,
    int? customAyah,
  }) async {
    try {
      await init();

      final now = currentTime ?? DateTime.now();
      await QuranScriptFunction.loadScript(QuranScriptType.uthmani);

      // Pre-warm / ensure Hive box for translations
      if (!Hive.isBoxOpen("user")) {
        await Hive.openBox("user");
      }

      // Generate 7-day Ayah timeline items
      final timelineDays = <Map<String, dynamic>>[];
      final dayOfYear = int.parse(DateFormat("D").format(now));

      Map<String, dynamic>? todayPayload;

      for (int i = 0; i < 7; i++) {
        final dayDate = DateTime(now.year, now.month, now.day + i);
        int surah;
        int ayah;
        String? theme;

        if (i == 0 && customSurah != null && customAyah != null) {
          surah = customSurah;
          ayah = customAyah;
          theme = "Selected Verse";
        } else {
          final curatedIndex = (dayOfYear + i) % curatedAyahsList.length;
          final item = curatedAyahsList[curatedIndex];
          surah = item.surah;
          ayah = item.ayah;
          theme = item.theme;
        }

        final surahIndex = surah - 1;
        final surahName = (surahIndex >= 0 && surahIndex < canonicalSurahTransliterations.length)
            ? canonicalSurahTransliterations[surahIndex]
            : "Surah $surah";
        final surahArabicName = (surahIndex >= 0 && surahIndex < canonicalSurahArabicNames.length)
            ? canonicalSurahArabicNames[surahIndex]
            : "";

        // Revelation place & total verses
        final surahMeta = metaDataSurah["$surah"];
        final isMakkah = surahMeta?["rp"] == "makkah";
        final versesCount = surahMeta?["vc"] ?? 0;
        final surahType = "${isMakkah ? "Meccan" : "Medinan"} • $versesCount Verses";

        // Arabic text (clean plain Arabic for widgets without raw HTML tajweed tags)
        String arabicText = "";
        try {
          final words = QuranScriptFunction.getWordListOfAyah(
            QuranScriptType.uthmani,
            "$surah",
            "$ayah",
            circleJojom: false,
          );
          arabicText = getPlainTextAyahFromTajweedWords(words);
          if (arabicText.isEmpty || arabicText.contains("<")) {
            arabicText = words
                .join(" ")
                .replaceAll(RegExp(r"<[^>]*>"), "")
                .replaceAll(RegExp(r"\s+"), " ")
                .trim();
          }
        } catch (_) {
          arabicText = "";
        }

        // Translation text
        String translationText = "";
        try {
          final translations = await QuranTranslationFunction.getTranslation("$surah:$ayah");
          if (translations.isNotEmpty && translations.first.translation != null) {
            final t = translations.first.translation!["t"];
            if (t != null && t is String && !t.startsWith("Translation Not Found")) {
              translationText = t;
            }
          }
        } catch (_) {}

        if (translationText.isEmpty) {
          translationText = _fallbackTranslation(surah, ayah);
        }

        final dayEntry = {
          "date": dayDate.toIso8601String(),
          "surah_id": surah,
          "ayah_number": ayah,
          "surah_name": surahName,
          "surah_arabic_name": surahArabicName,
          "reference": "$surah:$ayah",
          "surah_type": surahType,
          "arabic_text": arabicText,
          "translation_text": translationText,
          "theme": theme ?? "Daily Verse",
        };

        timelineDays.add(dayEntry);
        if (i == 0) {
          todayPayload = dayEntry;
        }
      }

      if (todayPayload == null) return;

      // 1. Save Android Widget fields
      final isDark = PlatformDispatcher.instance.platformBrightness == Brightness.dark;
      await HomeWidget.saveWidgetData<bool>("ayah_is_dark_mode", isDark);

      await HomeWidget.saveWidgetData<String>("ayah_surah_name", todayPayload["surah_name"]);
      await HomeWidget.saveWidgetData<String>("ayah_surah_arabic_name", todayPayload["surah_arabic_name"]);
      await HomeWidget.saveWidgetData<int>("ayah_surah_id", todayPayload["surah_id"]);
      await HomeWidget.saveWidgetData<int>("ayah_number", todayPayload["ayah_number"]);
      await HomeWidget.saveWidgetData<String>("ayah_reference", todayPayload["reference"]);
      await HomeWidget.saveWidgetData<String>("ayah_surah_type", todayPayload["surah_type"]);
      await HomeWidget.saveWidgetData<String>("ayah_arabic_text", todayPayload["arabic_text"]);
      await HomeWidget.saveWidgetData<String>("ayah_translation_text", todayPayload["translation_text"]);
      await HomeWidget.saveWidgetData<String>("ayah_theme", todayPayload["theme"]);

      // 2. Save 7-Day JSON timeline for iOS WidgetKit
      final timelinePayload = {
        "days": timelineDays,
      };

      await HomeWidget.saveWidgetData<String>(
        "ayah_timeline_json",
        jsonEncode(timelinePayload),
      );

      // 3. Notify native widget engines to re-render
      await HomeWidget.updateWidget(
        androidName: smallWidgetAndroid,
        iOSName: iosWidget,
      );
      await HomeWidget.updateWidget(
        androidName: mediumWidgetAndroid,
        iOSName: iosWidget,
      );
      await HomeWidget.updateWidget(
        androidName: largeWidgetAndroid,
        iOSName: iosWidget,
      );
    } catch (e) {
      debugPrint("AyahWidgetService.updateWidgets error: $e");
    }
  }

  /// Clean English fallback translations for prominent verses
  static String _fallbackTranslation(int surah, int ayah) {
    if (surah == 1 && ayah == 1) return "In the name of Allah, the Entirely Merciful, the Especially Merciful.";
    if (surah == 1 && ayah == 2) return "[All] praise is [due] to Allah, Lord of the worlds.";
    if (surah == 2 && ayah == 152) return "So remember Me; I will remember you. And be grateful to Me and do not deny Me.";
    if (surah == 2 && ayah == 186) return "And when My servants ask you concerning Me, indeed I am near. I respond to the invocation of the supplicant when he calls upon Me.";
    if (surah == 2 && ayah == 255) return "Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence.";
    if (surah == 2 && ayah == 286) return "Allah does not charge a soul except [with that within] its capacity.";
    if (surah == 3 && ayah == 139) return "So do not weaken and do not grieve, and you will be superior if you are [true] believers.";
    if (surah == 3 && ayah == 159) return "And when you have decided, then rely upon Allah. Indeed, Allah loves those who rely [upon Him].";
    if (surah == 13 && ayah == 28) return "Unquestionably, by the remembrance of Allah hearts are assured.";
    if (surah == 14 && ayah == 7) return "If you are grateful, I will surely increase you [in favor].";
    if (surah == 94 && (ayah == 5 || ayah == 6)) return "Indeed, with hardship [will be] ease.";
    if (surah == 112 && ayah == 1) return "Say, 'He is Allah, [who is] One.'";
    return "Reflect upon the words of your Lord and find peace in His guidance.";
  }
}
