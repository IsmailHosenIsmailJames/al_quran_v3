import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";

enum SearchStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

class QuranSearchState {
  final SearchStatus status;
  final String query;
  final SearchFilterModel filter;
  final QuranSearchResults? results;
  final List<String> searchHistory;
  final List<ResourcesModel> availableTranslations;
  final List<ResourcesModel> availableTafsirs;
  final String? errorMessage;

  const QuranSearchState({
    this.status = SearchStatus.initial,
    this.query = "",
    this.filter = const SearchFilterModel(),
    this.results,
    this.searchHistory = const [],
    this.availableTranslations = const [],
    this.availableTafsirs = const [],
    this.errorMessage,
  });

  QuranSearchState copyWith({
    SearchStatus? status,
    String? query,
    SearchFilterModel? filter,
    QuranSearchResults? results,
    List<String>? searchHistory,
    List<ResourcesModel>? availableTranslations,
    List<ResourcesModel>? availableTafsirs,
    String? errorMessage,
    bool clearResults = false,
  }) {
    return QuranSearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      filter: filter ?? this.filter,
      results: clearResults ? null : (results ?? this.results),
      searchHistory: searchHistory ?? this.searchHistory,
      availableTranslations:
          availableTranslations ?? this.availableTranslations,
      availableTafsirs: availableTafsirs ?? this.availableTafsirs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
