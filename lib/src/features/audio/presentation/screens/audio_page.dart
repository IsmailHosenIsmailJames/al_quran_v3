import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/playback_speed_bottom_sheet.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/popup_ayah_range_selector.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_view_widget.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/sleep_timer_bottom_sheet.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/gen_ayahs_key.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (surahNameLocalization.isEmpty || surahMeaningLocalization.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          buildWhen: (prev, curr) => prev.current != curr.current,
          builder: (context, ayahKeyState) {
            final parts = ayahKeyState.current.split(":");
            final surahNumber = int.tryParse(parts[0]) ?? 1;
            final ayahNumber =
                int.tryParse(parts.length > 1 ? parts[1] : "1") ?? 1;
            final currentIndex = ayahNumber - 1;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: isLandscape
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Panel: Reciter, Surah Selector & Controls
                          Expanded(
                            flex: 5,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: height >= 600 ? 16 : 0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Gap(height >= 600 ? 24 : 16),
                                    _buildProgressBar(themeState),
                                    Gap(height >= 600 ? 16 : 10),
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
                          ),
                          const Gap(16),
                          // Right Panel: Hero Arabic Ayah Card
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                _buildRangeStatusBanner(
                                  context,
                                  themeState,
                                  isDark,
                                ),
                                _buildSleepTimerBanner(
                                  context,
                                  themeState,
                                  isDark,
                                ),
                                Expanded(
                                  child: _buildHeroArabicAyahCard(
                                    context,
                                    surahNumber,
                                    ayahNumber,
                                    themeState,
                                    isDark,
                                  ),
                                ),
                              ],
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
                          const Gap(8),
                          // Surah Selector
                          _buildSurahSelectorBar(
                            context,
                            ayahKeyState,
                            themeState,
                          ),
                          const Gap(6),
                          // Range Status Banner (if active)
                          _buildRangeStatusBanner(context, themeState, isDark),
                          // Sleep Timer Banner (if active)
                          _buildSleepTimerBanner(context, themeState, isDark),
                          // Hero Arabic Ayah Card
                          Expanded(
                            child: _buildHeroArabicAyahCard(
                              context,
                              surahNumber,
                              ayahNumber,
                              themeState,
                              isDark,
                            ),
                          ),
                          const Gap(12),
                          // Audio Scrubber
                          _buildProgressBar(themeState),
                          const Gap(6),
                          // Audio Controls Cluster
                          _buildPlaybackControls(
                            context,
                            currentIndex,
                            ayahKeyState,
                            themeState,
                            l10n,
                          ),
                          const Gap(6),
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
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(roundedRadius + 2),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          // Previous Surah Button
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            tooltip: "Previous Surah",
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
                      reciterInfoModel: context
                          .read<AudioTabReciterCubit>()
                          .state,
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
                  final ayahNumber = ayahKeyState.current.split(":")[1].toInt();
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
                      final toStartIndex = ayahKey.split(":")[1].toInt() - 1;

                      AudioPlayerManager.playMultipleAyahAsPlaylist(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
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
                          "${getSurahName(context, surahNumber)} • Ayah ${ayahKeyState.current.split(':')[1]} of ${quranAyahCount[surahNumber - 1]}",
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

          // Memorization / Range Looper
          BlocBuilder<AudioLoopCubit, AudioLoopState>(
            builder: (context, loopState) {
              return IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                tooltip: "Ayah Range & Memorization",
                icon: Icon(
                  FluentIcons.arrow_repeat_all_20_regular,
                  color: loopState.isRangeActive
                      ? themeState.primary
                      : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                onPressed: () {
                  popupAyahRangeSelector(
                    context,
                    initialSurah: surahNumber,
                    initialStartAyah: ayahKeyState.current
                        .split(":")[1]
                        .toInt(),
                  );
                },
              );
            },
          ),

          // Next Surah Button
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            tooltip: "Next Surah",
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
                      reciterInfoModel: context
                          .read<AudioTabReciterCubit>()
                          .state,
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }

  /// Banner indicating active Range & Repetition mode
  Widget _buildRangeStatusBanner(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
  ) {
    return BlocBuilder<AudioLoopCubit, AudioLoopState>(
      builder: (context, loopState) {
        if (!loopState.isRangeActive) return const SizedBox.shrink();

        final cycleText = loopState.repeatTargetCount == -1
            ? "Cycle ${loopState.currentRangeCycle}/∞"
            : "Cycle ${loopState.currentRangeCycle}/${loopState.repeatTargetCount}";

        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(roundedRadius),
            border: Border.all(
              color: themeState.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Icon(
                FluentIcons.arrow_repeat_all_20_filled,
                color: themeState.primary,
                size: 16,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  "Memorizing: ${getSurahName(context, loopState.startSurah)} ${loopState.startAyah}–${loopState.endAyah} • $cycleText",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: themeState.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                iconSize: 16,
                tooltip: "Adjust Range",
                onPressed: () => popupAyahRangeSelector(context),
                icon: const Icon(Icons.tune_rounded),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                iconSize: 16,
                tooltip: "Stop Range",
                onPressed: () => context.read<AudioLoopCubit>().clearRange(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Banner indicating active Sleep Timer
  Widget _buildSleepTimerBanner(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
  ) {
    return BlocBuilder<SleepTimerCubit, SleepTimerState>(
      builder: (context, timerState) {
        if (!timerState.isActive) return const SizedBox.shrink();

        final statusText = timerState.isEndOfSurah
            ? "Stop at end of Surah"
            : "${_formatRemaining(timerState.remainingDuration)} remaining";

        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: isDark ? 0.15 : 0.1),
            borderRadius: BorderRadius.circular(roundedRadius),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(
                FluentIcons.timer_20_filled,
                color: Colors.amber,
                size: 16,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  "Sleep Timer: $statusText",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                iconSize: 16,
                tooltip: "Cancel Timer",
                onPressed: () => context.read<SleepTimerCubit>().cancelTimer(),
                icon: const Icon(Icons.close_rounded, color: Colors.amber),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatRemaining(Duration? duration) {
    if (duration == null) return "0:00";
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  /// Dedicated Hero Arabic Ayah Card with crystal-clear typography, Surah header, and word highlighting
  Widget _buildHeroArabicAyahCard(
    BuildContext context,
    int surahNumber,
    int ayahNumber,
    ThemeState themeState,
    bool isDark,
  ) {
    final surahMeta = metaDataSurah[surahNumber.toString()];
    final surahModel = surahMeta != null
        ? SurahInfoModel.fromMap(surahMeta)
        : null;
    final totalVerses = quranAyahCount[surahNumber - 1];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius + 6),
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: themeState.primary.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          // Surah & Verse Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.02)
                  : themeState.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(roundedRadius + 6),
              ),
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              children: [
                // Surah Name in Arabic font
                if (surahModel != null)
                  Text(
                    "surah${surahModel.id.toString().padLeft(3, '0')}",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: "surah-name-v1",
                      fontSize: 22,
                      color: themeState.primary,
                    ),
                  ),
                const Gap(10),
                // Verse Counter Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: themeState.primary.withValues(
                      alpha: isDark ? 0.2 : 0.12,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Verse $ayahNumber of $totalVerses",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: themeState.primary,
                    ),
                  ),
                ),
                const Spacer(),

                // Script Switcher & Tajweed Action Chip
                BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, quranViewState) {
                    final isUthmani =
                        quranViewState.quranScriptType ==
                        QuranScriptType.uthmani;

                    return PopupMenuButton<String>(
                      tooltip: "Script & Font Settings",
                      icon: Icon(
                        FluentIcons.text_font_size_20_regular,
                        size: 18,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                      onSelected: (value) {
                        final cubit = context.read<QuranViewCubit>();
                        if (value == "uthmani") {
                          cubit.changeScript(QuranScriptType.uthmani);
                        } else if (value == "indopak") {
                          cubit.changeScript(QuranScriptType.indopak);
                        } else if (value == "tajweed") {
                          if (isUthmani) {
                            cubit.toggleTajweedOnUthmani();
                          } else {
                            cubit.toggleTajweedOnIndopak();
                          }
                        } else if (value == "font_plus") {
                          cubit.changeFontSize(quranViewState.fontSize + 2);
                        } else if (value == "font_minus") {
                          if (quranViewState.fontSize > 16) {
                            cubit.changeFontSize(quranViewState.fontSize - 2);
                          }
                        }
                      },
                      itemBuilder: (context) {
                        final isTajweed = isUthmani
                            ? quranViewState.useTajweedOnUthmani
                            : quranViewState.useTajweedOnIndopak;

                        return [
                          PopupMenuItem(
                            value: "uthmani",
                            child: Row(
                              children: [
                                Icon(
                                  isUthmani
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  size: 18,
                                  color: isUthmani ? themeState.primary : null,
                                ),
                                const Gap(10),
                                const Text("Uthmani Script (Madani)"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: "indopak",
                            child: Row(
                              children: [
                                Icon(
                                  !isUthmani
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  size: 18,
                                  color: !isUthmani ? themeState.primary : null,
                                ),
                                const Gap(10),
                                const Text("IndoPak Script (Asian)"),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: "tajweed",
                            child: Row(
                              children: [
                                Icon(
                                  isTajweed
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  size: 18,
                                  color: isTajweed ? themeState.primary : null,
                                ),
                                const Gap(10),
                                const Text("Tajweed Color Rules"),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem(
                            value: "font_plus",
                            child: Row(
                              children: [
                                Icon(Icons.zoom_in_rounded, size: 18),
                                Gap(10),
                                Text("Increase Font Size"),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: "font_minus",
                            child: Row(
                              children: [
                                Icon(Icons.zoom_out_rounded, size: 18),
                                Gap(10),
                                Text("Decrease Font Size"),
                              ],
                            ),
                          ),
                        ];
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // Arabic Quran Text Body
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return ScriptProcessor(
                      scriptInfo: ScriptInfo(
                        surahNumber: surahNumber,
                        ayahNumber: ayahNumber,
                        quranScriptType: state.quranScriptType,
                        textStyle: TextStyle(
                          fontSize: state.fontSize.clamp(20.0, 48.0),
                          height: state.lineHeight.clamp(1.8, 3.0),
                        ),
                        textAlign: TextAlign.center,
                        skipWordTap: true,
                        showWordHighlights: true,
                      ),
                      themeState: themeState,
                      tajweedColorEnable:
                          state.quranScriptType == QuranScriptType.uthmani
                          ? state.useTajweedOnUthmani
                          : state.useTajweedOnIndopak,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Playback Speed Button
          IconButton(
            tooltip: "Playback Speed",
            iconSize: 22,
            visualDensity: VisualDensity.compact,
            icon: Text(
              "${AudioPlayerManager.audioPlayer.speed}x",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            onPressed: () => showPlaybackSpeedBottomSheet(context),
          ),
          const Gap(4),

          // Loop Mode Quick-Toggle
          BlocBuilder<AudioLoopCubit, AudioLoopState>(
            builder: (context, loopState) {
              IconData loopIcon;
              Color? loopColor;
              String tooltip;

              switch (loopState.loopMode) {
                case LoopMode.off:
                  loopIcon = Icons.repeat_rounded;
                  loopColor = isDark
                      ? Colors.grey.shade600
                      : Colors.grey.shade400;
                  tooltip = "Loop: Off";
                  break;
                case LoopMode.all:
                  loopIcon = Icons.repeat_rounded;
                  loopColor = themeState.primary;
                  tooltip = "Loop: All (Range/Playlist)";
                  break;
                case LoopMode.one:
                  loopIcon = Icons.repeat_one_rounded;
                  loopColor = themeState.primary;
                  tooltip = "Loop: Single Ayah";
                  break;
              }

              return IconButton(
                tooltip: tooltip,
                iconSize: 22,
                visualDensity: VisualDensity.compact,
                icon: Icon(loopIcon, color: loopColor),
                onPressed: () =>
                    context.read<AudioLoopCubit>().toggleQuickLoopMode(),
              );
            },
          ),
          const Gap(4),

          // Previous Ayah
          IconButton(
            tooltip: "Previous Ayah",
            iconSize: 26,
            icon: const Icon(Icons.skip_previous_rounded),
            onPressed: currentIndex > 0
                ? () {
                    if (AudioPlayerManager.audioPlayer.audioSource == null) {
                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        startAyahKey: ayahKeyState.ayahList.first,
                        endAyahKey: ayahKeyState.ayahList.last,
                        isInsideQuran: false,
                        reciterInfoModel: context
                            .read<AudioTabReciterCubit>()
                            .state,
                        instantPlay: true,
                        initialIndex: currentIndex - 1,
                      );
                    } else {
                      AudioPlayerManager.audioPlayer.seekToPrevious();
                    }
                  }
                : null,
          ),
          const Gap(4),

          // Replay 5s
          IconButton(
            tooltip: "Replay 5s",
            iconSize: 22,
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
          const Gap(8),

          // Hero Play / Pause Button
          BlocBuilder<PlayerStateCubit, PlayerState>(
            builder: (context, state) {
              final isLoading =
                  state.state == ProcessingState.loading ||
                  state.state == ProcessingState.buffering;

              return Container(
                width: 62,
                height: 62,
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
                          final surahNumber = ayahKeyState.ayahList.first.split(
                            ":",
                          )[0];
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
                          reciterInfoModel: context
                              .read<AudioTabReciterCubit>()
                              .state,
                        );
                        return;
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
                              size: 38,
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
            tooltip: "Forward 5s",
            iconSize: 22,
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
          const Gap(4),

          // Next Ayah
          IconButton(
            tooltip: "Next Ayah",
            iconSize: 26,
            icon: const Icon(Icons.skip_next_rounded),
            onPressed: currentIndex < (ayahKeyState.ayahList.length - 1)
                ? () {
                    if (AudioPlayerManager.audioPlayer.audioSource == null) {
                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        startAyahKey: ayahKeyState.ayahList.first,
                        endAyahKey: ayahKeyState.ayahList.last,
                        isInsideQuran: false,
                        reciterInfoModel: context
                            .read<AudioTabReciterCubit>()
                            .state,
                        instantPlay: true,
                        initialIndex: currentIndex + 1,
                      );
                    } else {
                      AudioPlayerManager.audioPlayer.seekToNext();
                    }
                  }
                : null,
          ),
          const Gap(4),

          // Sleep Timer Button
          IconButton(
            tooltip: "Sleep Timer",
            iconSize: 22,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              FluentIcons.timer_20_regular,
              color: context.watch<SleepTimerCubit>().state.isActive
                  ? Colors.amber
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
            ),
            onPressed: () => showSleepTimerBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
