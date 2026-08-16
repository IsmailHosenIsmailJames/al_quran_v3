import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
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
          // Collapsed Floating Action Pill
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

        // Expanded Floating Glass Player Card
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(roundedRadius + 4),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E1E1E).withValues(alpha: 0.88)
                        : Colors.white.withValues(alpha: 0.92),
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
                      // Header Row: Surah/Ayah Info + Action Buttons
                      _buildHeader(context, themeState, l10n),
                      const Gap(8),
                      // Progress Slider
                      _buildProgressSlider(context, themeState),
                      const Gap(6),
                      // Playback Controls
                      _buildControls(context, themeState, l10n, isLandscape),
                    ],
                  ),
                ),
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
            // Playing Status Indicator
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
            // Title Info
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
                  BlocBuilder<SegmentedQuranReciterCubit, dynamic>(
                    builder: (context, reciter) {
                      return Text(
                        reciter.name ?? "",
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
            // Close / Stop Player
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              tooltip: l10n.closeAudioController,
              onPressed: () {
                AudioPlayerManager.audioPlayer.stop();
                context.read<AudioUiCubit>().showUI(false);
              },
              icon: const Icon(Icons.close_rounded),
            ),
            // Minimize to Fab
            IconButton(
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              tooltip: "Minimize",
              onPressed: () {
                context.read<AudioUiCubit>().expand(false);
              },
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
        if (progress > total && total > Duration.zero) progress = total;
        if (buffered > total && total > Duration.zero) buffered = total;

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
          onSeek: (duration) {
            AudioPlayerManager.audioPlayer.seek(duration);
          },
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
        final totalAyahsInSurah =
            quranAyahCount[surahNumber - 1];

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Ayah
            IconButton(
              iconSize: 22,
              visualDensity: VisualDensity.compact,
              tooltip: "Previous",
              onPressed: ayahNumber > 1
                  ? () {
                      if (AudioPlayerManager.audioPlayer.audioSource != null) {
                        AudioPlayerManager.audioPlayer.seekToPrevious();
                      }
                    }
                  : null,
              icon: const Icon(Icons.skip_previous_rounded),
            ),
            const Gap(4),

            // Replay 5s
            IconButton(
              iconSize: 20,
              visualDensity: VisualDensity.compact,
              tooltip: "Replay 5s",
              onPressed: AudioPlayerManager.audioPlayer.audioSource == null
                  ? null
                  : () {
                      final duration =
                          AudioPlayerManager.audioPlayer.duration;
                      var pos = AudioPlayerManager.audioPlayer.position;
                      pos = pos - const Duration(seconds: 5);
                      if (duration == null) return;
                      if (pos < Duration.zero) pos = Duration.zero;
                      AudioPlayerManager.audioPlayer.seek(pos);
                    },
              icon: const Icon(Icons.replay_5_rounded),
            ),
            const Gap(8),

            // Play / Pause Hero Button
            BlocBuilder<PlayerStateCubit, PlayerState>(
              builder: (context, state) {
                final isLoading =
                    state.state == just_audio.ProcessingState.loading ||
                        state.state == just_audio.ProcessingState.buffering;

                return Container(
                  width: 48,
                  height: 48,
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
                      onTap: () {
                        if (AudioPlayerManager.audioPlayer.audioSource == null) {
                          return;
                        }
                        AudioPlayerManager.audioPlayer.playing
                            ? AudioPlayerManager.audioPlayer.pause()
                            : AudioPlayerManager.audioPlayer.play();
                      },
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Icon(
                                state.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(8),

            // Forward 5s
            IconButton(
              iconSize: 20,
              visualDensity: VisualDensity.compact,
              tooltip: "Forward 5s",
              onPressed: AudioPlayerManager.audioPlayer.audioSource == null
                  ? null
                  : () {
                      final duration =
                          AudioPlayerManager.audioPlayer.duration;
                      var pos = AudioPlayerManager.audioPlayer.position;
                      pos = pos + const Duration(seconds: 5);
                      if (duration == null) return;
                      if (pos > duration) pos = duration;
                      AudioPlayerManager.audioPlayer.seek(pos);
                    },
              icon: const Icon(Icons.forward_5_rounded),
            ),
            const Gap(4),

            // Next Ayah
            IconButton(
              iconSize: 22,
              visualDensity: VisualDensity.compact,
              tooltip: "Next",
              onPressed: ayahNumber < totalAyahsInSurah
                  ? () {
                      if (AudioPlayerManager.audioPlayer.audioSource != null) {
                        AudioPlayerManager.audioPlayer.seekToNext();
                      }
                    }
                  : null,
              icon: const Icon(Icons.skip_next_rounded),
            ),
          ],
        );
      },
    );
  }
}
