import 'dart:developer';

import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IndopakView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const IndopakView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        indopakScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
            .toString()];
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.fontSize ?? 24,
      fontFamily: 'IndopakNastaleeq',
    );
    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        TextSpan(
          children: [TextSpan(text: words[scriptInfo.wordIndex!] + ' ')],
        ),
      );
    }
    return Text.rich(
      textDirection: TextDirection.rtl,
      TextSpan(
        style: quranStyle,
        children: List<InlineSpan>.generate(words.length, (index) {
          return TextSpan(
            text: words[index] + ' ',
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    log(
                      '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${index + 1} -> ${words[index]}',
                    );
                  },
          );
        }),
      ),
    );
  }
}
