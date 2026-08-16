import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_view_widget.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/gen_ayahs_key.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" hide PlayerState;

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  void initState() {
    super.initState();
    if (surahNameLocalization.isEmpty || surahMeaningLocalization.isEmpty) {
      loadMetaSurah().then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isLandscape = width > 900 || (height < 600 && width > 500);
    final l10n = AppLocalizations.of(context);

    if (surahNameLocalization.isEmpty || surahMeaningLocalization.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          buildWhen: (prev, curr) => prev.current != curr.current,
          builder: (context, ayahKeyState) {
            final currentIndex =
                int.parse(ayahKeyState.current.split(":")[1]) - 1;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: isLandscape
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Panel: Reciter, Surah Selector & Controls
                          Expanded(
                            flex: 5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  getReciterViewWidget(
                                    context,
                                    ayahKeyState,
                                    currentIndex,
                                  ),
                                  const Gap(12),
                                  _buildSurahSelectorBar(
                                    context,
                                    ayahKeyState,
                                    themeState,
                                  ),
                                  const Gap(24),
                                  _buildProgressBar(themeState),
                                  const Gap(12),
                                  _buildPlaybackControls(
                                    context,
                                    currentIndex,
                                    ayahKeyState,
                                    themeState,
                                    l10n,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                          // Right Panel: Ayah & Translation Card
                          Expanded(
                            flex: 6,
                            child: _buildAyahCard(
                              context,
                              ayahKeyState,
                              themeState,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          // Reciter Profile
                          getReciterViewWidget(
                            context,
                            ayahKeyState,
                            currentIndex,
                          ),
                          const Gap(10),
                          // Surah Selector
                          _buildSurahSelectorBar(
                            context,
                            ayahKeyState,
                            themeState,
                          ),
                          const Gap(10),
                          // Listening Ayah Card
                          Expanded(
                            child: _buildAyahCard(
                              context,
                              ayahKeyState,
                              themeState,
                            ),
                          ),
                          const Gap(16),
                          // Audio Scrubber
                          _buildProgressBar(themeState),
                          const Gap(8),
                          // Audio Controls Cluster
                          _buildPlaybackControls(
                            context,
                            currentIndex,
                            ayahKeyState,
                            themeState,
                            l10n,
                          ),
                          const Gap(8),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  /// Modern Surah & Ayah selector bar with back/forward quick navigation
  Widget _buildSurahSelectorBar(
    BuildContext context,
    AyahKeyManagement ayahKeyState,
    ThemeState themeState,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surahNumber = ayahKeyState.current.split(":")[0].toInt();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : themeState.primaryShade100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(roundedRadius + 2),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : themeState.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Previous Surah Button
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            onPressed: surahNumber > 1
                ? () {
                    final prevSurah = surahNumber - 1;
                    final ayahList = getListOfAyahKey(
                      startAyahKey: "$prevSurah:1",
                      endAyahKey: getEndAyahKeyFromSurahNumber(prevSurah),
                    )..removeWhere((e) => e.runtimeType != String);

                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahList.first as String,
                      endAyahKey: ayahList.last as String,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),

          // Central Surah / Ayah Trigger
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(roundedRadius),
                onTap: () async {
                  final ayahNumber =
                      ayahKeyState.current.split(":")[1].toInt();
                  await popupJumpToAyah(
                    context: context,
                    initAyahKey: "$surahNumber:$ayahNumber",
                    isAudioPlayer: true,
                    onPlaySelected: (ayahKey) {
                      final startSurah = ayahKey.split(":")[0];
                      final startAyahKey = "$startSurah:1";
                      final endAyahKey = getEndAyahKeyFromSurahNumber(
                        int.parse(startSurah),
                      );
                      final toStartIndex =
                          ayahKey.split(":")[1].toInt() - 1;

                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        startAyahKey: startAyahKey,
                        endAyahKey: endAyahKey,
                        isInsideQuran: false,
                        instantPlay: true,
                        initialIndex: toStartIndex,
                        reciterInfoModel:
                            context.read<SegmentedQuranReciterCubit>().state,
                      );
                    },
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FluentIcons.book_open_20_regular,
                        size: 18,
                        color: themeState.primary,
                      ),
                      const Gap(8),
                      Flexible(
                        child: Text(
                          "${getSurahName(context, surahNumber)} • ${getAyahLocalized(context, ayahKeyState.current)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Icon(
                        Icons.unfold_more_rounded,
                        size: 18,
                        color: theme.hintColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Next Surah Button
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            onPressed: surahNumber < 114
                ? () {
                    final nextSurah = surahNumber + 1;
                    final ayahList = getListOfAyahKey(
                      startAyahKey: "$nextSurah:1",
                      endAyahKey: getEndAyahKeyFromSurahNumber(nextSurah),
                    )..removeWhere((e) => e.runtimeType != String);

                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahList.first as String,
                      endAyahKey: ayahList.last as String,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }

  /// Modern Ayah and Translation Card with smooth styling and typography
  Widget _buildAyahCard(
    BuildContext context,
    AyahKeyManagement ayahKeyState,
    ThemeState themeState,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius + 4),
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : themeState.primaryShade100.withValues(alpha: 0.35),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : themeState.primary.withValues(alpha: 0.12),
        ),
      ),
      child: FutureBuilder(
        future: QuranTranslationFunction.getTranslation(ayahKeyState.current),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: themeState.primary,
                ),
              ),
            );
          }

          final String translation =
              snapshot.data?.firstOrNull?.translation?["t"]?.toString() ??
                  AppLocalizations.of(context).translationNotFound;
          final String formattedTranslation = translation.replaceAll(">", "> ");

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Arabic Script
                BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return ScriptProcessor(
                      scriptInfo: ScriptInfo(
                        surahNumber:
                            ayahKeyState.current.split(":")[0].toInt(),
                        ayahNumber:
                            ayahKeyState.current.split(":")[1].toInt(),
                        quranScriptType: state.quranScriptType,
                        textStyle: TextStyle(
                          fontSize: state.fontSize,
                          height: state.lineHeight,
                        ),
                        textAlign: TextAlign.center,
                        skipWordTap: true,
                        showWordHighlights: false,
                      ),
                      themeState: themeState,
                      tajweedColorEnable:
                          state.quranScriptType == QuranScriptType.uthmani
                              ? state.useTajweedOnUthmani
                              : state.useTajweedOnIndopak,
                    );
                  },
                ),
                const Gap(14),
                // Subtle Decorative Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : themeState.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        FluentIcons.sparkle_16_filled,
                        size: 12,
                        color: themeState.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : themeState.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                // Translation Text
                BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return Html(
                      data: formattedTranslation.capitalize(),
                      style: {
                        "*": Style(
                          fontSize: FontSize(state.translationFontSize),
                          lineHeight: const LineHeight(1.5),
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          alignment: Alignment.center,
                          textAlign: TextAlign.center,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade800,
                        ),
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Modern Audio Progress Bar
  Widget _buildProgressBar(ThemeState themeState) {
    return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return ProgressBar(
          progress: state.currentDuration ?? Duration.zero,
          buffered: state.bufferDuration ?? Duration.zero,
          total: state.totalDuration ?? Duration.zero,
          thumbCanPaintOutsideBar: false,
          barHeight: 5,
          thumbRadius: 7,
          thumbGlowRadius: 18,
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
            fontSize: 12,
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

  /// Balanced, tactile playback control cluster
  Widget _buildPlaybackControls(
    BuildContext context,
    int currentIndex,
    AyahKeyManagement ayahKeyState,
    ThemeState themeState,
    AppLocalizations l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous Ayah
        IconButton(
          tooltip: "Previous Ayah",
          iconSize: 28,
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed: currentIndex > 0
              ? () {
                  if (AudioPlayerManager.audioPlayer.audioSource == null) {
                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahKeyState.ayahList.first,
                      endAyahKey: ayahKeyState.ayahList.last,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                      instantPlay: true,
                      initialIndex: currentIndex - 1,
                    );
                  } else {
                    AudioPlayerManager.audioPlayer.seekToPrevious();
                  }
                }
              : null,
        ),
        const Gap(6),

        // Replay 5s
        IconButton(
          tooltip: "Replay 5s",
          iconSize: 24,
          icon: const Icon(Icons.replay_5_rounded),
          onPressed: AudioPlayerManager.audioPlayer.audioSource == null
              ? null
              : () {
                  final duration = AudioPlayerManager.audioPlayer.duration;
                  var position = AudioPlayerManager.audioPlayer.position;
                  position = position - const Duration(seconds: 5);
                  if (duration == null) return;
                  if (position < Duration.zero) position = Duration.zero;
                  AudioPlayerManager.audioPlayer.seek(position);
                },
        ),
        const Gap(10),

        // Hero Play / Pause Button
        BlocBuilder<PlayerStateCubit, PlayerState>(
          builder: (context, state) {
            final isLoading = state.state == ProcessingState.loading ||
                state.state == ProcessingState.buffering;

            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeState.primary,
                boxShadow: [
                  BoxShadow(
                    color: themeState.primary.withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () async {
                    if (AudioPlayerManager.audioPlayer.audioSource == null) {
                      var ayahKeysToPlay = ayahKeyState.ayahList;
                      if (ayahKeyState.ayahList.length == 1) {
                        final surahNumber =
                            ayahKeyState.ayahList.first.split(":")[0];
                        final startAyahKey = ayahKeyState.ayahList.first;
                        final endAyahKey = getEndAyahKeyFromSurahNumber(
                          int.parse(surahNumber),
                        );
                        final temList = getListOfAyahKey(
                          startAyahKey: startAyahKey,
                          endAyahKey: endAyahKey,
                        )..removeWhere((e) => e.runtimeType != String);
                        ayahKeysToPlay = List<String>.from(temList);
                      }

                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        startAyahKey: ayahKeysToPlay.first,
                        endAyahKey: ayahKeysToPlay.last,
                        isInsideQuran: false,
                        initialIndex: currentIndex,
                        instantPlay: true,
                        reciterInfoModel:
                            context.read<AudioTabReciterCubit>().state,
                      );
                      return;
                    } else if (context
                        .read<AudioUiCubit>()
                        .state
                        .isInsideQuranPlayer) {
                      log("Inside Quran Player");
                    }

                    AudioPlayerManager.audioPlayer.playing
                        ? AudioPlayerManager.audioPlayer.pause()
                        : AudioPlayerManager.audioPlayer.play();
                  },
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            state.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 38,
                          ),
                  ),
                ),
              ),
            );
          },
        ),
        const Gap(10),

        // Forward 5s
        IconButton(
          tooltip: "Forward 5s",
          iconSize: 24,
          icon: const Icon(Icons.forward_5_rounded),
          onPressed: AudioPlayerManager.audioPlayer.audioSource == null
              ? null
              : () {
                  final duration = AudioPlayerManager.audioPlayer.duration;
                  var position = AudioPlayerManager.audioPlayer.position;
                  position = position + const Duration(seconds: 5);
                  if (duration == null) return;
                  if (position > duration) position = duration;
                  AudioPlayerManager.audioPlayer.seek(position);
                },
        ),
        const Gap(6),

        // Next Ayah
        IconButton(
          tooltip: "Next Ayah",
          iconSize: 28,
          icon: const Icon(Icons.skip_next_rounded),
          onPressed: currentIndex < (ayahKeyState.ayahList.length - 1)
              ? () {
                  if (AudioPlayerManager.audioPlayer.audioSource == null) {
                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahKeyState.ayahList.first,
                      endAyahKey: ayahKeyState.ayahList.last,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                      instantPlay: true,
                      initialIndex: currentIndex + 1,
                    );
                  } else {
                    AudioPlayerManager.audioPlayer.seekToNext();
                  }
                }
              : null,
        ),
      ],
    );
  }
}
