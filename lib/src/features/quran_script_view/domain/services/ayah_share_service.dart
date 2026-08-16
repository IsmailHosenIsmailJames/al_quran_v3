import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_text_preser.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:share_plus/share_plus.dart";

/// Service responsible for generating shareable formatted text for Ayahs and triggering native share.
class AyahShareService {
  /// Generates formatted text for a list of [ayahKeys] (e.g. `['1:1', '1:2']`).
  static Future<String> generateAyahsShareText({
    required BuildContext context,
    required List<String> ayahKeys,
    required QuranScriptType quranScriptType,
    required bool circleJojom,
  }) async {
    final StringBuffer buffer = StringBuffer();

    // Sort ayah keys chronologically if possible
    final sortedKeys = List<String>.from(ayahKeys)..sort((a, b) {
      final aParts = a.split(":").map((e) => int.tryParse(e) ?? 0).toList();
      final bParts = b.split(":").map((e) => int.tryParse(e) ?? 0).toList();
      if (aParts.first != bParts.first) {
        return aParts.first.compareTo(bParts.first);
      }
      return (aParts.length > 1 && bParts.length > 1)
          ? aParts[1].compareTo(bParts[1])
          : 0;
    });

    for (final ayahKey in sortedKeys) {
      final parts = ayahKey.split(":");
      final surahIdStr = parts.first;
      final ayahIdStr = parts.length > 1 ? parts.last : "1";

      final surahMeta = metaDataSurah[surahIdStr];
      final surahInfoModel = surahMeta != null
          ? SurahInfoModel.fromMap(surahMeta)
          : null;

      final surahName = surahInfoModel != null
          ? getSurahName(context, surahInfoModel.id)
          : "Surah $surahIdStr";

      // 1. Fetch Arabic Words
      final quranScriptWord = QuranScriptFunction.getWordListOfAyah(
        quranScriptType,
        surahIdStr,
        ayahIdStr,
        circleJojom: circleJojom,
      );
      final plainArabicText = getPlainTextAyahFromTajweedWords(
        List<String>.from(quranScriptWord),
      );

      // 2. Fetch Translations & Footnotes
      final List<TranslationOfAyah> translationsList =
          await QuranTranslationFunction.getTranslation(ayahKey);

      final List<ResourcesModel?> translationBooks = translationsList
          .map<ResourcesModel?>((e) => e.bookInfo)
          .toList();

      final List<String> translationTexts = translationsList
          .map<String>(
            (e) => e.translation?["t"]?.toString() ?? "Translation Not Found",
          )
          .map((e) => e.replaceAll(">", "> "))
          .toList();

      final List<Map> footNoteList = translationsList
          .map<Map>((e) => (e.translation?["f"] as Map?) ?? {})
          .toList();

      final List<Map<int, String>> footNoteAsStringMap = [];
      footNoteList.forEachIndexed((footNote, index) {
        String footNoteAsString = "\n";
        if (footNote.isNotEmpty) {
          footNote.forEach((key, value) {
            footNoteAsString += "$key. $value\n";
          });
        }
        footNoteAsStringMap.add({index: footNoteAsString});
      });

      final StringBuffer translationBuffer = StringBuffer();
      for (int i = 0; i < translationBooks.length; i++) {
        if (i < translationTexts.length) {
          translationBuffer.writeln(translationTexts[i]);
        }
        if (i < footNoteAsStringMap.length) {
          footNoteAsStringMap[i].forEach((key, value) {
            if (value.trim().isNotEmpty) {
              translationBuffer.write("$key. $value");
            }
          });
        }
      }

      // 3. Format into entry
      buffer.writeln("━━━━━━━━━━━━━━━━━━━━");
      buffer.writeln("$surahName • $ayahKey");
      buffer.writeln("━━━━━━━━━━━━━━━━━━━━");
      buffer.writeln(plainArabicText);
      buffer.writeln();
      if (translationBuffer.isNotEmpty) {
        buffer.writeln("Translation:");
        buffer.writeln(translationBuffer.toString().trim());
      }
      buffer.writeln();
    }

    return buffer.toString().trim();
  }

  /// Shares the selected Ayahs directly via system share dialog.
  static Future<void> shareAyahs({
    required BuildContext context,
    required List<String> ayahKeys,
    required QuranScriptType quranScriptType,
    required bool circleJojom,
  }) async {
    if (ayahKeys.isEmpty) return;

    final text = await generateAyahsShareText(
      context: context,
      ayahKeys: ayahKeys,
      quranScriptType: quranScriptType,
      circleJojom: circleJojom,
    );

    if (text.isNotEmpty) {
      await SharePlus.instance.share(ShareParams(text: text));
    }
  }
}
