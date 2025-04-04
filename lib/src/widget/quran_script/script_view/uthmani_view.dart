import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';

class UthmaniView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const UthmaniView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        uthmaniScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
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
    return Text.rich(
      style: quranStyle,
      TextSpan(
        children: List<InlineSpan>.generate(words.length, (index) {
          return TextSpan(text: words[index] + ' ');
        }),
      ),
    );
  }
}
