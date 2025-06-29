class SearchResultModel {
  String ayahKey;
  String? translation;
  String? tafsir;

  SearchResultModel({required this.ayahKey, this.translation, this.tafsir});

  SearchResultModel copyWith({
    String? ayahKey,
    String? translation,
    String? tafsir,
  }) {
    return SearchResultModel(
      ayahKey: ayahKey ?? this.ayahKey,
      translation: translation ?? this.translation,
      tafsir: tafsir ?? this.tafsir,
    );
  }
}
