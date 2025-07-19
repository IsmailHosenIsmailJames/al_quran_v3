import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/functions/filter/search_pattern_in_text.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

List<SurahInfoModel> getFilteredSurah(
  BuildContext context,
  String filterString,
) {
  List<SurahInfoModel> surahInfoList =
      metaDataSurah.values.map((e) => SurahInfoModel.fromMap(e)).toList();
  Map<double, SurahInfoModel> mapOfFilteredSurah = {};
  if (filterString.isNotEmpty) {
    for (int i = 0; i < surahInfoList.length; i++) {
      double matched = searchPatternInText(
        filterString.toLowerCase(),
        "${surahInfoList[i].id} ${getSurahName(context, surahInfoList[i].id)} ${NumberFormat.decimalPattern(context.read<LanguageCubit>().state.locale.languageCode).format(surahInfoList[i].id)}"
            .toLowerCase(),
      );
      if (matched > 40) {
        mapOfFilteredSurah[matched] = surahInfoList[i];
      }
    }
  } else {
    return surahInfoList;
  }
  List<double> matchedValue = mapOfFilteredSurah.keys.toList();
  matchedValue.sort((a, b) => b.compareTo(a));
  List<SurahInfoModel> surahInfoToReturn = [];
  for (var element in matchedValue) {
    surahInfoToReturn.add(mapOfFilteredSurah[element]!);
  }
  return surahInfoToReturn;
}
