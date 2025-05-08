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
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.fontSize ?? 24,
      fontFamily: 'QPC_Hafs',
    );
    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        parseTajweedWord(
          wordKey:
              '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${scriptInfo.wordIndex}',
          wordHtml: words[scriptInfo.wordIndex!] + ' ',
          baseStyle: quranStyle,
          context: context,
          skipWordTap: scriptInfo.skipWordTap,
        ),
      );
    }
    return Text.rich(
      style: quranStyle,
      textDirection: TextDirection.rtl,

      TextSpan(
        children: List<InlineSpan>.generate(words.length, (index) {
          return parseTajweedWord(
            wordKey:
                '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${index + 1}',
            wordHtml: words[index] + ' ',
            baseStyle: quranStyle,
            context: context,
            skipWordTap: scriptInfo.skipWordTap,
          );
        }),
      ),
    );
  }
}
