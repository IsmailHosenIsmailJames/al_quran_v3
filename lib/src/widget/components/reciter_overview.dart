import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/audio_controller_ui.dart";
import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/audio_download_screen.dart";
import "package:al_quran_v3/src/screen/audio/settings/audio_settings.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/widget/audio/reciter_overview.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Widget getReciterViewWidget(
  BuildContext context,
  AyahKeyManagement ayahKeyState,
  int currentIndex, {
  bool showSettingsIconButton = true,
  bool showDownloadIconButton = true,
}) {
  return Stack(
    children: [
      BlocBuilder<AudioUiCubit, AudioControllerUiState>(
        builder: (context, audioUIState) {
          return BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
            builder: (context, quranInsideReciter) {
              return BlocBuilder<AudioTabReciterCubit, ReciterInfoModel>(
                builder: (context, audioTabReciter) {
                  return getReciterWidget(
                    context: context,
                    audioTabScreenState:
                        audioUIState.isInsideQuranPlayer
                            ? quranInsideReciter
                            : audioTabReciter,
                    ayahKeyState: ayahKeyState,
                    currentIndex: currentIndex,
                  );
                },
              );
            },
          );
        },
      ),
      if (showDownloadIconButton || showSettingsIconButton)
        Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              if (showSettingsIconButton)
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        context.read<ThemeCubit>().state.primaryShade100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const AudioSettings(needAppBar: true),
                      ),
                    );
                  },
                  icon: const Icon(FluentIcons.settings_24_filled),
                ),
              if (showDownloadIconButton)
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor:
                        context.read<ThemeCubit>().state.primaryShade100,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AudioDownloadScreen(),
                      ),
                    );
                  },
                  icon: const Icon(FluentIcons.arrow_download_24_filled),
                ),
            ],
          ),
        ),
    ],
  );
}
