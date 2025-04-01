class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
