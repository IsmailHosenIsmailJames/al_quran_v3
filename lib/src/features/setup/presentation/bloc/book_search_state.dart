import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";

class BookSearchState {
  final String query;
  final bool isTafsir;
  final Map<String, List<ResourceEntity>> groupedBooks;
  final List<String> sortedLanguages;

  const BookSearchState({
    required this.query,
    required this.isTafsir,
    required this.groupedBooks,
    required this.sortedLanguages,
  });

  factory BookSearchState.initial({
    required bool isTafsir,
    required Map<String, List<ResourceEntity>> allResources,
  }) {
    final filtered = _filterAndGroup(allResources, "", isTafsir);
    final sortedLangs = filtered.keys.toList()..sort();
    return BookSearchState(
      query: "",
      isTafsir: isTafsir,
      groupedBooks: filtered,
      sortedLanguages: sortedLangs,
    );
  }

  static Map<String, List<ResourceEntity>> _filterAndGroup(
    Map<String, List<ResourceEntity>> allResources,
    String query,
    bool isTafsir,
  ) {
    final q = query.trim().toLowerCase();
    final allList = allResources.values.expand((e) => e).where((e) {
      return isTafsir ? e.isTafsir : e.isTranslation;
    });

    final filtered = allList.where((b) {
      if (q.isEmpty) return true;
      return b.name.toLowerCase().contains(q) ||
          b.englishName.toLowerCase().contains(q) ||
          b.language.toLowerCase().contains(q) ||
          b.languageNative.toLowerCase().contains(q);
    }).toList();

    // Group by language code
    final Map<String, List<ResourceEntity>> grouped = {};
    for (final book in filtered) {
      grouped.putIfAbsent(book.languageCode, () => []).add(book);
    }
    for (final key in grouped.keys) {
      grouped[key]!.sort((a, b) => a.englishName.compareTo(b.englishName));
    }
    return grouped;
  }

  BookSearchState copyWithQuery(
    String newQuery,
    Map<String, List<ResourceEntity>> allResources,
  ) {
    final filtered = _filterAndGroup(allResources, newQuery, isTafsir);
    final sortedLangs = filtered.keys.toList()..sort();
    return BookSearchState(
      query: newQuery,
      isTafsir: isTafsir,
      groupedBooks: filtered,
      sortedLanguages: sortedLangs,
    );
  }
}
