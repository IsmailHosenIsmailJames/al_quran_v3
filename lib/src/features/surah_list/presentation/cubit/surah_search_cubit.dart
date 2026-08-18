import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/surah_search_engine.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class SurahSearchCubit extends Cubit<SurahSearchState> {
  /// Pre-parsed list of all 114 surahs.
  late final List<SurahInfoModel> _allSurahs;

  SurahSearchCubit() : super(const SurahSearchState()) {
    _allSurahs = metaDataSurah.values
        .map((e) => SurahInfoModel.fromMap(e))
        .toList();
    // Emit initial state with all surahs
    emit(SurahSearchState(filteredSurahs: _allSurahs));
  }

  /// Called on search input. Performs instant <0.1ms multi-language search.
  void onSearchChanged(String query, {String? languageCode}) {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      emit(SurahSearchState(query: "", filteredSurahs: _allSurahs));
      return;
    }

    final results = SurahSearchEngine.instance.search(
      trimmed,
      languageCode: languageCode,
    );

    emit(SurahSearchState(
      query: query,
      filteredSurahs: results,
    ));
  }
}

