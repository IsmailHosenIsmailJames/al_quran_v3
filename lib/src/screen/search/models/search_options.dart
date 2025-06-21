enum SearchFields { quran, translation, tafsir }

extension SearchFieldsExtension on SearchFields {
  static SearchFields fromString(String value) {
    switch (value) {
      case "quran":
        return SearchFields.quran;
      case "translation":
        return SearchFields.translation;
      case "tafsir":
        return SearchFields.tafsir;
      default:
        throw ArgumentError("Invalid search field: $value");
    }
  }
}
