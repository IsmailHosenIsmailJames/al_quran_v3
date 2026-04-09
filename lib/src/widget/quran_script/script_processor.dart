import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/quran_script_view.dart";
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
      QuranScriptType.uthmani => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: true,
      ),
      QuranScriptType.indopak => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: false,
      ),
    };
  }
}
