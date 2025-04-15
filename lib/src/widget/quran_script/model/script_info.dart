class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
  double? fontSize;
  int? limitWord;
  int? wordIndex;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
    this.fontSize,
    this.limitWord,
    this.wordIndex,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
