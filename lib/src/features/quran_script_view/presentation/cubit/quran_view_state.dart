import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";

class QuranViewState {
  String ayahKey;
  double fontSize;
  double lineHeight;
  QuranScriptType quranScriptType;
  bool circleJojom;
  String uthmaniFontName;
  String indopakFontName;
  double translationFontSize;
  bool useTajweedOnUthmani;
  bool useTajweedOnIndopak;
  bool hideFootnote;
  bool hideWordByWord;
  bool hideTranslation;
  bool hideToolbar;
  bool hideQuranAyah;
  bool alwaysOpenWordByWord;
  bool enableWordByWordHighlight;
  bool scrollWithRecitation;
  bool useAudioStream;
  double playbackSpeed;
  QuranViewState({
    required this.ayahKey,
    required this.fontSize,
    required this.lineHeight,
    required this.quranScriptType,
    required this.translationFontSize,
    required this.useTajweedOnUthmani,
    required this.useTajweedOnIndopak,
    this.uthmaniFontName = "QPC_Hafs",
    this.indopakFontName = "AlQuranNeov5x1",
    this.circleJojom = false,
    this.hideFootnote = false,
    this.hideWordByWord = false,
    this.hideTranslation = false,
    this.hideToolbar = false,
    this.hideQuranAyah = false,
    this.alwaysOpenWordByWord = false,
    this.enableWordByWordHighlight = true,
    this.scrollWithRecitation = false,
    this.useAudioStream = true,
    this.playbackSpeed = 1.0,
  });

  QuranViewState copyWith({
    String? ayahKey,
    double? fontSize,
    double? lineHeight,
    QuranScriptType? quranScriptType,
    bool? circleJojom,
    double? translationFontSize,
    bool? useTajweedOnUthmani,
    bool? useTajweedOnIndopak,
    bool? hideFootnote,
    bool? hideWordByWord,
    bool? hideTranslation,
    bool? hideToolbar,
    bool? hideQuranAyah,
    bool? alwaysOpenWordByWord,
    bool? enableWordByWordHighlight,
    bool? scrollWithRecitation,
    String? uthmaniFontName,
    String? indopakFontName,
    bool? useAudioStream,
    double? playbackSpeed,
  }) {
    return QuranViewState(
      ayahKey: ayahKey ?? this.ayahKey,
      fontSize: fontSize ?? this.fontSize,
      circleJojom: circleJojom ?? this.circleJojom,
      lineHeight: lineHeight ?? this.lineHeight,
      quranScriptType: quranScriptType ?? this.quranScriptType,
      translationFontSize: translationFontSize ?? this.translationFontSize,
      useTajweedOnUthmani: useTajweedOnUthmani ?? this.useTajweedOnUthmani,
      useTajweedOnIndopak: useTajweedOnIndopak ?? this.useTajweedOnIndopak,
      hideFootnote: hideFootnote ?? this.hideFootnote,
      hideWordByWord: hideWordByWord ?? this.hideWordByWord,
      hideTranslation: hideTranslation ?? this.hideTranslation,
      hideToolbar: hideToolbar ?? this.hideToolbar,
      hideQuranAyah: hideQuranAyah ?? this.hideQuranAyah,
      alwaysOpenWordByWord: alwaysOpenWordByWord ?? this.alwaysOpenWordByWord,
      enableWordByWordHighlight:
          enableWordByWordHighlight ?? this.enableWordByWordHighlight,
      scrollWithRecitation: scrollWithRecitation ?? this.scrollWithRecitation,
      useAudioStream: useAudioStream ?? this.useAudioStream,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      uthmaniFontName: uthmaniFontName ?? this.uthmaniFontName,
      indopakFontName: indopakFontName ?? this.indopakFontName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuranViewState &&
        other.ayahKey == ayahKey &&
        other.fontSize == fontSize &&
        other.lineHeight == lineHeight &&
        other.quranScriptType == quranScriptType &&
        other.circleJojom == circleJojom &&
        other.translationFontSize == translationFontSize &&
        other.useTajweedOnUthmani == useTajweedOnUthmani &&
        other.useTajweedOnIndopak == useTajweedOnIndopak &&
        other.hideFootnote == hideFootnote &&
        other.hideWordByWord == hideWordByWord &&
        other.hideTranslation == hideTranslation &&
        other.hideToolbar == hideToolbar &&
        other.hideQuranAyah == hideQuranAyah &&
        other.alwaysOpenWordByWord == alwaysOpenWordByWord &&
        other.enableWordByWordHighlight == enableWordByWordHighlight &&
        other.scrollWithRecitation == scrollWithRecitation &&
        other.useAudioStream == useAudioStream &&
        other.playbackSpeed == playbackSpeed &&
        other.uthmaniFontName == uthmaniFontName &&
        other.indopakFontName == indopakFontName;
  }

  @override
  int get hashCode {
    return ayahKey.hashCode ^
        fontSize.hashCode ^
        lineHeight.hashCode ^
        quranScriptType.hashCode ^
        translationFontSize.hashCode ^
        useTajweedOnUthmani.hashCode ^
        useTajweedOnIndopak.hashCode ^
        hideFootnote.hashCode ^
        hideWordByWord.hashCode ^
        hideTranslation.hashCode ^
        hideToolbar.hashCode ^
        hideQuranAyah.hashCode ^
        alwaysOpenWordByWord.hashCode ^
        enableWordByWordHighlight.hashCode ^
        scrollWithRecitation.hashCode ^
        useAudioStream.hashCode ^
        playbackSpeed.hashCode ^
        uthmaniFontName.hashCode ^
        circleJojom.hashCode ^
        indopakFontName.hashCode;
  }
}
