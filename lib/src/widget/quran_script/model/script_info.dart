import "package:flutter/cupertino.dart";

class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  TextStyle? textStyle;
  TextAlign? textAlign;
  int? limitWord;
  int? wordIndex;
  bool? showWordHighlights;
  bool? skipWordTap;
  bool? forImage;

  ScriptInfo({
    required this.surahNumber,
    required this.ayahNumber,
    this.textStyle,
    this.textAlign,
    this.limitWord,
    this.wordIndex,
    this.skipWordTap,
    this.showWordHighlights,
    this.forImage,
  });
}
