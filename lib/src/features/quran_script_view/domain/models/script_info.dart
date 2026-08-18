import "package:flutter/cupertino.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'script_info.freezed.dart';

enum QuranScriptType { uthmani, indopak }

@freezed
abstract class ScriptInfo with _$ScriptInfo {
  const factory ScriptInfo({
    required int surahNumber,
    required int ayahNumber,
    required QuranScriptType quranScriptType,
    TextStyle? textStyle,
    TextAlign? textAlign,
    int? limitWord,
    int? wordIndex,
    bool? showWordHighlights,
    bool? skipWordTap,
    bool? forImage,
  }) = _ScriptInfo;
}

String getLocalizedQuranScriptType(
  BuildContext context,
  QuranScriptType quranScriptType,
) {
  switch (quranScriptType) {
    case QuranScriptType.uthmani:
      return AppLocalizations.of(context).quranScriptUthmani;
    case QuranScriptType.indopak:
      return AppLocalizations.of(context).quranScriptIndopak;
  }
}
