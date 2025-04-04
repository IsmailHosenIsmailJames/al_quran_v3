class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
  double? fontSize;
  int? limitWord;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
    this.fontSize,
    this.limitWord,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
