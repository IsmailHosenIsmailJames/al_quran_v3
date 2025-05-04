import 'package:al_quran_v3/main.dart';
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
    String quranScript = '';
    for (String ayahKey in ayahsKey) {
      List words =
          indopakScript[ayahKey.split(':').first]?[ayahKey.split(':').last] ??
          [];
      for (final word in words) {
        quranScript += '$word ';
      }
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        quranScript,
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
