import "package:flutter/cupertino.dart";

class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
  double? fontSize;
  TextAlign? textAlign;
  int? limitWord;
  int? wordIndex;
  bool? showWordHighlights;
  bool? skipWordTap;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranScriptType,
    this.fontSize,
    this.textAlign,
    this.limitWord,
    this.wordIndex,
    this.skipWordTap,
    this.showWordHighlights,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
