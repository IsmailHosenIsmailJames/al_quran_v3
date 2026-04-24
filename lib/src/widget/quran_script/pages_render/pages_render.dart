import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/uthmani_page_renderer.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranPagesRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final QuranScriptType quranScriptType;
  final TextStyle? baseStyle;
  final bool? enableWordByWordHighlight;
  final bool tajweedColorEnable;

  const QuranPagesRenderer({
    super.key,
    required this.ayahsKey,
    required this.quranScriptType,
    this.baseStyle,
    this.enableWordByWordHighlight,
    required this.tajweedColorEnable,
  });

  @override
  Widget build(BuildContext context) {
    final quranViewCubit = context.read<QuranViewCubit>();
    TextStyle copyBaseStyle = (baseStyle ?? const TextStyle(fontSize: 24))
        .copyWith(height: quranViewCubit.state.lineHeight);
    return NonTajweedPageRenderer(
      ayahsKey: ayahsKey,
      baseTextStyle: copyBaseStyle.copyWith(
        fontFamily: quranScriptType == QuranScriptType.uthmani
            ? quranViewCubit.state.uthmaniFontName
            : quranViewCubit.state.indopakFontName,
      ),
      isUthmani: quranScriptType == QuranScriptType.uthmani,
      enableWordByWordHighlight: enableWordByWordHighlight,
      tajweedColorEnable: tajweedColorEnable,
    );
  }
}
