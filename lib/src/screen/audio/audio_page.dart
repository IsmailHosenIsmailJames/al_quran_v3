import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/screen/audio/change_reciter/popup_change_reciter.dart";
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
import "package:gap/gap.dart";
import "package:url_launcher/url_launcher.dart";

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  int selectedReciter = 0;
  String currentAyahKEy = "2:5";

  @override
  Widget build(BuildContext context) {
    ReciterInfoModel reciterInfoModel = ReciterInfoModel.fromMap(
      recitationsInfoList[selectedReciter],
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 90,
                child:
                    reciterInfoModel.img != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: reciterInfoModel.img!,
                            errorWidget:
                                (context, url, error) => const Icon(
                                  FluentIcons.person_24_regular,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(
                                      value: progress.progress,
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
                      popupChangeReciter(context, selectedReciter, (index) {
                        log(index.toString());
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<QuranReciterCubit, ReciterInfoModel>(
                          builder:
                              (context, state) => Text(
                                safeSubString(
                                  context.read<QuranReciterCubit>().state.name,
                                  25,
                                  replacer: "...",
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                        ),
                        const Gap(10),
                        const Icon(Icons.arrow_drop_down_rounded, size: 30),
                      ],
                    ),
                  ),
                  Text("Style: ${reciterInfoModel.style}"),
                  Text("Source: ${reciterInfoModel.source}"),
                  if (reciterInfoModel.bio != null)
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
                                Uri.parse(reciterInfoModel.bio!),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Text(Uri.parse(reciterInfoModel.bio!).host),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          const Gap(10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
            ),
            child: InkWell(
              onTap: () async {
                int surahNumber = currentAyahKEy.split(":")[0].toInt();
                int ayahNumber = currentAyahKEy.split(":")[1].toInt();
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
                      reciterInfoModel: context.read<QuranReciterCubit>().state,
                    );
                  },
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${SurahInfoModel.fromMap(metaDataSurah["2"]).nameSimple} - $currentAyahKEy",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(15),
                  const Icon(Icons.arrow_drop_down_rounded, size: 40),
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
                  surahNumber: currentAyahKEy.split(":")[0].toInt(),
                  ayahNumber: currentAyahKEy.split(":")[1].toInt(),
                  quranScriptType: QuranScriptType.tajweed,
                  fontSize: 26,
                  textAlign: TextAlign.center,
                  skipWordTap: true,
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
