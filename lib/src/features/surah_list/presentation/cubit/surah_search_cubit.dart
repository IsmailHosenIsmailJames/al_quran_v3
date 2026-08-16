import "dart:async";

import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/search_pattern_in_text.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";
import "package:intl/intl.dart";

@injectable
class SurahSearchCubit extends Cubit<SurahSearchState> {
  Timer? _debounceTimer;

  static const _debounceDuration = Duration(milliseconds: 300);

  /// Pre-parsed list of all 114 surahs, built once.
  late final List<SurahInfoModel> _allSurahs;

  SurahSearchCubit()
      : super(const SurahSearchState()) {
    _allSurahs = metaDataSurah.values
        .map((e) => SurahInfoModel.fromMap(e))
        .toList();
    // Emit initial state with all surahs
    emit(SurahSearchState(filteredSurahs: _allSurahs));
  }

  /// Called on every keystroke. Debounces before filtering.
  void onSearchChanged(String query, {String? languageCode}) {
    final trimmed = query.trim();

    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      // Immediately clear filter when search is emptied
      emit(SurahSearchState(query: "", filteredSurahs: _allSurahs));
      return;
    }

    // Emit the query immediately (for the text field) but debounce the filter
    _debounceTimer = Timer(_debounceDuration, () {
      _performSearch(trimmed, languageCode: languageCode);
    });
  }

  void _performSearch(String filterString, {String? languageCode}) {
    final String query = filterString.toLowerCase();
    List<MapEntry<double, SurahInfoModel>> scoredSurahs = [];

    for (int i = 0; i < _allSurahs.length; i++) {
      final surahId = _allSurahs[i].id;
      final surahName = getSurahName(null, surahId);
      final formattedIndex =
          NumberFormat.decimalPattern(languageCode ?? "en").format(surahId);

      double matched = searchPatternInText(
        query,
        "$surahId $surahName $formattedIndex".toLowerCase(),
      );
      if (matched > 0) {
        scoredSurahs.add(MapEntry(matched, _allSurahs[i]));
      }
    }

    scoredSurahs.sort((a, b) => b.key.compareTo(a.key));

    emit(SurahSearchState(
      query: filterString,
      filteredSurahs: scoredSurahs.map((e) => e.value).toList(),
    ));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
