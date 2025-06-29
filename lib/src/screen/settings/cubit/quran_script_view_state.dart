class QuranViewState {
  String ayahKey;
  double fontSize;

  QuranViewState({required this.ayahKey, required this.fontSize});

  QuranViewState copyWith({
    String? ayahKey,
    double? fontSize,
    double? lineHeight,
    double? translationFontSize,
    bool? hideFootnote,
    bool? hideWordByWord,
    bool? hideTranslation,
    bool? hideToolbar,
    bool? hideQuranAyah,
    bool? alwaysOpenWordByWord,
    bool? enableWordByWordHighlight,
  }) {
    return QuranViewState(
      ayahKey: ayahKey ?? this.ayahKey,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
