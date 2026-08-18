import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";

/// The active scope tab for search.
enum SearchScope {
  all,
  translations,
  arabic,
  tafsir,
  surahs,
}

/// Filter criteria for querying Quran resources.
class SearchFilterModel {
  final SearchScope scope;
  final List<ResourcesModel> selectedTranslations;
  final List<ResourcesModel> selectedTafsirs;
  final int? surahNumber;
  final String revelationType; // "all", "meccan", "medinan"
  final bool matchExactPhrase;

  const SearchFilterModel({
    this.scope = SearchScope.all,
    this.selectedTranslations = const [],
    this.selectedTafsirs = const [],
    this.surahNumber,
    this.revelationType = "all",
    this.matchExactPhrase = false,
  });

  SearchFilterModel copyWith({
    SearchScope? scope,
    List<ResourcesModel>? selectedTranslations,
    List<ResourcesModel>? selectedTafsirs,
    int? surahNumber,
    bool clearSurahNumber = false,
    String? revelationType,
    bool? matchExactPhrase,
  }) {
    return SearchFilterModel(
      scope: scope ?? this.scope,
      selectedTranslations:
          selectedTranslations ?? this.selectedTranslations,
      selectedTafsirs: selectedTafsirs ?? this.selectedTafsirs,
      surahNumber: clearSurahNumber ? null : (surahNumber ?? this.surahNumber),
      revelationType: revelationType ?? this.revelationType,
      matchExactPhrase: matchExactPhrase ?? this.matchExactPhrase,
    );
  }

  bool get hasCustomFilters =>
      surahNumber != null ||
      revelationType != "all" ||
      matchExactPhrase;
}
