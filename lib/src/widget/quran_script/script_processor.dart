import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/quran_script_view.dart";
import "package:flutter/material.dart";

class ScriptProcessor extends StatelessWidget {
  final ScriptInfo scriptInfo;
  final ThemeState themeState;
  final bool tajweedColorEnable;
  const ScriptProcessor({
    super.key,
    required this.scriptInfo,
    required this.themeState,
    required this.tajweedColorEnable,
  });

  @override
  Widget build(BuildContext context) {
    return switch (scriptInfo.quranScriptType) {
      QuranScriptType.uthmani => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: true,
        tajweedColorEnable: tajweedColorEnable,
      ),
      QuranScriptType.indopak => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: false,
        tajweedColorEnable: tajweedColorEnable,
      ),
    };
  }
}
