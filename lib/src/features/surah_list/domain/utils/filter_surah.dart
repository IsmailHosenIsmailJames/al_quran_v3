import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/surah_search_engine.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// High-performance multi-language filtered Surah lookup.
List<SurahInfoModel> getFilteredSurah(
  BuildContext context,
  String filterString,
) {
  String? langCode;
  try {
    langCode = context.read<LanguageCubit>().state.locale.languageCode;
  } catch (_) {}

  return SurahSearchEngine.instance.search(
    filterString,
    languageCode: langCode,
  );
}


