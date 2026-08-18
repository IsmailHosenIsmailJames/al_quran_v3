import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/script_view/quran_page_script_widget.dart";
import "package:flutter/material.dart";

class ScriptProcessor extends StatelessWidget {
  final ScriptInfo scriptInfo;
  final ThemeState themeState;
  final bool tajweedColorEnable;
  final bool? showBottomsheetOnTap;
  const ScriptProcessor({
    super.key,
    required this.scriptInfo,
    required this.themeState,
    required this.tajweedColorEnable,
    this.showBottomsheetOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return switch (scriptInfo.quranScriptType) {
      QuranScriptType.uthmani => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: true,
        tajweedColorEnable: tajweedColorEnable,
        showBottomsheetOnTap: showBottomsheetOnTap,
      ),
      QuranScriptType.indopak => QuranScriptScriptView(
        scriptInfo: scriptInfo,
        themeState: themeState,
        isUthmani: false,
        tajweedColorEnable: tajweedColorEnable,
        showBottomsheetOnTap: showBottomsheetOnTap,
      ),
    };
  }
}
