import "package:flutter/cupertino.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";

class ScriptInfo {
  int surahNumber;
  int ayahNumber;
  QuranScriptType quranScriptType;
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
    required this.quranScriptType,
    this.textStyle,
    this.textAlign,
    this.limitWord,
    this.wordIndex,
    this.skipWordTap,
    this.showWordHighlights,
    this.forImage,
  });
}

enum QuranScriptType { tajweed, uthmani, indopak }

String getLocalizedQuranScriptType(
  BuildContext context,
  QuranScriptType quranScriptType,
) {
  switch (quranScriptType) {
    case QuranScriptType.tajweed:
      return AppLocalizations.of(context).quranScriptTajweed;
    case QuranScriptType.uthmani:
      return AppLocalizations.of(context).quranScriptUthmani;
    case QuranScriptType.indopak:
      return AppLocalizations.of(context).quranScriptIndopak;
  }
}
