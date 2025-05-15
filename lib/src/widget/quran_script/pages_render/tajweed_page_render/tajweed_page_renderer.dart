import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart';
import 'package:flutter/material.dart';

class TajweedPageRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;

  const TajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> listOfTextSpan = [];
    for (String ayahKey in ayahsKey) {
      List? ayahWords =
          tajweedScript[ayahKey.split(':').first]?[ayahKey.split(':').last];

      if (ayahWords != null) {
        for (int i = 0; i < ayahWords.length; i++) {
          String word = ayahWords[i];
          listOfTextSpan.add(
            parseTajweedWord(
              wordKey: '$ayahKey:${i + 1}',
              wordHtml: '$word ',
              baseStyle: TextStyle(
                fontSize: baseTextStyle?.fontSize ?? 24,
                fontFamily: baseTextStyle?.fontFamily ?? 'QPC_Hafs',
              ),
              context: context,
            ),
          );
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),

      child: Text.rich(
        TextSpan(children: listOfTextSpan),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
