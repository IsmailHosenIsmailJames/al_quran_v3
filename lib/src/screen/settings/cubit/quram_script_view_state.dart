import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";

class QuranViewState {
  String ayahKey;
  double fontSize;
  double lineHeight;
  QuranScriptType quranScriptType;
  QuranViewState({
    required this.ayahKey,
    required this.fontSize,
    required this.lineHeight,
    required this.quranScriptType,
  });

  QuranViewState copyWith({
    String? ayahKey,
    double? fontSize,
    double? lineHeight,
    QuranScriptType? quranScriptType,
  }) {
    return QuranViewState(
      ayahKey: ayahKey ?? this.ayahKey,
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      quranScriptType: quranScriptType ?? this.quranScriptType,
    );
  }
}
