import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_view.dart";
import "package:flutter/material.dart";

class ScriptProcessor extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const ScriptProcessor({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    return TajweedView(scriptInfo: scriptInfo);
  }
}
