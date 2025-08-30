import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/audio_controller_ui.dart";
import "package:al_quran_v3/src/core/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/core/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/screen/audio/settings/audio_settings.dart";
import "package:al_quran_v3/src/utils/basic_functions.dart";
import "package:al_quran_v3/src/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/gen_ayahs_key.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" hide PlayerState;

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "../../widget/audio/reciter_overview.dart";

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandScape = width > height;
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          builder: (context, ayahKeyState) {
            int currentIndex =
                int.parse(ayahKeyState.current.split(":")[1]) - 1;
            Map? translationMap = QuranTranslationFunction.getTranslation(
              ayahKeyState.current,
            );
            String translation =
                translationMap?["t"] ?? l10n.translationNotFound;
            translation = translation.replaceAll(">", "> ");
            return Padding(
              padding: const EdgeInsets.all(10),
              child:
                  isLandScape
                      ? SafeArea(
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: ListView(
                                children: [
                                  getCurrentReciterViewWidget(
                                    ayahKeyState,
                                    currentIndex,
                                  ),
                                  getSurahInfoAndController(
                                    ayahKeyState,
                                    context,
                                  ),
                                  const Gap(20),
                                  getAudioProgressBar(),
                                  const Gap(10),
                                  getAudioController(
                                    currentIndex,
                                    ayahKeyState,
                                    context,
                                    l10n,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: getAyahAndTranslation(
                                context,
                                ayahKeyState,
                                translation,
                              ),
                            ),
                          ],
                        ),
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCurrentReciterViewWidget(
                            ayahKeyState,
                            currentIndex,
                          ),
                          const Gap(10),
                          getSurahInfoAndController(ayahKeyState, context),

                          const Gap(10),
                          Expanded(
                            child: getAyahAndTranslation(
                              context,
                              ayahKeyState,
                              translation,
                            ),
                          ),
                          const Gap(20),
                          getAudioProgressBar(),
                          const Gap(10),
                          getAudioController(
                            currentIndex,
                            ayahKeyState,
                            context,
                            l10n,
                          ),
                          const Gap(10),
                        ],
                      ),
            );
          },
        );
      },
    );
  }

  BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>
  getAudioProgressBar() {
    return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
      builder: (context, state) {
        return ProgressBar(
          progress: state.currentDuration ?? Duration.zero,
          buffered: state.bufferDuration ?? Duration.zero,
          total: state.totalDuration ?? Duration.zero,
          thumbCanPaintOutsideBar: false,
          barHeight: 6,
          timeLabelLocation: TimeLabelLocation.sides,
          onSeek: (duration) {
            AudioPlayerManager.audioPlayer.seek(duration);
          },
        );
      },
    );
  }

  Widget getCurrentReciterViewWidget(
    AyahKeyManagement ayahKeyState,
    int currentIndex,
  ) {
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
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.read<ThemeCubit>().state.primaryShade100,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioSettings(needAppBar: true),
                ),
              );
            },
            icon: const Icon(FluentIcons.settings_24_filled),
          ),
        ),
      ],
    );
  }

  Row getAudioController(
    int currentIndex,
    AyahKeyManagement ayahKeyState,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed:
              currentIndex > 0
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
        const Gap(5),

        IconButton(
          icon: const Icon(Icons.replay_5_rounded),
          onPressed:
              AudioPlayerManager.audioPlayer.audioSource == null
                  ? null
                  : () {
                    Duration? duration =
                        AudioPlayerManager.audioPlayer.duration;
                    Duration position = AudioPlayerManager.audioPlayer.position;
                    position = position - const Duration(seconds: 5);
                    if (duration == null) {
                      return;
                    }
                    if (position < Duration.zero) {
                      position = Duration.zero;
                    }
                    AudioPlayerManager.audioPlayer.seek(position);
                  },
        ),
        const Gap(8),
        SizedBox(
          height: 70,
          width: 70,
          child: BlocBuilder<PlayerStateCubit, PlayerState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  if (AudioPlayerManager.audioPlayer.audioSource == null) {
                    List<String> ayahKeysToPlay = ayahKeyState.ayahList;
                    if (ayahKeyState.ayahList.length == 1) {
                      String surahNumber =
                          ayahKeyState.ayahList.first.split(":")[0];
                      String startAyahKey = ayahKeyState.ayahList.first;
                      String endAyahKey = getEndAyahKeyFromSurahNumber(
                        int.parse(surahNumber),
                      );
                      List<dynamic> temList = getListOfAyahKey(
                        startAyahKey: startAyahKey,
                        endAyahKey: endAyahKey,
                      );
                      temList.removeWhere(
                        (element) => element.runtimeType != String,
                      );
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
                tooltip: state.isPlaying ? l10n.pause : l10n.play,
                iconSize: 45,
                style: IconButton.styleFrom(padding: const EdgeInsets.all(5)),
                icon:
                    state.state == ProcessingState.loading
                        ? const CircularProgressIndicator()
                        : Icon(
                          state.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
              );
            },
          ),
        ),
        const Gap(8),
        IconButton(
          icon: const Icon(Icons.forward_5_rounded),
          onPressed:
              AudioPlayerManager.audioPlayer.audioSource == null
                  ? null
                  : () {
                    Duration? duration =
                        AudioPlayerManager.audioPlayer.duration;
                    Duration position = AudioPlayerManager.audioPlayer.position;
                    position = position + const Duration(seconds: 5);
                    if (duration == null) {
                      return;
                    }
                    if (position > duration) {
                      position = duration;
                    }
                    AudioPlayerManager.audioPlayer.seek(position);
                  },
        ),
        const Gap(5),
        IconButton(
          icon: const Icon(Icons.skip_next_rounded),
          onPressed:
              currentIndex < (ayahKeyState.ayahList.length - 1)
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

  Container getAyahAndTranslation(
    BuildContext context,
    AyahKeyManagement ayahKeyState,
    String translation,
  ) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: context.read<ThemeCubit>().state.primaryShade100,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 80),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<QuranViewCubit, QuranViewState>(
              builder: (context, state) {
                return ScriptProcessor(
                  scriptInfo: ScriptInfo(
                    surahNumber: ayahKeyState.current.split(":")[0].toInt(),
                    ayahNumber: ayahKeyState.current.split(":")[1].toInt(),
                    quranScriptType: state.quranScriptType,
                    textStyle: TextStyle(
                      fontSize: state.fontSize,
                      height: state.lineHeight,
                    ),
                    textAlign: TextAlign.center,
                    skipWordTap: true,
                    showWordHighlights: false,
                  ),
                  themeState: context.read<ThemeCubit>().state,
                );
              },
            ),
            const Gap(5),
            const Divider(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<QuranViewCubit, QuranViewState>(
                builder: (context, state) {
                  return Html(
                    data: capitalizeFirstLatter(translation),
                    style: {
                      "*": Style(
                        fontSize: FontSize(state.translationFontSize),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        alignment: Alignment.center,
                        textAlign: TextAlign.center,
                      ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row getSurahInfoAndController(
    AyahKeyManagement ayahKeyState,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed:
              ayahKeyState.current.split(":")[0].toInt() > 1
                  ? () {
                    int surahNumberToPlay =
                        ayahKeyState.current.split(":")[0].toInt() - 1;
                    List ayahList = getListOfAyahKey(
                      startAyahKey: "$surahNumberToPlay:1",
                      endAyahKey: getEndAyahKeyFromSurahNumber(
                        surahNumberToPlay,
                      ),
                    );
                    ayahList.removeWhere(
                      (element) => element.runtimeType != String,
                    );
                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahList.first,
                      endAyahKey: ayahList.last,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                    );
                  }
                  : null,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        const Gap(5),
        Expanded(
          child: InkWell(
            onTap: () async {
              int surahNumber = ayahKeyState.current.split(":")[0].toInt();
              int ayahNumber = ayahKeyState.current.split(":")[1].toInt();
              await popupJumpToAyah(
                context: context,
                initAyahKey: "$surahNumber:$ayahNumber",
                isAudioPlayer: true,
                onPlaySelected: (ayahKey) {
                  String startAyahKey = "${ayahKey.split(":")[0]}:1";
                  String endAyahKey = getEndAyahKeyFromSurahNumber(
                    int.parse(ayahKey.split(":")[0]),
                  );
                  int toStartIndex = ayahKey.split(":")[1].toInt() - 1;

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
            borderRadius: BorderRadius.circular(roundedRadius),
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedRadius),
                color: context.read<ThemeCubit>().state.primaryShade100,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${getSurahName(context, ayahKeyState.current.split(":").first.toInt())} - ${getAyahLocalized(context, ayahKeyState.current)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(5),
                  const Icon(Icons.arrow_drop_down_rounded, size: 26),
                ],
              ),
            ),
          ),
        ),
        const Gap(5),
        IconButton(
          onPressed:
              ayahKeyState.current.split(":")[0].toInt() < 114
                  ? () {
                    int surahNumberToPlay =
                        ayahKeyState.current.split(":")[0].toInt() + 1;
                    List ayahList = getListOfAyahKey(
                      startAyahKey: "$surahNumberToPlay:1",
                      endAyahKey: getEndAyahKeyFromSurahNumber(
                        surahNumberToPlay,
                      ),
                    );
                    ayahList.removeWhere(
                      (element) => element.runtimeType != String,
                    );
                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                      startAyahKey: ayahList.first,
                      endAyahKey: ayahList.last,
                      isInsideQuran: false,
                      reciterInfoModel:
                          context.read<AudioTabReciterCubit>().state,
                    );
                  }
                  : null,
          icon: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
