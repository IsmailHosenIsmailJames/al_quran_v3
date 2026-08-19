import "dart:async";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/search/data/datasources/quran_search_datasource.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:al_quran_v3/src/features/search/domain/usecases/search_quran_usecase.dart";
import "package:al_quran_v3/src/features/search/presentation/cubit/quran_search_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class QuranSearchCubit extends Cubit<QuranSearchState> {
  final QuranSearchDataSource _dataSource;
  final SearchQuranUseCase _useCase;
  Timer? _debounceTimer;

  static const _debounceDuration = Duration(milliseconds: 300);

  QuranSearchCubit(this._dataSource, this._useCase)
      : super(const QuranSearchState()) {
    _init();
  }

  Future<void> _init() async {
    final downloadedTranslations = _dataSource.getDownloadedTranslations();
    final selectedTranslations = await _dataSource.getSelectedTranslations();
    final downloadedTafsirs = _dataSource.getDownloadedTafsirs();
    final selectedTafsirs = await _dataSource.getSelectedTafsirs();
    final history = _dataSource.getSearchHistory();

    // Prepare Arabic script in background
    unawaited(_dataSource.ensureArabicScriptLoaded());

    if (isClosed) return;

    emit(state.copyWith(
      searchHistory: history,
      availableTranslations: downloadedTranslations,
      availableTafsirs: downloadedTafsirs,
      filter: state.filter.copyWith(
        selectedTranslations: selectedTranslations.isNotEmpty
            ? selectedTranslations
            : downloadedTranslations,
        selectedTafsirs: selectedTafsirs.isNotEmpty
            ? selectedTafsirs
            : downloadedTafsirs,
      ),
    ));
  }

  /// Debounced keystroke search handler. Does NOT save intermediate keystrokes to history.
  void onQueryChanged(String query) {
    final trimmed = query.trim();
    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      emit(state.copyWith(
        query: "",
        status: SearchStatus.initial,
        clearResults: true,
      ));
      return;
    }

    emit(state.copyWith(
      query: query,
      status: SearchStatus.loading,
    ));

    _debounceTimer = Timer(_debounceDuration, () {
      _executeSearch(trimmed, saveHistory: false);
    });
  }

  /// Executes search immediately and saves to history (e.g. keyboard submit or history click).
  Future<void> searchImmediate(String query, {bool saveHistory = true}) async {
    final trimmed = query.trim();
    _debounceTimer?.cancel();

    if (trimmed.isEmpty) {
      emit(state.copyWith(
        query: "",
        status: SearchStatus.initial,
        clearResults: true,
      ));
      return;
    }

    emit(state.copyWith(
      query: query,
      status: SearchStatus.loading,
    ));

    await _executeSearch(trimmed, saveHistory: saveHistory);
  }

  /// Manually save an active query to history (e.g. when user clicks on a search result).
  Future<void> saveQueryToHistory(String query) async {
    final trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      await _dataSource.addSearchHistory(trimmed);
      if (isClosed) return;
      emit(state.copyWith(
        searchHistory: _dataSource.getSearchHistory(),
      ));
    }
  }

  /// Changes the search scope tab (All, Translations, Arabic, Tafsir, Surahs).
  void onScopeChanged(SearchScope scope) {
    if (state.filter.scope == scope) return;

    final updatedFilter = state.filter.copyWith(scope: scope);
    emit(state.copyWith(filter: updatedFilter));

    if (state.query.trim().isNotEmpty) {
      _executeSearch(state.query.trim(), saveHistory: false);
    }
  }

  /// Updates full filter criteria.
  void updateFilter(SearchFilterModel newFilter) {
    emit(state.copyWith(filter: newFilter));

    if (state.query.trim().isNotEmpty) {
      _executeSearch(state.query.trim(), saveHistory: false);
    }
  }

  /// Quick toggle of a translation resource in the active filter.
  void toggleTranslation(ResourcesModel book) {
    final list = List<ResourcesModel>.from(state.filter.selectedTranslations);
    final exists = list.any((b) => b.fullPath == book.fullPath);
    if (exists) {
      if (list.length > 1) {
        list.removeWhere((b) => b.fullPath == book.fullPath);
      }
    } else {
      list.add(book);
    }
    updateFilter(state.filter.copyWith(selectedTranslations: list));
  }

  /// Quick toggle of a tafsir resource in the active filter.
  void toggleTafsir(ResourcesModel book) {
    final list = List<ResourcesModel>.from(state.filter.selectedTafsirs);
    final exists = list.any((b) => b.fullPath == book.fullPath);
    if (exists) {
      if (list.length > 1) {
        list.removeWhere((b) => b.fullPath == book.fullPath);
      }
    } else {
      list.add(book);
    }
    updateFilter(state.filter.copyWith(selectedTafsirs: list));
  }

  Future<void> _executeSearch(String query, {bool saveHistory = false}) async {
    try {
      final results = await _useCase.execute(
        query: query,
        filter: state.filter,
      );

      if (isClosed) return;

      List<String> updatedHistory = state.searchHistory;
      if (saveHistory && query.trim().isNotEmpty) {
        await _dataSource.addSearchHistory(query.trim());
        updatedHistory = _dataSource.getSearchHistory();
      }

      if (results.isEmpty) {
        emit(state.copyWith(
          status: SearchStatus.empty,
          results: results,
          searchHistory: updatedHistory,
        ));
      } else {
        emit(state.copyWith(
          status: SearchStatus.success,
          results: results,
          searchHistory: updatedHistory,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: SearchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // --------------------------------------------------------------------------
  // History Actions
  // --------------------------------------------------------------------------

  Future<void> deleteHistoryItem(String query) async {
    await _dataSource.removeSearchHistoryItem(query);
    if (isClosed) return;
    emit(state.copyWith(
      searchHistory: _dataSource.getSearchHistory(),
    ));
  }

  Future<void> clearAllHistory() async {
    await _dataSource.clearSearchHistory();
    if (isClosed) return;
    emit(state.copyWith(
      searchHistory: [],
    ));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
