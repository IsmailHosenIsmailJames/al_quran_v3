import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';

class IndopakView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const IndopakView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        indopakScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
            .toString()];
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 24, fontFamily: 'IndopakNastaleeq'),
        children: List<InlineSpan>.generate(words.length, (index) {
          return TextSpan(text: words[index]);
        }),
      ),
    );
  }
}
