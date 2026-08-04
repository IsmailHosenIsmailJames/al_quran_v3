import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/utils/filter/search_pattern_in_text.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

List<SurahInfoModel> getFilteredSurah(
  BuildContext context,
  String filterString,
) {
  List<SurahInfoModel> surahInfoList =
      metaDataSurah.values.map((e) => SurahInfoModel.fromMap(e)).toList();
  if (filterString.isEmpty) {
    return surahInfoList;
  }

  final String query = filterString.toLowerCase();
  List<MapEntry<double, SurahInfoModel>> scoredSurahs = [];

  for (int i = 0; i < surahInfoList.length; i++) {
    double matched = searchPatternInText(
      query,
      "${surahInfoList[i].id} ${getSurahName(context, surahInfoList[i].id)} ${NumberFormat.decimalPattern(context.read<LanguageCubit>().state.locale.languageCode).format(surahInfoList[i].id)}"
          .toLowerCase(),
    );
    if (matched > 0) {
      scoredSurahs.add(MapEntry(matched, surahInfoList[i]));
    }
  }

  scoredSurahs.sort((a, b) => b.key.compareTo(a.key));
  return scoredSurahs.map((e) => e.value).toList();
}

