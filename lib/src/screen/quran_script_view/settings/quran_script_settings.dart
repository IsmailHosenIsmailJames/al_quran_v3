import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:screenshot/screenshot.dart";

import "../../../widget/preview_quran_script/ayah_preview_widget.dart";
import "../../settings/cubit/quran_script_view_cubit.dart";
import "../../settings/cubit/quran_script_view_state.dart";

class QuranScriptSettings extends StatelessWidget {
  const QuranScriptSettings({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quran Font Size", style: titleStyle),
                Text(quranViewState.fontSize.toString(), style: titleStyle),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.fontSize,
                max: 60,
                min: 10,
                divisions: 100,
                onChanged: (value) {
                  context.read<QuranViewCubit>().changeFontSize(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quran Line Height", style: titleStyle),
                Text(quranViewState.lineHeight.toString(), style: titleStyle),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.lineHeight,
                max: 5,
                min: 0.7,
                divisions: 100,

                onChanged: (value) {
                  context.read<QuranViewCubit>().changeLineHeight(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Translation & Tafsir Font Size", style: titleStyle),
                Text(
                  quranViewState.translationFontSize.toString(),
                  style: titleStyle,
                ),
              ],
            ),

            const Gap(10),

            SliderTheme(
              data: const SliderThemeData(padding: EdgeInsets.zero),
              child: Slider.adaptive(
                value: quranViewState.translationFontSize,
                max: 60,
                min: 8,

                divisions: 100,

                onChanged: (value) {
                  context.read<QuranViewCubit>().changeTranslationFontSize(
                    value.toPrecision(2),
                  );
                },
              ),
            ),
            const Gap(5),
            getAyahPreviewWidget(),
          ],
        );
      },
    );
  }
}
