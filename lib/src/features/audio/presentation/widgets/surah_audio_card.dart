import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/gen_ayahs_key.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class SurahAudioCard extends StatelessWidget {
  final SurahInfoModel surah;
  final EdgeInsetsGeometry? margin;

  const SurahAudioCard({
    super.key,
    required this.surah,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;

    return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
      builder: (context, ayahKeyState) {
        final currentSurahNumber =
            int.tryParse(ayahKeyState.current.split(":")[0]) ?? 0;
        final isCurrentlyPlayingSurah = currentSurahNumber == surah.id;

        return BlocBuilder<PlayerStateCubit, PlayerState>(
          builder: (context, playerState) {
            final isPlaying = isCurrentlyPlayingSurah && playerState.isPlaying;

            return Container(
              margin: margin ??
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: isCurrentlyPlayingSurah
                    ? themeState.primary.withValues(
                        alpha: isDark ? 0.12 : 0.08,
                      )
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.03)
                        : Colors.white),
                borderRadius: BorderRadius.circular(roundedRadius + 2),
                border: Border.all(
                  color: isCurrentlyPlayingSurah
                      ? themeState.primary.withValues(alpha: 0.4)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.grey.shade200),
                  width: isCurrentlyPlayingSurah ? 1.5 : 1.0,
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(roundedRadius + 2),
                  onTap: () {
                    _playSurah(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Surah Number Badge
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCurrentlyPlayingSurah
                                ? themeState.primary
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : themeState.primary.withValues(alpha: 0.1)),
                          ),
                          child: Center(
                            child: isPlaying
                                ? const Icon(
                                    Icons.equalizer_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : Text(
                                    "${surah.id}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isCurrentlyPlayingSurah
                                          ? Colors.white
                                          : themeState.primary,
                                    ),
                                  ),
                          ),
                        ),
                        const Gap(12),

                        // Surah Title & Metadata
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      getSurahName(context, surah.id),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isCurrentlyPlayingSurah
                                            ? themeState.primary
                                            : null,
                                      ),
                                    ),
                                  ),
                                  const Gap(6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.white
                                              .withValues(alpha: 0.06)
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      surah.revelationPlace == "makkah"
                                          ? "Makki"
                                          : "Madani",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(4),
                              Text(
                                "${surah.versesCount} Ayahs • ${getSurahMeaning(context, surah.id)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Arabic Calligraphy
                        Text(
                          getSurahNameArabic(surah.id),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: "surah-name-v1",
                            fontSize: 22,
                            color: isCurrentlyPlayingSurah
                                ? themeState.primary
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.9)
                                    : Colors.grey.shade800),
                          ),
                        ),
                        const Gap(10),

                        // Quick Actions: Jump & Play
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Jump to Ayah in this Surah
                            IconButton(
                              iconSize: 20,
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              tooltip: "Jump to Ayah",
                              icon: Icon(
                                FluentIcons.navigation_20_regular,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                              onPressed: () {
                                popupJumpToAyah(
                                  context: context,
                                  initAyahKey: "${surah.id}:1",
                                  isAudioPlayer: true,
                                  onPlaySelected: (ayahKey) {
                                    final startSurah = ayahKey.split(":")[0];
                                    final startAyahKey = "$startSurah:1";
                                    final endAyahKey =
                                        getEndAyahKeyFromSurahNumber(
                                      int.parse(startSurah),
                                    );
                                    final toStartIndex =
                                        int.parse(ayahKey.split(":")[1]) - 1;

                                    AudioPlayerManager
                                        .playMultipleAyahAsPlaylist(
                                      startAyahKey: startAyahKey,
                                      endAyahKey: endAyahKey,
                                      isInsideQuran: false,
                                      instantPlay: true,
                                      initialIndex: toStartIndex,
                                      reciterInfoModel: context
                                          .read<AudioTabReciterCubit>()
                                          .state,
                                    );
                                  },
                                );
                              },
                            ),

                            // Play / Pause Button
                            IconButton(
                              iconSize: 26,
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              tooltip: isPlaying ? "Pause" : "Play Surah",
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_circle_filled_rounded
                                    : Icons.play_circle_filled_rounded,
                                color: themeState.primary,
                              ),
                              onPressed: () {
                                if (isPlaying) {
                                  AudioPlayerManager.audioPlayer.pause();
                                } else {
                                  _playSurah(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _playSurah(BuildContext context) {
    final startAyahKey = "${surah.id}:1";
    final endAyahKey = getEndAyahKeyFromSurahNumber(surah.id);
    final temList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    )..removeWhere((e) => e.runtimeType != String);

    AudioPlayerManager.playMultipleAyahAsPlaylist(
      startAyahKey: temList.first as String,
      endAyahKey: temList.last as String,
      isInsideQuran: false,
      instantPlay: true,
      initialIndex: 0,
      reciterInfoModel: context.read<AudioTabReciterCubit>().state,
    );
  }
}
