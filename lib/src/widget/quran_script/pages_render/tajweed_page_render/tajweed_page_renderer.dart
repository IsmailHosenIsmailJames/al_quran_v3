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
        for (var word in ayahWords) {
          listOfTextSpan.add(
            parseTajweedWord(
              '$word ',
              TextStyle(
                fontSize: baseTextStyle?.fontSize ?? 24,
                fontFamily: baseTextStyle?.fontFamily ?? 'QPC_Hafs',
              ),
              context,
            ),
          );
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Text.rich(
        TextSpan(children: listOfTextSpan),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
