class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
  double? fontSize;
  int? limitWord;
  int? wordIndex;
  bool? skipWordTap;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
    this.fontSize,
    this.limitWord,
    this.wordIndex,
    this.skipWordTap,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
