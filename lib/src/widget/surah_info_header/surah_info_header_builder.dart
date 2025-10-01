import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/audio_download_screen.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_info/surah_info_view.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahHeaderInfoModel headerInfoModel;

  const SurahInfoHeaderBuilder({super.key, required this.headerInfoModel});

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations l10n = AppLocalizations.of(context);

    TafsirBookModel? tafsirSelected = QuranTafsirFunction.getTafsirSelection();
    Widget surahInfoHeader = Container(
      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: themeState.primary.withValues(alpha: 0.05),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${headerInfoModel.surahInfoModel.id}. ${getSurahName(context, headerInfoModel.surahInfoModel.id)} ( ${getSurahNameArabic(headerInfoModel.surahInfoModel.id)} )",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(l10n.verseCount),
                        Text(
                          headerInfoModel.surahInfoModel.versesCount.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    FutureBuilder(
                      future: QuranTranslationFunction.getMetaInfo(),
                      builder:
                          (context, snapshot) => Text(
                            "${l10n.translation}: ${snapshot.data?.name.toString() ?? ""}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                    ),
                    Text(
                      "${l10n.tafsir}: ${tafsirSelected?.name ?? l10n.tafsirNotFound}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (QuranTranslationFunction.isInfoAvailable())
                      SizedBox(
                        height: 25,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(),
                          ),
                          onPressed: () async {
                            final String surahInfo =
                                await QuranTranslationFunction.getInfoOfSurah(
                                  headerInfoModel.surahInfoModel.id.toString(),
                                );
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
                            l10n.moreInfo,
                            style: TextStyle(
                              color: themeState.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: themeState.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AudioDownloadScreen(
                                      initDownloadSurah:
                                          headerInfoModel.surahInfoModel,
                                      reciterInfoModel:
                                          context
                                              .read<
                                                SegmentedQuranReciterCubit
                                              >()
                                              .state,
                                    ),
                              ),
                            );
                          },
                          icon: const Icon(
                            FluentIcons.arrow_download_24_filled,
                          ),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: themeState.primary,
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
                              String startAyahKey =
                                  headerInfoModel.startAyahKey;
                              String endAyahKey = headerInfoModel.endAyahKey;

                              AudioPlayerManager.playMultipleAyahAsPlaylist(
                                startAyahKey: startAyahKey,
                                endAyahKey: endAyahKey,
                                reciterInfoModel:
                                    context
                                        .read<SegmentedQuranReciterCubit>()
                                        .state,
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
                              String startAyahKey =
                                  headerInfoModel.startAyahKey;
                              String endAyahKey = headerInfoModel.endAyahKey;

                              AudioPlayerManager.playMultipleAyahAsPlaylist(
                                startAyahKey: startAyahKey,
                                endAyahKey: endAyahKey,
                                reciterInfoModel:
                                    context
                                        .read<SegmentedQuranReciterCubit>()
                                        .state,
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
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );

    if (!headerInfoModel.surahInfoModel.noBismillah) {
      return Column(
        children: [
          surahInfoHeader,

          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: BlocBuilder<QuranViewCubit, QuranViewState>(
              builder: (context, state) {
                return ScriptProcessor(
                  scriptInfo: ScriptInfo(
                    surahNumber: 1,
                    ayahNumber: 1,
                    quranScriptType: state.quranScriptType,
                    textStyle: TextStyle(
                      fontSize: state.fontSize,
                      height: state.lineHeight,
                    ),
                    limitWord: 4,
                    textAlign: TextAlign.center,
                    skipWordTap: false,
                    showWordHighlights: false,
                  ),
                  themeState: context.read<ThemeCubit>().state,
                );
              },
            ),
          ),
          const Gap(10),
        ],
      );
    } else {
      return surahInfoHeader;
    }
  }
}

String getEndAyahKeyFromSurahNumber(int surah) {
  return "$surah:${quranAyahCount[surah - 1]}";
}
