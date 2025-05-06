import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IndopakPageRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;
  const IndopakPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> quranScriptSpan = [];
    for (String ayahKey in ayahsKey) {
      List words =
          indopakScript[ayahKey.split(':').first]?[ayahKey.split(':').last] ??
          [];
      for (int index = 0; index < words.length; index++) {
        String word = words[index];
        quranScriptSpan.add(
          TextSpan(
            text: '$word ',
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    showPopupWordFunction(
                      context: context,
                      wordKey: '$ayahKey:${index + 1}',
                      word: words[index],
                      scriptCategory: QuranScriptType.uthmani,
                    );
                  },
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text.rich(
        TextSpan(children: quranScriptSpan),
        style: TextStyle(
          fontSize: baseTextStyle?.fontSize ?? 24,
          fontFamily: baseTextStyle?.fontFamily ?? 'IndopakNastaleeq',
          fontWeight: baseTextStyle?.fontWeight,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
