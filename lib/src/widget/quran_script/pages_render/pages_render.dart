import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/tajweed_page_render/tajweed_page_renderer.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/uthmani_page_renderer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranPagesRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final QuranScriptType quranScriptType;
  final TextStyle? baseStyle;
  final bool? enableWordByWordHighlight;

  const QuranPagesRenderer({
    super.key,
    required this.ayahsKey,
    required this.quranScriptType,
    this.baseStyle,
    this.enableWordByWordHighlight,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle copyBaseStyle = (baseStyle ?? const TextStyle(fontSize: 24))
        .copyWith(height: context.read<QuranViewCubit>().state.lineHeight);
    return switch (quranScriptType) {
      QuranScriptType.tajweed => TajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
        enableWordByWordHighlight: enableWordByWordHighlight,
      ),
      QuranScriptType.uthmani => NonTajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
        isUthmani: true,
        enableWordByWordHighlight: enableWordByWordHighlight,
      ),
      QuranScriptType.indopak => NonTajweedPageRenderer(
        ayahsKey: ayahsKey,
        baseTextStyle: copyBaseStyle,
        isUthmani: false,
        enableWordByWordHighlight: enableWordByWordHighlight,
      ),
    };
  }
}
