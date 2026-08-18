import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/words/show_popup_of_word.dart";
import "package:flutter/material.dart";

import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";

void showPopupWordFunction({
  required BuildContext context,
  required List<String> wordKeys,
  required int initWordIndex,
  required List wordByWordList,
}) {
  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah[wordKeys.first.split(":").first]!,
  );
  showModalBottomSheet(
    context: context,
    builder:
        (context) => ShowPopupOfWord(
          wordKeys: wordKeys,
          initWordIndex: initWordIndex,
          surahInfoModel: surahInfoModel,
          wordByWord: wordByWordList,
        ),
  );
}
