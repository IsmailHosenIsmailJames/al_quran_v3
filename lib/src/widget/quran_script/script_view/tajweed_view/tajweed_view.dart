import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';

import 'tajweed_text_preser.dart';

class TajweedView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const TajweedView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        tajweedScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
            .toString()];
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.fontSize ?? 24,
      fontFamily: 'QPC_Hafs',
    );
    return Text.rich(
      style: quranStyle,
      TextSpan(
        children: List.generate(words.length, (index) {
          return parseTajweedWord(words[index] + ' ', quranStyle, context);
        }),
      ),
    );
  }
}
