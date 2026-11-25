import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/popup_ayah_range_selector.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/sleep_timer_sheet.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

class AudioControllerUi extends StatefulWidget {
  const AudioControllerUi({super.key});

  @override
  State<AudioControllerUi> createState() => _AudioControllerUiState();
}

class _AudioControllerUiState extends State<AudioControllerUi> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state;
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = screenWidth > 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
      builder: (context, state) {
        if (!state.showUi || !state.isInsideQuranPlayer) {
          return const SizedBox.shrink();
        }

        if (!state.isExpanded) {
          return GestureDetector(
            onTap: () => context.read<AudioUiCubit>().expand(true),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16, right: 16),
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeState.primary,
                boxShadow: [
                  BoxShadow(
                    color: themeState.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: BlocBuilder<PlayerStateCubit, PlayerState>(
                builder: (context, playerState) {
                  final isLoading =
                      playerState.state == just_audio.ProcessingState.loading ||
                          playerState.state == just_audio.ProcessingState.buffering;

                  if (isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(14),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }

                  return Icon(
                    playerState.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30,
                  );
                },
              ),
            ),
          );
        }

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedRadius + 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(roundedRadius + 4),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : themeState.primary.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context, themeState, l10n),
                  const Gap(8),
                  _buildProgressSlider(context, themeState),
                  const Gap(6),
                  _buildControls(context, themeState, l10n, isLandscape),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
      builder: (context, state) {
        final surahNumber = int.tryParse(state.current.split(":")[0]) ?? 1;

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeState.primary.withValues(alpha: 0.15),
              ),
              child: Icon(
                FluentIcons.music_note_2_16_filled,
                size: 16,
                color: themeState.primary,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${getSurahName(context, surahNumber)} • ${getAyahLocalized(context, state.current)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  BlocBuilder<ReciterCubit, ReciterInfoModel>(
                    builder: (context, reciter) {
                      return Text(
                        reciter.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Active Memorizing / Sleep Timer Badges
            BlocBuilder<AudioSleepTimerCubit, AudioSleepTimerState>(
              builder: (context, sleepState) {
                return IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 18,
                  tooltip: sleepState.isActive ? "Sleep Timer Active" : "Sleep Timer",
                  onPressed: () => showSleepTimerSheet(context),
                  icon: Icon(
                    sleepState.isActive
                        ? FluentIcons.weather_moon_20_filled
                        : FluentIcons.weather_moon_20_regular,
                    color: sleepState.isActive ? themeState.primary : null,
                  ),
                );
              },
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              tooltip: l10n.closeAudioController,
              onPressed: () => AudioPlayerManager.stopPlayback(hideUi: true),
              icon: const Icon(Icons.close_rounded),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              tooltip: "Minimize",
              onPressed: () => context.read<AudioUiCubit>().expand(false),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgressSlider(BuildContext context, ThemeState themeState) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
      builder: (context, state) {
        var progress = state.currentDuration ?? Duration.zero;
        var buffered = state.bufferDuration ?? Duration.zero;
        var total = state.totalDuration ?? Duration.zero;

        if (progress < Duration.zero) progress = Duration.zero;
        if (total < Duration.zero) total = Duration.zero;
        if (buffered < Duration.zero) buffered = Duration.zero;
        if (progress > total) progress = total;
        if (buffered > total) buffered = total;

        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          thumbCanPaintOutsideBar: false,
          barHeight: 4,
          thumbRadius: 6,
          thumbGlowRadius: 14,
          baseBarColor: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.08),
          bufferedBarColor: isDark
              ? Colors.white.withValues(alpha: 0.2)
              : themeState.primary.withValues(alpha: 0.2),
          progressBarColor: themeState.primary,
          thumbColor: themeState.primary,
          thumbGlowColor: themeState.primary.withValues(alpha: 0.2),
          timeLabelLocation: TimeLabelLocation.sides,
          timeLabelTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
          onSeek: (duration) => AudioPlayerManager.seekToPosition(duration),
        );
      },
    );
  }

  Widget _buildControls(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations l10n,
    bool isLandscape,
  ) {
    return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
      builder: (context, ayahKeyState) {
        final surahNumber =
            int.tryParse(ayahKeyState.current.split(":")[0]) ?? 1;
        final ayahNumber =
            int.tryParse(ayahKeyState.current.split(":")[1]) ?? 1;
        final playlistIdx =
            ayahKeyState.ayahList.indexOf(ayahKeyState.current);
        final hasPrev = playlistIdx > 0;
        final hasNext =
            playlistIdx != -1 && playlistIdx < ayahKeyState.ayahList.length - 1;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AudioLoopCubit, AudioLoopState>(
                builder: (context, loopState) {
                  IconData loopIcon;
                  Color? loopColor;
                  String tooltip;

                  switch (loopState.loopMode) {
                    case just_audio.LoopMode.off:
                      loopIcon = Icons.repeat_rounded;
                      loopColor =
                          isDark ? Colors.grey.shade600 : Colors.grey.shade400;
                      tooltip = "Loop: Off";
                      break;
                    case just_audio.LoopMode.all:
                      loopIcon = Icons.repeat_rounded;
                      loopColor = themeState.primary;
                      tooltip = "Loop: All (Range/Playlist)";
                      break;
                    case just_audio.LoopMode.one:
                      loopIcon = Icons.repeat_one_rounded;
                      loopColor = themeState.primary;
                      tooltip = "Loop: Single Ayah";
                      break;
                  }

                  return IconButton(
                    iconSize: 18,
                    visualDensity: VisualDensity.compact,
                    tooltip: tooltip,
                    onPressed: () =>
                        context.read<AudioLoopCubit>().toggleQuickLoopMode(),
                    icon: Icon(loopIcon, color: loopColor),
                  );
                },
              ),

              IconButton(
                iconSize: 22,
                visualDensity: VisualDensity.compact,
                tooltip: "Previous",
                onPressed:
                    hasPrev ? () => AudioPlayerManager.seekToPreviousAyah() : null,
                icon: const Icon(Icons.skip_previous_rounded),
              ),
              const Gap(2),

              BlocBuilder<PlayerStateCubit, PlayerState>(
                builder: (context, _) {
                  return IconButton(
                    iconSize: 18,
                    visualDensity: VisualDensity.compact,
                    tooltip: "Replay 5s",
                    onPressed: AudioPlayerManager.hasActivePlayer
                        ? () => AudioPlayerManager.seekRelative(
                              const Duration(seconds: -5),
                            )
                        : null,
                    icon: const Icon(Icons.replay_5_rounded),
                  );
                },
              ),
              const Gap(6),

              BlocBuilder<PlayerStateCubit, PlayerState>(
                builder: (context, state) {
                  final isLoading =
                      state.state == just_audio.ProcessingState.loading ||
                          state.state == just_audio.ProcessingState.buffering;

                  return Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeState.primary,
                      boxShadow: [
                        BoxShadow(
                          color: themeState.primary.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => AudioPlayerManager.togglePlayPause(),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Icon(
                                  state.isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 26,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Gap(6),

              BlocBuilder<PlayerStateCubit, PlayerState>(
                builder: (context, _) {
                  return IconButton(
                    iconSize: 18,
                    visualDensity: VisualDensity.compact,
                    tooltip: "Forward 5s",
                    onPressed: AudioPlayerManager.hasActivePlayer
                        ? () => AudioPlayerManager.seekRelative(
                              const Duration(seconds: 5),
                            )
                        : null,
                    icon: const Icon(Icons.forward_5_rounded),
                  );
                },
              ),
              const Gap(2),

              IconButton(
                iconSize: 22,
                visualDensity: VisualDensity.compact,
                tooltip: "Next",
                onPressed:
                    hasNext ? () => AudioPlayerManager.seekToNextAyah() : null,
                icon: const Icon(Icons.skip_next_rounded),
              ),

              IconButton(
                iconSize: 18,
                visualDensity: VisualDensity.compact,
                tooltip: "Ayah Range & Memorization",
                icon: Icon(
                  FluentIcons.arrow_repeat_all_20_regular,
                  color: context.watch<AudioLoopCubit>().state.isRangeActive
                      ? themeState.primary
                      : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                ),
                onPressed: () {
                  popupAyahRangeSelector(
                    context,
                    initialSurah: surahNumber,
                    initialStartAyah: ayahNumber,
                    isInsideQuran: true,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
