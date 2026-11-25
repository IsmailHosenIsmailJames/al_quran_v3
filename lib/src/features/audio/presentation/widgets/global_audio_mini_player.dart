import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

/// Compact global audio mini-player rendered on Home tabs whenever recitation
/// audio is active in memory so users can pause, skip, or jump to the Ayah.
class GlobalAudioMiniPlayer extends StatelessWidget {
  const GlobalAudioMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
      builder: (context, audioUiState) {
        if (!audioUiState.showUi) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          builder: (context, ayahKeyState) {
            final surahNum =
                int.tryParse(ayahKeyState.current.split(":").first) ?? 1;
            final currentIndex =
                ayahKeyState.ayahList.indexOf(ayahKeyState.current);
            final hasPrevious = currentIndex > 0;
            final hasNext = currentIndex != -1 &&
                currentIndex < ayahKeyState.ayahList.length - 1;

            return Container(
              margin: const EdgeInsets.fromLTRB(10, 4, 10, 6),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(roundedRadius),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : themeState.primary.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final rawMeta = metaDataSurah["$surahNum"];
                        final int totalVerses =
                            (rawMeta?["vc"] as int?) ?? 7;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuranScriptView(
                              startKey: "$surahNum:1",
                              endKey: "$surahNum:$totalVerses",
                              toScrollKey: ayahKeyState.current,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: themeState.primary.withValues(alpha: 0.14),
                                shape: BoxShape.circle,
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${getSurahName(context, surahNum)} • ${getAyahLocalized(context, ayahKeyState.current)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium?.copyWith(
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
                                          fontSize: 11.5,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              iconSize: 20,
                              tooltip: "Previous",
                              onPressed: hasPrevious
                                  ? () => AudioPlayerManager.seekToPreviousAyah()
                                  : null,
                              icon: const Icon(Icons.skip_previous_rounded),
                            ),
                            BlocBuilder<PlayerStateCubit, PlayerState>(
                              builder: (context, playerState) {
                                final isLoading = playerState.state ==
                                        just_audio.ProcessingState.loading ||
                                    playerState.state ==
                                        just_audio.ProcessingState.buffering;
                                return IconButton.filledTonal(
                                  visualDensity: VisualDensity.compact,
                                  style: IconButton.styleFrom(
                                    backgroundColor: themeState.primary
                                        .withValues(alpha: 0.14),
                                    foregroundColor: themeState.primary,
                                  ),
                                  onPressed: () =>
                                      AudioPlayerManager.togglePlayPause(),
                                  icon: isLoading
                                      ? SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: themeState.primary,
                                          ),
                                        )
                                      : Icon(
                                          playerState.isPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          size: 20,
                                        ),
                                );
                              },
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              iconSize: 20,
                              tooltip: "Next",
                              onPressed: hasNext
                                  ? () => AudioPlayerManager.seekToNextAyah()
                                  : null,
                              icon: const Icon(Icons.skip_next_rounded),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              iconSize: 18,
                              tooltip: "Stop",
                              onPressed: () =>
                                  AudioPlayerManager.stopPlayback(hideUi: true),
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
                    builder: (context, posState) {
                      final total = posState.totalDuration?.inMilliseconds ?? 0;
                      final cur = posState.currentDuration?.inMilliseconds ?? 0;
                      final double progress =
                          total > 0 ? (cur / total).clamp(0.0, 1.0) : 0.0;
                      return LinearProgressIndicator(
                        value: progress,
                        minHeight: 2.2,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          themeState.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
