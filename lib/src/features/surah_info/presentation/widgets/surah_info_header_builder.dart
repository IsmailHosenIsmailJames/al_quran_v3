import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_download_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/surah_header_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/screens/surah_info_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahHeaderInfoModel headerInfoModel;

  const SurahInfoHeaderBuilder({super.key, required this.headerInfoModel});

  static Future<void> openSurahInfo(
    BuildContext context,
    SurahInfoModel surahInfoModel,
  ) async {
    final l10n = AppLocalizations.of(context);
    final locale = context.read<LanguageCubit>().state.locale;

    String? surahInfo = await QuranTranslationFunction.getInfoOfSurah(
      surahInfoModel.id.toString(),
      locale.languageCode,
    );

    if (surahInfo == null && context.mounted) {
      // Try downloading English surah info on demand
      final success = await QuranTranslationFunction.downloadSurahInfo(
        const Locale("en"),
      );
      if (success) {
        surahInfo = await QuranTranslationFunction.getInfoOfSurah(
          surahInfoModel.id.toString(),
        );
      }
    }

    if (!context.mounted) return;

    if (surahInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noResultsFound)),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SurahInfoView(
              html: surahInfo!,
              surahInfoModel: surahInfoModel,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    AppLocalizations l10n = AppLocalizations.of(context);

    Widget surahInfoHeader = Container(
      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: themeState.primary.withValues(alpha: 0.05),
      ),
      constraints: const BoxConstraints(minHeight: 84),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      headerInfoModel.surahInfoModel.revelationPlace ==
                              "madinah"
                          ? "assets/img/madina.jpeg"
                          : "assets/img/makkah.jpg",
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${headerInfoModel.surahInfoModel.id}. ${getSurahName(context, headerInfoModel.surahInfoModel.id)}  - ",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  "surah${headerInfoModel.surahInfoModel.id.toString().padLeft(3, '0')}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "surah-name-v1",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(4),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(l10n.verseCount),
                              Text(
                                headerInfoModel.surahInfoModel.versesCount.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (QuranTranslationFunction.isInfoAvailable())
                            InkWell(
                              onTap:
                                  () => openSurahInfo(
                                    context,
                                    headerInfoModel.surahInfoModel,
                                  ),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: themeState.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: themeState.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      FluentIcons.info_16_regular,
                                      size: 13,
                                      color: themeState.primary,
                                    ),
                                    const Gap(4),
                                    Text(
                                      l10n.moreInfo,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: themeState.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!kIsWeb)
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
                                  builder: (context) => AudioDownloadScreen(
                                    initDownloadSurah:
                                        headerInfoModel.surahInfoModel,
                                    reciterInfoModel: context
                                        .read<SegmentedQuranReciterCubit>()
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
                            bool isPlayList = context
                                .read<AudioUiCubit>()
                                .state
                                .isPlayList;
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
                                reciterInfoModel: context
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
                                reciterInfoModel: context
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
                              ? Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4,
                                    backgroundColor: context
                                        .read<ThemeCubit>()
                                        .state
                                        .primaryShade100,
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
                  tajweedColorEnable:
                      state.quranScriptType == QuranScriptType.uthmani
                      ? state.useTajweedOnUthmani
                      : state.useTajweedOnIndopak,
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
