import "package:al_quran_v3/src/screen/audio/settings/audio_settings.dart";
import "package:al_quran_v3/src/screen/quran_script_view/settings/quran_script_settings.dart";
import "package:al_quran_v3/src/screen/settings/others_settings.dart";
import "package:al_quran_v3/src/screen/settings/theme_settings.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "../setup/setup_page.dart";

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
              left: 10.0,
              right: 10,
              top: 10,
              bottom: 50,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "App Theme",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const ThemeSettings(),
                const Gap(20),
                const Text(
                  "Quran Style",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const Gap(5),
                const Text(
                  "Quran Style",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(7),
                getScriptSelectionSegmentedButtons(context),
                const Gap(20),
                const QuranScriptSettings(),
                const Gap(30),
                const Text(
                  "Audio Cached",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const Gap(5),
                const AudioSettings(),
                const Gap(30),
                const Text(
                  "Others",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Divider(color: themeState.primaryShade300),
                const Gap(5),
                const OthersSettings(),
              ],
            ),
          );
        },
      ),
    );
  }
}
