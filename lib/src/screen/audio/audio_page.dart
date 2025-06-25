import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart";
import "package:al_quran_v3/src/screen/audio/change_reciter/popup_change_reciter.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";
import "package:just_audio/just_audio.dart" hide PlayerState;
import "package:url_launcher/url_launcher.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          builder: (context, ayahKeyState) {
            int currentIndex =
                int.parse(ayahKeyState.current.split(":")[1]) - 1;
            Map translationMap =
                Hive.box("quran_translation").get(ayahKeyState.current) ??
                {"t": "Translation Not Found"};
            String translation = translationMap["t"] ?? "Translation Not Found";
            translation = translation.replaceAll(">", "> ");
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AudioTabReciterCubit, ReciterInfoModel>(
                    builder:
                        (context, audioTabScreenState) => Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 80,
                              child:
                                  audioTabScreenState.img != null
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          roundedRadius,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: audioTabScreenState.img!,
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(
                                                    FluentIcons
                                                        .person_24_regular,
                                                    size: 60,
                                                    color: Colors.grey,
                                                  ),
                                          progressIndicatorBuilder:
                                              (
                                                context,
                                                url,
                                                progress,
                                              ) => Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      value: progress.progress,
                                                    ),
                                              ),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                      : const Icon(
                                        FluentIcons.person_24_regular,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                            ),
                            const Gap(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    popupChangeReciter(
                                      context,
                                      audioTabScreenState,
                                      (
                                        ReciterInfoModel reciterInfoModel,
                                      ) async {
                                        context
                                            .read<AudioTabReciterCubit>()
                                            .changeReciter(reciterInfoModel);
                                        AudioPlayerManager.playMultipleAyahAsPlaylist(
                                          startAyahKey:
                                              ayahKeyState.ayahList.first,
                                          endAyahKey:
                                              ayahKeyState.ayahList.last,
                                          isInsideQuran: false,
                                          reciterInfoModel: reciterInfoModel,
                                          initialIndex: currentIndex,
                                          instantPlay:
                                              AudioPlayerManager
                                                  .audioPlayer
                                                  .playing,
                                        );
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      BlocBuilder<
                                        QuranReciterCubit,
                                        ReciterInfoModel
                                      >(
                                        builder:
                                            (context, state) => Text(
                                              safeSubString(
                                                context
                                                    .read<QuranReciterCubit>()
                                                    .state
                                                    .name,
                                                20,
                                                replacer: "...",
                                              ),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                      ),
                                      const Gap(5),
                                      const Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Text("Style: ${audioTabScreenState.style}"),
                                Text("Source: ${audioTabScreenState.source}"),
                                if (audioTabScreenState.bio != null)
                                  Row(
                                    children: [
                                      const Text("More: "),
                                      SizedBox(
                                        height: 20,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                          onPressed: () {
                                            launchUrl(
                                              Uri.parse(
                                                audioTabScreenState.bio!,
                                              ),
                                              mode:
                                                  LaunchMode
                                                      .externalApplication,
                                            );
                                          },
                                          child: Text(
                                            Uri.parse(
                                              audioTabScreenState.bio!,
                                            ).host,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed:
                            ayahKeyState.current.split(":")[0].toInt() > 1
                                ? () {
                                  int surahNumberToPlay =
                                      ayahKeyState.current
                                          .split(":")[0]
                                          .toInt() -
                                      1;
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
                                        context
                                            .read<AudioTabReciterCubit>()
                                            .state,
                                  );
                                }
                                : null,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      const Gap(5),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            int surahNumber =
                                ayahKeyState.current.split(":")[0].toInt();
                            int ayahNumber =
                                ayahKeyState.current.split(":")[1].toInt();
                            await popupJumpToAyah(
                              context: context,
                              initAyahKey: "$surahNumber:$ayahNumber",
                              isAudioPlayer: true,
                              onPlaySelected: (ayahKey) {
                                String startAyahKey =
                                    "${ayahKey.split(":")[0]}:1";
                                String endAyahKey =
                                    getEndAyahKeyFromSurahNumber(
                                      int.parse(ayahKey.split(":")[0]),
                                    );
                                int toStartIndex =
                                    ayahKey.split(":")[1].toInt() - 1;

                                AudioPlayerManager.playMultipleAyahAsPlaylist(
                                  startAyahKey: startAyahKey,
                                  endAyahKey: endAyahKey,
                                  isInsideQuran: false,
                                  instantPlay: true,
                                  initialIndex: toStartIndex,
                                  reciterInfoModel:
                                      context.read<QuranReciterCubit>().state,
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(roundedRadius),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                roundedRadius,
                              ),
                              color:
                                  context
                                      .read<ThemeCubit>()
                                      .state
                                      .primaryShade100,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${SurahInfoModel.fromMap(metaDataSurah[ayahKeyState.current.split(":")[0]]).nameSimple} - ${ayahKeyState.current}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Gap(5),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 26,
                                ),
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
                                      ayahKeyState.current
                                          .split(":")[0]
                                          .toInt() +
                                      1;
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
                                        context
                                            .read<AudioTabReciterCubit>()
                                            .state,
                                  );
                                }
                                : null,
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),

                  const Gap(10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(roundedRadius),
                        color: context.read<ThemeCubit>().state.primaryShade100,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(5),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<QuranViewCubit, QuranViewState>(
                              builder: (context, state) {
                                return ScriptProcessor(
                                  scriptInfo: ScriptInfo(
                                    surahNumber:
                                        ayahKeyState.current
                                            .split(":")[0]
                                            .toInt(),
                                    ayahNumber:
                                        ayahKeyState.current
                                            .split(":")[1]
                                            .toInt(),
                                    quranScriptType: state.quranScriptType,
                                    textStyle: TextStyle(
                                      fontSize: state.fontSize,
                                      height: state.lineHeight,
                                    ),
                                    textAlign: TextAlign.center,
                                    skipWordTap: true,
                                    showWordHighlights: false,
                                  ),
                                );
                              },
                            ),
                            const Gap(5),
                            const Divider(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child:
                                  BlocBuilder<QuranViewCubit, QuranViewState>(
                                    builder: (context, state) {
                                      return Html(
                                        data: capitalizeFirstLatter(
                                          translation,
                                        ),
                                        style: {
                                          "*": Style(
                                            fontSize: FontSize(
                                              state.translationFontSize,
                                            ),
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
                    ),
                  ),
                  const Gap(20),
                  BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
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
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded),
                        onPressed:
                            currentIndex > 0
                                ? () {
                                  if (AudioPlayerManager
                                          .audioPlayer
                                          .audioSource ==
                                      null) {
                                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                                      startAyahKey: ayahKeyState.ayahList.first,
                                      endAyahKey: ayahKeyState.ayahList.last,
                                      isInsideQuran: false,
                                      reciterInfoModel:
                                          context
                                              .read<AudioTabReciterCubit>()
                                              .state,
                                      instantPlay: true,
                                      initialIndex: currentIndex - 1,
                                    );
                                  } else {
                                    AudioPlayerManager.audioPlayer
                                        .seekToPrevious();
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
                                  Duration position =
                                      AudioPlayerManager.audioPlayer.position;
                                  position =
                                      position - const Duration(seconds: 5);
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
                                if (AudioPlayerManager
                                        .audioPlayer
                                        .audioSource ==
                                    null) {
                                  AudioPlayerManager.playMultipleAyahAsPlaylist(
                                    startAyahKey: ayahKeyState.ayahList.first,
                                    endAyahKey: ayahKeyState.ayahList.last,
                                    isInsideQuran: false,
                                    initialIndex: currentIndex,
                                    instantPlay: true,
                                    reciterInfoModel:
                                        context
                                            .read<AudioTabReciterCubit>()
                                            .state,
                                  );

                                  return;
                                }
                                AudioPlayerManager.audioPlayer.playing
                                    ? AudioPlayerManager.audioPlayer.pause()
                                    : AudioPlayerManager.audioPlayer.play();
                              },
                              tooltip: state.isPlaying ? "Pause" : "Play",
                              iconSize: 45,
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(5),
                              ),
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
                                  Duration position =
                                      AudioPlayerManager.audioPlayer.position;
                                  position =
                                      position + const Duration(seconds: 5);
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
                                  if (AudioPlayerManager
                                          .audioPlayer
                                          .audioSource ==
                                      null) {
                                    AudioPlayerManager.playMultipleAyahAsPlaylist(
                                      startAyahKey: ayahKeyState.ayahList.first,
                                      endAyahKey: ayahKeyState.ayahList.last,
                                      isInsideQuran: false,
                                      reciterInfoModel:
                                          context
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
                    ],
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
}
