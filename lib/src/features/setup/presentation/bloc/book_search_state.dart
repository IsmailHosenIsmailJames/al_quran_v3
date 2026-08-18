import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'book_search_state.freezed.dart';

@freezed
abstract class BookSearchState with _$BookSearchState {
  const BookSearchState._();

  const factory BookSearchState({
    required String query,
    required bool isTafsir,
    required Map<String, List<ResourceEntity>> groupedBooks,
    required List<String> sortedLanguages,
  }) = _BookSearchState;

  factory BookSearchState.initial({
    required bool isTafsir,
    required Map<String, List<ResourceEntity>> allResources,
  }) {
    final filtered = filterAndGroup(allResources, "", isTafsir);
    final sortedLangs = filtered.keys.toList()..sort();
    return BookSearchState(
      query: "",
      isTafsir: isTafsir,
      groupedBooks: filtered,
      sortedLanguages: sortedLangs,
    );
  }

  static Map<String, List<ResourceEntity>> filterAndGroup(
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
    final filtered = filterAndGroup(allResources, newQuery, isTafsir);
    final sortedLangs = filtered.keys.toList()..sort();
    return BookSearchState(
      query: newQuery,
      isTafsir: isTafsir,
      groupedBooks: filtered,
      sortedLanguages: sortedLangs,
    );
  }
}
