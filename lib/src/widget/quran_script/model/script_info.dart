class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
  double? fontSize;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
    this.fontSize,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
