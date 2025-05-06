import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script_words/show_popup_of_word.dart';
import 'package:flutter/material.dart';

void showPopupWordFunction({
  required BuildContext context,
  required String wordKey,
  required String word,
  required QuranScriptType scriptCategory,
}) {
  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah[wordKey.split(':').first],
  );
  showModalBottomSheet(
    context: context,
    builder:
        (context) => ShowPopupOfWord(
          wordKey: wordKey,
          word: word,
          scriptCategory: scriptCategory,
          surahInfoModel: surahInfoModel,
        ),
  );
}
