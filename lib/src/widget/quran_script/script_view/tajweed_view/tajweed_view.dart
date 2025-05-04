import 'dart:developer';

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
        TextSpan(
          children: [
            parseTajweedWord(
              words[scriptInfo.wordIndex!] + ' ',
              quranStyle,
              context,
            ),
          ],
        ),
      );
    }
    return Text.rich(
      style: quranStyle,
      textDirection: TextDirection.rtl,

      TextSpan(
        children: List<InlineSpan>.generate(words.length, (index) {
          return WidgetSpan(
            child: InkWell(
              onTap: () {
                log(words[index] + ' ');
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    parseTajweedWord(words[index] + ' ', quranStyle, context),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
