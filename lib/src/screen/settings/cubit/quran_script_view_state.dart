import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";

class QuranViewState {
  String ayahKey;
  double fontSize;
  double lineHeight;
  QuranScriptType quranScriptType;
  double translationFontSize;
  bool hideFootnote;
  bool hideWordByWord;
  bool hideTranslation;
  bool hideToolbar;
  bool hideQuranAyah;
  bool alwaysOpenWordByWord;
  bool enableWordByWordHighlight;
  bool scrollWithRecitation;
  QuranViewState({
    required this.ayahKey,
    required this.fontSize,
    required this.lineHeight,
    required this.quranScriptType,
    required this.translationFontSize,
    this.hideFootnote = false,
    this.hideWordByWord = false,
    this.hideTranslation = false,
    this.hideToolbar = false,
    this.hideQuranAyah = false,
    this.alwaysOpenWordByWord = false,
    this.enableWordByWordHighlight = true,
    this.scrollWithRecitation = false,
  });

  QuranViewState copyWith({
    String? ayahKey,
    double? fontSize,
    double? lineHeight,
    QuranScriptType? quranScriptType,
    double? translationFontSize,
    bool? hideFootnote,
    bool? hideWordByWord,
    bool? hideTranslation,
    bool? hideToolbar,
    bool? hideQuranAyah,
    bool? alwaysOpenWordByWord,
    bool? enableWordByWordHighlight,
    bool? scrollWithRecitation,
  }) {
    return QuranViewState(
      ayahKey: ayahKey ?? this.ayahKey,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      quranScriptType: quranScriptType ?? this.quranScriptType,
      translationFontSize: translationFontSize ?? this.translationFontSize,
      hideFootnote: hideFootnote ?? this.hideFootnote,
      hideWordByWord: hideWordByWord ?? this.hideWordByWord,
      hideTranslation: hideTranslation ?? this.hideTranslation,
      hideToolbar: hideToolbar ?? this.hideToolbar,
      hideQuranAyah: hideQuranAyah ?? this.hideQuranAyah,
      alwaysOpenWordByWord: alwaysOpenWordByWord ?? this.alwaysOpenWordByWord,
      enableWordByWordHighlight:
          enableWordByWordHighlight ?? this.enableWordByWordHighlight,
      scrollWithRecitation: scrollWithRecitation ?? this.scrollWithRecitation,
    );
  }
}
