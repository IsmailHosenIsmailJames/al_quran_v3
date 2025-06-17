import "package:al_quran_v3/src/screen/settings/cubit/quram_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quram_script_view_state.dart";
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
      fontSize: 16,
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
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Font Size", style: titleStyle),
                    Text(quranViewState.fontSize.toString(), style: titleStyle),
                  ],
                ),

                Slider.adaptive(
                  value: quranViewState.fontSize,
                  max: 60,
                  min: 10,
                  divisions: 80,
                  onChanged: (value) {
                    context.read<QuranViewCubit>().changeFontSize(
                      value.toPrecision(2),
                    );
                  },
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Line Height", style: titleStyle),
                    Text(
                      quranViewState.lineHeight.toString(),
                      style: titleStyle,
                    ),
                  ],
                ),

                Slider.adaptive(
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
                const Gap(10),
                Text("Quran Script", style: titleStyle),
                const Gap(7),
                getScriptSelectionSegmentedButtons(),
                getAyahPreviewWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
