import "dart:developer";

import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_controller_ui.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart";
import "package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:just_audio/just_audio.dart" as just_audio;

import "../../audio/cubit/player_state_cubit.dart";

class AudioControllerUi extends StatefulWidget {
  const AudioControllerUi({super.key});

  @override
  State<AudioControllerUi> createState() => _AudioControllerUiState();
}

class _AudioControllerUiState extends State<AudioControllerUi> {
  AudioUiCubit? _myCubitInstance; // Cache the Cubit instance

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _myCubitInstance ??= context.read<AudioUiCubit>();
  }

  @override
  void dispose() {
    _myCubitInstance = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
      builder: (context, state) {
        log(state.isInsideQuranPlayer.toString());
        double height =
            (state.showUi && state.isInsideQuranPlayer)
                ? state.isExpanded
                    ? 120
                    : 50
                : 0;
        double width =
            (state.showUi && state.isInsideQuranPlayer)
                ? state.isExpanded
                    ? MediaQuery.of(context).size.width
                    : 50
                : 0;

        return GestureDetector(
          onTap: () {
            if (!state.isExpanded) {
              context.read<AudioUiCubit>().expand(true);
            }
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(5),
            duration: const Duration(milliseconds: 300),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius:
                  state.isExpanded
                      ? BorderRadius.circular(roundedRadius)
                      : BorderRadius.circular(1000),
              color:
                  state.isExpanded
                      ? Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade900
                          : Colors.grey.shade100
                      : AppColors.primaryColor,
              border: Border.all(color: AppColors.primaryColor, width: 0.5),
            ),
            child:
                (state.showUi && state.isInsideQuranPlayer)
                    ? Stack(
                      children: [
                        if (!state.isExpanded)
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: BlocBuilder<PlayerStateCubit, PlayerState>(
                              builder:
                                  (context, state) => Icon(
                                    state.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                            ),
                          ),
                        if (state.isExpanded)
                          Stack(
                            children: [
                              getFullAudioControllerUI(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      iconSize: 15,
                                    ),
                                    onPressed: () {
                                      if (state.isExpanded) {
                                        context.read<AudioUiCubit>().expand(
                                          false,
                                        );
                                      }
                                    },
                                    tooltip: "Close Audio Controller",
                                    icon: const Icon(
                                      Icons.close_fullscreen_rounded,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                    : null,
          ),
        );
      },
    );
  }

  Widget getFullAudioControllerUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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

        BlocBuilder<AyahKeyCubit, AyahKeyManagement?>(
          builder: (context, state) {
            if (state?.current != null &&
                state?.end != null &&
                state?.start != null) {
              int currentSurahNumber = int.parse(state!.current!.split(":")[0]);
              List ayahList = getListOfAyahKey(
                startAyahKey: "$currentSurahNumber:1",
                endAyahKey: getEndAyahKeyFromSurahNumber(currentSurahNumber),
              );
              ayahList.removeWhere((element) => element.runtimeType == int);
              return ayahList.length > 1
                  ? Row(
                    children: [
                      Text(state.current!),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            padding: const EdgeInsets.only(
                              top: 3,
                              bottom: 5,
                              left: 10,
                              right: 10,
                            ),
                          ),

                          child: Slider(
                            value: ayahList.indexOf(state.current!).toDouble(),
                            max: ayahList.length.toDouble() - 1,
                            min: 0,

                            divisions: ayahList.length - 1,
                            onChanged: (value) {
                              String ayahKey = ayahList[value.toInt()];
                              if ((state.ayahList?.length ?? 0) == 1) {
                                AudioPlayerManager.playSingleAyah(
                                  ayahKey: ayahKey,
                                  reciterInfoModel:
                                      context.read<SegmentedAudioCubit>().state,
                                  isInsideQuran: true,
                                );
                              }
                              AudioPlayerManager.audioPlayer.seek(
                                Duration.zero,
                                index: value.toInt(),
                              );
                            },
                          ),
                        ),
                      ),
                      Text(state.end!),
                    ],
                  )
                  : const SizedBox();
            }
            {
              return const SizedBox();
            }
          },
        ),

        BlocBuilder<AyahKeyCubit, AyahKeyManagement?>(
          builder: (context, state) {
            List ayahList = state?.ayahList ?? [];
            ayahList.removeWhere((element) => element.runtimeType == int);
            int currentPlayingIndex = ayahList.indexOf(state?.current);
            if (currentPlayingIndex == -1) currentPlayingIndex = 0;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
                    onPressed: () {
                      AudioPlayerManager.stopListeningAudioPlayerState();
                    },
                    tooltip: "Stop & Close",
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                IconButton(
                  onPressed:
                      int.parse(state?.current?.split(":").last ?? "0") > 1
                          ? () {
                            if (state?.ayahList?.length == 1) {
                              int? currentSurahNumber = int.tryParse(
                                state?.current?.split(":").first ?? "",
                              );
                              if (currentSurahNumber == null) return;
                              List tempAyahList = getListOfAyahKey(
                                startAyahKey: "$currentSurahNumber:1",
                                endAyahKey: getEndAyahKeyFromSurahNumber(
                                  currentSurahNumber,
                                ),
                              );
                              tempAyahList.removeWhere(
                                (element) => element.runtimeType == int,
                              );
                              int index = tempAyahList.indexOf(
                                state?.current ?? "",
                              );
                              if (index != -1) {
                                AudioPlayerManager.playSingleAyah(
                                  ayahKey: tempAyahList[index - 1],
                                  reciterInfoModel:
                                      context.read<SegmentedAudioCubit>().state,
                                  isInsideQuran: true,
                                );
                              }
                            } else {
                              AudioPlayerManager.audioPlayer.seekToPrevious();
                            }
                          }
                          : null,
                  tooltip: "Previous",
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                IconButton(
                  onPressed: () {
                    Duration duration = AudioPlayerManager.audioPlayer.position;
                    int inMilSec = duration.inMilliseconds - 5000;
                    if (inMilSec < 0) inMilSec = 0;
                    AudioPlayerManager.audioPlayer.seek(
                      Duration(milliseconds: inMilSec),
                    );
                  },
                  tooltip: "Rewind",
                  icon: const Icon(Icons.replay_5_rounded),
                ),
                BlocBuilder<PlayerStateCubit, PlayerState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () async {
                        AudioPlayerManager.audioPlayer.playing
                            ? AudioPlayerManager.audioPlayer.pause()
                            : AudioPlayerManager.audioPlayer.play();
                      },
                      tooltip: state.isPlaying ? "Pause" : "Play",
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    );
                  },
                ),

                IconButton(
                  onPressed: () {
                    Duration? position =
                        AudioPlayerManager.audioPlayer.position;

                    Duration? maxDuration =
                        AudioPlayerManager.audioPlayer.duration;

                    AudioPlayerManager.audioPlayer.duration;
                    int inMilSec = position.inMilliseconds + 5000;
                    if ((maxDuration?.inMilliseconds ?? double.infinity) <
                        inMilSec) {
                      inMilSec = maxDuration?.inMilliseconds ?? 0;
                    }
                    AudioPlayerManager.audioPlayer.seek(
                      Duration(milliseconds: inMilSec),
                    );
                  },
                  tooltip: "Fast Forward",

                  icon: const Icon(Icons.forward_5_rounded),
                ),

                IconButton(
                  onPressed:
                      (ayahList.isNotEmpty &&
                              int.parse(
                                    state?.current?.split(":").last ?? "0",
                                  ) <
                                  quranAyahCount[int.parse(
                                        ayahList.first.split(":").first,
                                      ) -
                                      1])
                          ? () {
                            if (state?.ayahList?.length == 1) {
                              int? currentSurahNumber = int.tryParse(
                                state?.current?.split(":").first ?? "",
                              );
                              if (currentSurahNumber == null) return;
                              List tempAyahList = getListOfAyahKey(
                                startAyahKey: "$currentSurahNumber:1",
                                endAyahKey: getEndAyahKeyFromSurahNumber(
                                  currentSurahNumber,
                                ),
                              );
                              tempAyahList.removeWhere(
                                (element) => element.runtimeType == int,
                              );
                              int index = tempAyahList.indexOf(
                                state?.current ?? "",
                              );
                              if (index != -1) {
                                AudioPlayerManager.playSingleAyah(
                                  ayahKey: tempAyahList[index + 1],
                                  reciterInfoModel:
                                      context.read<SegmentedAudioCubit>().state,
                                  isInsideQuran: true,
                                );
                              }
                            } else {
                              AudioPlayerManager.audioPlayer.seekToNext();
                            }
                          }
                          : null,
                  tooltip: "Play Next Ayah",
                  icon: const Icon(Icons.skip_next_rounded),
                ),

                if (ayahList.length != 1)
                  IconButton(
                    onPressed: () {
                      if (AudioPlayerManager.audioPlayer.loopMode ==
                          just_audio.LoopMode.one) {
                        AudioPlayerManager.audioPlayer.setLoopMode(
                          just_audio.LoopMode.all,
                        );
                      } else if (AudioPlayerManager.audioPlayer.loopMode ==
                          just_audio.LoopMode.all) {
                        AudioPlayerManager.audioPlayer.setLoopMode(
                          just_audio.LoopMode.off,
                        );
                      } else {
                        AudioPlayerManager.audioPlayer.setLoopMode(
                          just_audio.LoopMode.one,
                        );
                      }
                    },
                    tooltip: "Repeat",
                    icon: switch (AudioPlayerManager.audioPlayer.loopMode) {
                      just_audio.LoopMode.one => const Icon(
                        Icons.repeat_one_rounded,
                      ),
                      just_audio.LoopMode.all => const Icon(
                        Icons.repeat_rounded,
                      ),
                      just_audio.LoopMode.off => Icon(
                        Icons.repeat_rounded,
                        color: Colors.grey.withValues(alpha: 0.6),
                      ),
                    },
                  ),

                if (ayahList.length == 1)
                  IconButton(
                    onPressed: () {
                      int surahNumber = int.parse(
                        ayahList.first.split(":").first,
                      );
                      int currentAyahNumber = int.parse(
                        ayahList.first.split(":").last,
                      );
                      String endAyahKey = getEndAyahKeyFromSurahNumber(
                        surahNumber,
                      );

                      String startAyahKey = "$surahNumber:1";

                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        startAyahKey: startAyahKey,
                        endAyahKey: endAyahKey,
                        reciterInfoModel:
                            context.read<SegmentedAudioCubit>().state,
                        initialIndex: currentAyahNumber - 1,
                        instantPlay: AudioPlayerManager.audioPlayer.playing,
                        isInsideQuran: true,
                      );
                    },
                    tooltip: "Play As Playlist",
                    icon: const Icon(Icons.playlist_play_rounded),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
