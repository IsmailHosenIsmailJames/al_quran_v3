import 'package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/model/audio_controller_ui.dart';
import 'package:al_quran_v3/src/audio/model/audio_player_position_model.dart';
import 'package:al_quran_v3/src/audio/model/ayahkey_management.dart';
import 'package:al_quran_v3/src/audio/player/audio_player_manager.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioControllerUi extends StatefulWidget {
  const AudioControllerUi({super.key});

  @override
  State<AudioControllerUi> createState() => _AudioControllerUiState();
}

class _AudioControllerUiState extends State<AudioControllerUi> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
      builder: (context, state) {
        double height =
            state.showUi
                ? state.isExpanded
                    ? 100
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
            child: Stack(
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
                                context.read<AudioUiCubit>().expand(false);
                              }
                            },
                            icon: const Icon(Icons.close_fullscreen_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
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
              onSeek: (duration) {
                AudioPlayerManager.audioPlayer.seek(duration);
              },
            );
          },
        ),

        BlocBuilder<AyahKeyCubit, AyahKeyManagement?>(
          builder: (context, state) {
            return Text(state?.current ?? 'No Ayah Found');
          },
        ),
      ],
    );
  }
}
