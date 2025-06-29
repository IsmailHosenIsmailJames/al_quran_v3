import "package:al_quran_v3/src/screen/audio/settings/audio_settings.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/settings/theme_settings.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              top: 15,
              bottom: 50,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quran Font Size",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    BlocBuilder<QuranViewCubit, QuranViewState>(
                      builder: (context, state) {
                        return Text(
                          state.fontSize.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Divider(color: themeState.primaryShade300),
                BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return SliderTheme(
                      data: const SliderThemeData(padding: EdgeInsets.zero),
                      child: Slider(
                        value: state.fontSize,
                        min: 8,
                        max: 60,
                        onChanged: (value) {
                          context.read<QuranViewCubit>().changeFontSize(
                            value.toStringAsFixed(1).toDouble(),
                          );
                        },
                      ),
                    );
                  },
                ),
                const Gap(10),
                const Text(
                  "App Theme",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const ThemeSettings(),
                const Gap(10),
                const Text(
                  "Audio Cached",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const Gap(5),
                const AudioSettings(),
                const Gap(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
