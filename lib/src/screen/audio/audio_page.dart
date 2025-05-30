import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Surah: ",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(
            height: 35,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                popupJumpToAyah(context, "2:5");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${SurahInfoModel.fromMap(metaDataSurah["2"]).nameSimple} - 2:5",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(10),
                  const Icon(Icons.arrow_drop_down_rounded, size: 30),
                ],
              ),
            ),
          ),
          const Gap(15),
          const Text(
            "Reciter: ",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(
            height: 35,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    safeSubString(
                      ReciterInfoModel.fromMap(recitationsInfoList[0]).name,
                      25,
                      replacer: "...",
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(10),
                  const Icon(Icons.arrow_drop_down_rounded, size: 30),
                ],
              ),
            ),
          ),

          const Gap(20),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor.withValues(alpha: 0.1),
              ),
              child: ScriptProcessor(
                scriptInfo: ScriptInfo(
                  surahNumber: 2,
                  ayahNumber: 5,
                  quranScriptType: QuranScriptType.tajweed,
                  fontSize: 26,
                  skipWordTap: true,
                ),
              ),
            ),
          ),
          Gap(10),
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
                onPressed: () {},
              ),
              const Gap(5),

              IconButton(
                icon: const Icon(Icons.replay_10_rounded),
                onPressed: () {},
              ),
              const Gap(8),
              SizedBox(
                width: 80,
                height: 80,
                child: IconButton(
                  iconSize: 60,
                  icon: const Icon(Icons.play_arrow_rounded),
                  onPressed: () {},
                ),
              ),
              const Gap(8),

              IconButton(
                icon: const Icon(Icons.forward_10_rounded),
                onPressed: () {},
              ),
              const Gap(5),

              IconButton(
                icon: const Icon(Icons.skip_next_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
