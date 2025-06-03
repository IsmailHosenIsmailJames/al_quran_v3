import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/surah_info/surah_info_view.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:just_audio/just_audio.dart" as just_audio;

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahHeaderInfoModel headerInfoModel;
  const SurahInfoHeaderBuilder({super.key, required this.headerInfoModel});

  @override
  Widget build(BuildContext context) {
    final Map translationMeta = Hive.box("quran_translation").get("meta_data");
    String tafsirMeta = Hive.box("user").get("tafsir_book");
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: AppColors.primary.withValues(alpha: 0.05),
      ),
      height: 120,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  image: DecorationImage(
                    image: AssetImage(
                      headerInfoModel.surahInfoModel.revelationPlace ==
                              "madinah"
                          ? "assets/img/madina.jpeg"
                          : "assets/img/makkah.jpg",
                    ),
                  ),
                ),
              ),
              const Gap(7),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${headerInfoModel.surahInfoModel.id}. ${headerInfoModel.surahInfoModel.nameSimple} ( ${headerInfoModel.surahInfoModel.nameArabic} )",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text("Verse Count: "),
                      Text(
                        headerInfoModel.surahInfoModel.versesCount.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120 - 30,
                    child: Text(
                      safeSubString(
                        'Translation: ${translationMeta['name'].toString().split('/').last.replaceAll('.simple', '').replaceAll('.json.txt', '').replaceAll('_', ' ').capitalize()}',
                        30,
                        replacer: "...",
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120 - 30,
                    child: Text(
                      safeSubString(
                        'Tafsir: ${tafsirMeta.toString().split('/').last.replaceAll('.json.txt', '').replaceAll('_', ' ').capitalize()}',
                        30,
                        replacer: "...",
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  if (Hive.box("surah_info").keys.isNotEmpty)
                    SizedBox(
                      height: 25,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(),
                        ),
                        onPressed: () async {
                          final String surahInfo =
                              await Hive.box("surah_info").get(
                                headerInfoModel.surahInfoModel.id.toString(),
                              )["text"];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SurahInfoView(
                                    html: surahInfo,
                                    surahInfoModel:
                                        headerInfoModel.surahInfoModel,
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          "more info",
                          style: TextStyle(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: BlocBuilder<PlayerStateCubit, PlayerState>(
              builder: (context, playerState) {
                return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
                  builder: (context, ayahKeyManagement) {
                    bool isPlaying = playerState.isPlaying;
                    bool isCurrentSurah =
                        int.tryParse(ayahKeyManagement.current.split(":")[0]) ==
                        headerInfoModel.surahInfoModel.id;
                    bool isCurrentPlaying =
                        isPlaying &&
                        isCurrentSurah &&
                        context
                                .read<AudioUiCubit>()
                                .state
                                .isInsideQuranPlayer ==
                            true;
                    return IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        bool isPlayList =
                            context.read<AudioUiCubit>().state.isPlayList;
                        bool isCompleted =
                            playerState.state ==
                            just_audio.ProcessingState.completed;

                        if (context
                                .read<AudioUiCubit>()
                                .state
                                .isInsideQuranPlayer ==
                            false) {
                          String startAyahKey = headerInfoModel.startAyahKey;
                          String endAyahKey = headerInfoModel.endAyahKey;

                          AudioPlayerManager.playMultipleAyahAsPlaylist(
                            startAyahKey: startAyahKey,
                            endAyahKey: endAyahKey,
                            reciterInfoModel:
                                context.read<SegmentedAudioCubit>().state,
                            isInsideQuran: true,
                          );
                        } else if (isCurrentPlaying &&
                            isPlayList &&
                            !isCompleted) {
                          AudioPlayerManager.audioPlayer.pause();
                        } else if (isCurrentSurah &&
                            isPlayList &&
                            !isCompleted) {
                          AudioPlayerManager.audioPlayer.play();
                        } else {
                          String startAyahKey = headerInfoModel.startAyahKey;
                          String endAyahKey = headerInfoModel.endAyahKey;

                          AudioPlayerManager.playMultipleAyahAsPlaylist(
                            startAyahKey: startAyahKey,
                            endAyahKey: endAyahKey,
                            reciterInfoModel:
                                context.read<SegmentedAudioCubit>().state,
                            isInsideQuran: true,
                          );
                        }
                      },
                      icon:
                          (playerState.state ==
                                      just_audio.ProcessingState.loading &&
                                  isCurrentSurah)
                              ? const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4,
                                ),
                              )
                              : Icon(
                                isCurrentPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                              ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String getEndAyahKeyFromSurahNumber(int surah) {
  return "$surah:${quranAyahCount[surah - 1]}";
}
