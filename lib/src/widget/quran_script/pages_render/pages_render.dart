import "package:al_quran_v3/src/functions/quran_script_height.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/tajweed_page_render/tajweed_page_renderer.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/uthmani_page_renderer.dart";
import "package:flutter/material.dart";

class QuranPagesRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final QuranScriptType quranScriptType;
  final TextStyle? baseStyle;

  const QuranPagesRenderer({
    super.key,
    required this.ayahsKey,
    required this.quranScriptType,
    this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle copyBaseStyle = (baseStyle ?? const TextStyle(fontSize: 24))
        .copyWith(height: getScriptHeight());
    return switch (quranScriptType) {
      QuranScriptType.tajweed => TajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
      ),
      QuranScriptType.uthmani => NonTajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
        isUthmani: true,
      ),
      QuranScriptType.indopak => NonTajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
        isUthmani: false,
      ),
    };
  }
}
