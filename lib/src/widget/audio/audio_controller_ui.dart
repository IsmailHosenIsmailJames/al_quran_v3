import 'package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/model/audio_controller_ui.dart';
import 'package:al_quran_v3/src/audio/model/audio_player_position_model.dart';
import 'package:al_quran_v3/src/audio/model/ayahkey_management.dart';
import 'package:al_quran_v3/src/audio/player/audio_player_manager.dart';
import 'package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio/cubit/player_state_cubit.dart';

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
    // Obtain the Cubit instance here.
    // context.read<T>() is equivalent to BlocProvider.of<T>(context, listen: false)
    // It's suitable for one-off access or when you don't need the widget to rebuild
    // when the Cubit's state changes (which is often the case for dispose logic).
    if (_myCubitInstance == null) {
      // Only fetch if not already fetched
      _myCubitInstance = context.read<AudioUiCubit>();
      print(
        "MyWidgetWithCubit: MyCubit instance obtained in didChangeDependencies.",
      );
    }
  }

  @override
  void dispose() {
    print("MyWidgetWithCubit: Disposing...");
    _myCubitInstance =
        null; // Clear the reference (optional, but good practice)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
      builder: (context, state) {
        double height =
            state.showUi
                ? state.isExpanded
                    ? 200
                    : 50
                : 0;
        double width =
            state.showUi
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
                state.showUi
                    ? Stack(
                      children: [
                        if (!state.isExpanded)
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 36,
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
              List ayahList = getListOfAyahKey(
                startAyahKey: state!.start!,
                endAyahKey: state.end!,
              );
              ayahList.removeWhere((element) => element.runtimeType == int);
              return ayahList.length > 1
                  ? Row(
                    children: [
                      Text(state.current!),
                      Expanded(
                        child: Slider(
                          value: ayahList.indexOf(state.current!).toDouble(),
                          max: ayahList.length.toDouble() - 1,
                          min: 0,
                          divisions: ayahList.length - 1,
                          onChanged: (value) {
                            String ayahKey = ayahList[value.toInt()];
                            context.read<AyahKeyCubit>().changeCurrentAyahKey(
                              ayahKey,
                            );
                            AudioPlayerManager.audioPlayer.seek(
                              Duration.zero,
                              index: value.toInt(),
                            );
                          },
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
            int currentPlayingIndex = ayahList.indexOf(state?.current!);
            if (currentPlayingIndex == -1) currentPlayingIndex = 0;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                      currentPlayingIndex > 0
                          ? () {
                            AudioPlayerManager.audioPlayer.seekToPrevious();
                          }
                          : null,
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
                  icon: const Icon(Icons.replay_5_rounded),
                ),
                BlocBuilder<PlayerStateCubit, PlayerState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        AudioPlayerManager.audioPlayer.playing
                            ? AudioPlayerManager.audioPlayer.pause()
                            : AudioPlayerManager.audioPlayer.play();
                      },
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
                  icon: const Icon(Icons.forward_5_rounded),
                ),

                IconButton(
                  onPressed:
                      int.parse(state?.current?.split(':').last ?? '0') <
                              quranAyahCount[int.parse(
                                    ayahList.first.split(':').first,
                                  ) -
                                  1]
                          ? () {
                            AudioPlayerManager.audioPlayer.seekToNext();
                          }
                          : null,
                  icon: const Icon(Icons.skip_next_rounded),
                ),

                if (ayahList.length == 1)
                  IconButton(
                    onPressed: () {
                      int surahNumber = int.parse(
                        ayahList.first.split(':').first,
                      );
                      int currentAyahNumber = int.parse(
                        ayahList.first.split(':').last,
                      );
                      String endAyahKey = getEndAyahKeyFromSurahNumber(
                        surahNumber,
                      );

                      String startAyahKey = '$surahNumber:1';

                      AudioPlayerManager.playMultipleAyahAsPlaylist(
                        context: context,
                        startAyahKey: startAyahKey,
                        endAyahKey: endAyahKey,
                        reciterInfoModel:
                            context.read<SegmentedAudioCubit>().state,
                        initialIndex: currentAyahNumber - 1,
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
