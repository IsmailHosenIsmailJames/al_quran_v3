import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_view.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/uthmani_view.dart";
import "package:flutter/material.dart";

class ScriptProcessor extends StatelessWidget {
  final ScriptInfo scriptInfo;
  final ThemeState themeState;
  const ScriptProcessor({
    super.key,
    required this.scriptInfo,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    return switch (scriptInfo.quranScriptType) {
      QuranScriptType.tajweed => TajweedView(
        scriptInfo: scriptInfo,
        themeState: themeState,
      ),
      QuranScriptType.uthmani => NonTajweedScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: true,
      ),
      QuranScriptType.indopak => NonTajweedScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: false,
      ),
    };
  }
}
