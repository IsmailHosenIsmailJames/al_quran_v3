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
  bool? forImage;

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
    this.forImage,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }
