import "package:al_quran_v3/src/core/utils/navigator_key.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";

String getAyahLocalized(BuildContext? context, String ayahKey) {
  context ??= navigatorKey.currentContext!;
  List<String> split = ayahKey.split(":");
  return "${localizedNumber(context, split.first.toInt())}:${localizedNumber(context, split.last.toInt())}";
}
