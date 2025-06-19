import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/widget/preview_quran_script/ayah_preview_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:screenshot/screenshot.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<QuranViewCubit, QuranViewState>(
          builder: (context, quranViewState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quran Script", style: titleStyle),
                const Gap(7),
                getScriptSelectionSegmentedButtons(),
                const Gap(20),
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
                    Text(
                      quranViewState.lineHeight.toString(),
                      style: titleStyle,
                    ),
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
        ),
      ),
    );
  }
}
