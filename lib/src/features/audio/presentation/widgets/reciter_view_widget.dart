import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_download_screen.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_overview.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

Widget getReciterViewWidget(
  BuildContext context,
  AyahKeyManagement ayahKeyState,
  int currentIndex, {
  bool showSettingsIconButton = true,
  bool showDownloadIconButton = kIsWeb ? false : true,
}) {
  final themeState = context.read<ThemeCubit>().state;
  final l10n = AppLocalizations.of(context);
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: BlocBuilder<AudioUiCubit, AudioControllerUiState>(
          builder: (context, audioUIState) {
            return BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
              builder: (context, quranInsideReciter) {
                return BlocBuilder<AudioTabReciterCubit, ReciterInfoModel>(
                  builder: (context, audioTabReciter) {
                    return getReciterWidget(
                      context: context,
                      audioTabScreenState: audioUIState.isInsideQuranPlayer
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
      ),
      if (showDownloadIconButton || showSettingsIconButton) ...[
        const Gap(8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSettingsIconButton)
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : themeState.primaryShade100.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : themeState.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: IconButton(
                  tooltip: l10n.audioSettings,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AudioSettings(needAppBar: true),
                      ),
                    );
                  },
                  icon: Icon(
                    FluentIcons.settings_20_regular,
                    size: 20,
                    color: themeState.primary,
                  ),
                ),
              ),
            if (showSettingsIconButton && showDownloadIconButton)
              const Gap(6),
            if (showDownloadIconButton)
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : themeState.primaryShade100.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : themeState.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: IconButton(
                  tooltip: l10n.download,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AudioDownloadScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    FluentIcons.arrow_download_20_regular,
                    size: 20,
                    color: themeState.primary,
                  ),
                ),
              ),
          ],
        ),
      ],
    ],
  );
}
