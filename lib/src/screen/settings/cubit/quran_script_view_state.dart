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
  bool useAudioStream;
  double playbackSpeed;
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
    this.useAudioStream = true,
    this.playbackSpeed = 1.0,
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
    bool? useAudioStream,
    double? playbackSpeed,
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
      useAudioStream: useAudioStream ?? this.useAudioStream,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
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
        other.translationFontSize == translationFontSize &&
        other.hideFootnote == hideFootnote &&
        other.hideWordByWord == hideWordByWord &&
        other.hideTranslation == hideTranslation &&
        other.hideToolbar == hideToolbar &&
        other.hideQuranAyah == hideQuranAyah &&
        other.alwaysOpenWordByWord == alwaysOpenWordByWord &&
        other.enableWordByWordHighlight == enableWordByWordHighlight &&
        other.scrollWithRecitation == scrollWithRecitation &&
        other.useAudioStream == useAudioStream &&
        other.playbackSpeed == playbackSpeed;
  }

  @override
  int get hashCode {
    return ayahKey.hashCode ^
        fontSize.hashCode ^
        lineHeight.hashCode ^
        quranScriptType.hashCode ^
        translationFontSize.hashCode ^
        hideFootnote.hashCode ^
        hideWordByWord.hashCode ^
        hideTranslation.hashCode ^
        hideToolbar.hashCode ^
        hideQuranAyah.hashCode ^
        alwaysOpenWordByWord.hashCode ^
        enableWordByWordHighlight.hashCode ^
        scrollWithRecitation.hashCode ^
        useAudioStream.hashCode ^
        playbackSpeed.hashCode;
  }
}
