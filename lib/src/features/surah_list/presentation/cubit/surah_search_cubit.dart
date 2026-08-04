import "dart:async";

import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/surah_list/presentation/cubit/surah_search_state.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/utils/filter/search_pattern_in_text.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

class SurahSearchCubit extends Cubit<SurahSearchState> {
  final BuildContext context;
  Timer? _debounceTimer;

  static const _debounceDuration = Duration(milliseconds: 300);

  /// Pre-parsed list of all 114 surahs, built once.
  late final List<SurahInfoModel> _allSurahs;

  SurahSearchCubit(this.context)
      : super(const SurahSearchState()) {
    _allSurahs = metaDataSurah.values
        .map((e) => SurahInfoModel.fromMap(e))
        .toList();
    // Emit initial state with all surahs
    emit(SurahSearchState(filteredSurahs: _allSurahs));
  }

  /// Called on every keystroke. Debounces before filtering.
  void onSearchChanged(String query) {
    final trimmed = query.trim();

    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      // Immediately clear filter when search is emptied
      emit(SurahSearchState(query: "", filteredSurahs: _allSurahs));
      return;
    }

    // Emit the query immediately (for the text field) but debounce the filter
    _debounceTimer = Timer(_debounceDuration, () {
      _performSearch(trimmed);
    });
  }

  void _performSearch(String filterString) {
    final String query = filterString.toLowerCase();
    List<MapEntry<double, SurahInfoModel>> scoredSurahs = [];

    for (int i = 0; i < _allSurahs.length; i++) {
      double matched = searchPatternInText(
        query,
        "${_allSurahs[i].id} ${getSurahName(context, _allSurahs[i].id)} ${NumberFormat.decimalPattern(context.read<LanguageCubit>().state.locale.languageCode).format(_allSurahs[i].id)}"
            .toLowerCase(),
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
