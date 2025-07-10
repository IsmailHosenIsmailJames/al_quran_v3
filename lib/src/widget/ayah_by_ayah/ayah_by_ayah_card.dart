import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/functions/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/screen/tafsir_view/tafsir_view.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/add_collection_popup/add_to_pinned_popup.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/share_bottom_dialog.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "../add_collection_popup/add_note_popup.dart";

Widget getAyahByAyahCard({
  dynamic key,
  required String ayahKey,
  required BuildContext context,
  bool? showFullKey,
  bool showTopOptions = true,
  bool showOnlyAyah = false,
  bool keepMargin = true,
}) {
  AppLocalizations? l10n = AppLocalizations.of(context);

  int surahNumber = int.parse(ayahKey.toString().split(":")[0]);
  int ayahNumber = int.parse(ayahKey.toString().split(":")[1]);
  Map? translationMap = QuranTranslationFunction.getTranslation(ayahKey);
  String translation = translationMap?["t"] ?? l10n.translationNotFound;
  translation = translation.replaceAll(">", "> ");
  Map footNote = translationMap?["f"] ?? {};
  List wordByWord = [];
  bool supportsWordByWord = false;
  final metaDataOfWordByWord = WordByWordFunction.getSelectedWordByWordBook();
  if (metaDataOfWordByWord != null) {
    supportsWordByWord = true;
  }
  if (supportsWordByWord) {
    wordByWord = WordByWordFunction.getAyahWordByWordData(ayahKey) ?? [];
  }
  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah["$surahNumber"],
  );

  bool isSajdaAyah = false;
  bool isSajdaRequired = false;
  for (Map sajdaAyah in metaDataSajda) {
    if (sajdaAyah["verse_key"] == ayahKey) {
      isSajdaAyah = true;
      isSajdaRequired = sajdaAyah["required"];
      break;
    }
  }

  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return BlocBuilder<QuranViewCubit, QuranViewState>(
        builder: (context, quranViewState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            key: key,
            padding: const EdgeInsets.all(5),
            margin:
                keepMargin
                    ? const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      bottom: 5,
                      right: 10,
                    )
                    : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedRadius),
              border: Border.all(color: themeState.primaryShade200),
            ),
            child: Column(
              children: [
                if (!(showTopOptions == false) && !quranViewState.hideToolbar)
                  getToolbarWidget(
                    showFullKey,
                    surahInfoModel,
                    ayahKey,
                    ayahNumber,
                    context,
                    surahNumber,
                    translation,
                    footNote,
                    themeState,
                  ),
                if (!quranViewState.hideQuranAyah) const Gap(10),
                if (!quranViewState.hideQuranAyah)
                  quranAyahWidget(surahNumber, ayahNumber, quranViewState),
                if (!showOnlyAyah && !quranViewState.hideTranslation)
                  const Gap(5),
                if (isSajdaAyah)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    height: 35,

                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          height: 25,
                          width: 25,
                          image: const AssetImage("assets/img/sajadah.png"),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey.shade900
                                  : Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        const Gap(10),
                        Text(
                          l10n.sajdaAyah,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Gap(8),
                        const Text("-"),
                        const Gap(8),
                        Text(
                          isSajdaRequired ? l10n.required : l10n.optional,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                if (isSajdaAyah) const Gap(5),
                if (!showOnlyAyah && !quranViewState.hideTranslation)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.translationTitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),

                if (!showOnlyAyah && !quranViewState.hideTranslation)
                  const Gap(5),
                if (!showOnlyAyah && !quranViewState.hideTranslation)
                  getTranslationWidget(context, translation, quranViewState),
                if (footNote.keys.isNotEmpty &&
                    !showOnlyAyah &&
                    !quranViewState.hideFootnote)
                  const Gap(8),
                if (footNote.keys.isNotEmpty &&
                    !showOnlyAyah &&
                    !quranViewState.hideFootnote)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.footNoteTitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                if (footNote.keys.isNotEmpty &&
                    !showOnlyAyah &&
                    !quranViewState.hideFootnote)
                  const Gap(5),

                if (footNote.keys.isNotEmpty &&
                    !showOnlyAyah &&
                    !quranViewState.hideFootnote)
                  getFootNoteWidget(footNote, context, quranViewState),
                if (supportsWordByWord &&
                    !quranViewState.alwaysOpenWordByWord &&
                    !quranViewState.hideWordByWord)
                  getWordByWordExpandCloseWidget(context, ayahKey),
                if (supportsWordByWord && !quranViewState.hideWordByWord)
                  const Gap(5),
                if (supportsWordByWord && !quranViewState.hideWordByWord)
                  getWordByWordWidget(
                    context,
                    ayahKey,
                    quranViewState,
                    wordByWord,
                    surahNumber,
                    ayahNumber,
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}

Align getWordByWordWidget(
  BuildContext context,
  String ayahKey,
  QuranViewState quranViewState,
  List<dynamic> wordByWord,
  int surahNumber,
  int ayahNumber,
) {
  ThemeState themeState = context.read<ThemeCubit>().state;
  return Align(
    alignment: Alignment.centerRight,
    child: BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
      builder: (context, segmentsREciterSate) {
        String? highlightingWordIndex;
        List<List>? segments = context
            .read<SegmentedQuranReciterCubit>()
            .getAyahSegments(ayahKey);
        return BlocBuilder<
          AyahByAyahInScrollInfoCubit,
          AyahByAyahInScrollInfoState
        >(
          builder: (context, ayahScrollState) {
            return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
              buildWhen: (previous, current) {
                String? currentAyahKey =
                    context.read<AyahKeyCubit>().state.current;
                if (currentAyahKey == ayahKey) {
                  if (segments != null) {
                    for (List word in segments) {
                      word = word.map((e) => e.toInt()).toList();
                      if (Duration(milliseconds: word[1]) <
                              (current.currentDuration ?? Duration.zero) &&
                          Duration(milliseconds: word[2]) >
                              (current.currentDuration ?? Duration.zero)) {
                        if (highlightingWordIndex !=
                            "$currentAyahKey:${word[0]}") {
                          highlightingWordIndex = "$currentAyahKey:${word[0]}";
                          return true;
                        }
                        return false;
                      }
                    }
                  }
                } else {
                  if (highlightingWordIndex != null) {
                    highlightingWordIndex = null;
                    return true;
                  }
                }
                return false;
              },

              builder: (context, playPositionState) {
                return getAyahWordByWord(
                  ayahScrollState,
                  ayahKey,
                  quranViewState,
                  wordByWord,
                  surahNumber,
                  ayahNumber,
                  context,
                  themeState,
                  highlightingWordIndex,
                );
              },
            );
          },
        );
      },
    ),
  );
}

SizedBox getAyahWordByWord(
  AyahByAyahInScrollInfoState ayahScrollState,
  String ayahKey,
  QuranViewState quranViewState,
  List<dynamic> wordByWord,
  int surahNumber,
  int ayahNumber,
  BuildContext context,
  ThemeState themeState,
  String? highlightingWordIndex,
) {
  return SizedBox(
    height:
        (ayahScrollState.expandedForWordByWord?.contains(ayahKey) == true ||
                quranViewState.alwaysOpenWordByWord)
            ? null
            : 0,

    child:
        (ayahScrollState.expandedForWordByWord?.contains(ayahKey) == true ||
                quranViewState.alwaysOpenWordByWord)
            ? Wrap(
              spacing: 5,
              runSpacing: 5,
              textDirection: TextDirection.rtl,
              children: List.generate(wordByWord.length, (index) {
                String currentWordKey = "$surahNumber:$ayahNumber:${index + 1}";

                return InkWell(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  onTap: () async {
                    List<String> wordsKey = List.generate(
                      wordByWord.length,
                      (i) => "$surahNumber:$ayahNumber:${i + 1}",
                    );
                    showPopupWordFunction(
                      context: context,
                      wordKeys: wordsKey,
                      initWordIndex: index,
                      scriptCategory: QuranScriptType.uthmani,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: themeState.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(roundedRadius),
                      border:
                          highlightingWordIndex == currentWordKey
                              ? Border.all(color: themeState.primary, width: 2)
                              : null,
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<QuranViewCubit, QuranViewState>(
                          builder: (context, quranViewState) {
                            return ScriptProcessor(
                              scriptInfo: ScriptInfo(
                                surahNumber: surahNumber,
                                ayahNumber: ayahNumber,
                                quranScriptType: quranViewState.quranScriptType,
                                wordIndex: index,
                                textStyle: TextStyle(
                                  fontSize: quranViewState.fontSize,
                                  height: quranViewState.lineHeight,
                                ),
                              ),
                            );
                          },
                        ),
                        const Gap(5),
                        Text(
                          wordByWord[index],
                          style: TextStyle(
                            fontSize: quranViewState.translationFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )
            : null,
  );
}

GestureDetector getWordByWordExpandCloseWidget(
  BuildContext context,
  String ayahKey,
) {
  ThemeState themeState = context.read<ThemeCubit>().state;
  AppLocalizations l10n = AppLocalizations.of(context);
  return GestureDetector(
    onTap: () {
      List<String> expandedForWordByWord =
          context
              .read<AyahByAyahInScrollInfoCubit>()
              .state
              .expandedForWordByWord
              ?.toList() ??
          [];

      expandedForWordByWord.contains(ayahKey)
          ? expandedForWordByWord.remove(ayahKey)
          : expandedForWordByWord.add(ayahKey);
      context.read<AyahByAyahInScrollInfoCubit>().setData(
        expandedForWordByWord: expandedForWordByWord,
      );
    },
    behavior: HitTestBehavior.translucent,
    child: Container(
      decoration: BoxDecoration(
        color: themeState.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            l10n.wordByWordTranslation,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),

          BlocBuilder<AyahByAyahInScrollInfoCubit, AyahByAyahInScrollInfoState>(
            builder:
                (context, quranViewState) => Icon(
                  quranViewState.expandedForWordByWord?.contains(ayahKey) ==
                          true
                      ? Icons.arrow_drop_up
                      : Icons.arrow_right,
                  size: 24,
                  color: Colors.grey.shade500,
                ),
          ),
        ],
      ),
    ),
  );
}

Align getFootNoteWidget(
  Map<dynamic, dynamic> footNote,
  BuildContext context,
  QuranViewState quranViewState,
) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      children: List.generate(footNote.length, (index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: context.read<ThemeCubit>().state.primaryShade300,
              child: Text(
                localizedNumber(context, index + 1),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const Gap(5),
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width * 0.85,

              child: Html(
                data: capitalizeFirstLatter(footNote.values.elementAt(index)),
                style: {
                  "*": Style(
                    fontSize: FontSize(quranViewState.translationFontSize),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                },
              ),
            ),
          ],
        );
      }),
    ),
  );
}

SizedBox getTranslationWidget(
  BuildContext context,
  String translation,
  QuranViewState quranViewState,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Html(
      data: capitalizeFirstLatter(translation),
      style: {
        "*": Style(
          fontSize: FontSize(quranViewState.translationFontSize),
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
      },
    ),
  );
}

Align quranAyahWidget(
  int surahNumber,
  int ayahNumber,
  QuranViewState quranViewState,
) {
  return Align(
    alignment: Alignment.centerRight,
    child: ScriptProcessor(
      scriptInfo: ScriptInfo(
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        quranScriptType: quranViewState.quranScriptType,
        showWordHighlights: quranViewState.enableWordByWordHighlight == true,
        textStyle: TextStyle(
          fontSize: quranViewState.fontSize,
          height: quranViewState.lineHeight,
        ),
      ),
    ),
  );
}

Row getToolbarWidget(
  bool? showFullKey,
  SurahInfoModel surahInfoModel,
  String ayahKey,
  int ayahNumber,
  BuildContext context,
  int surahNumber,
  String translation,
  Map<dynamic, dynamic> footNote,
  ThemeState themeState,
) {
  AppLocalizations l10n = AppLocalizations.of(context);
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
      Container(
        decoration: BoxDecoration(
          color: themeState.primaryShade300,
          borderRadius: BorderRadius.circular(roundedRadius - 4),
        ),
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
        child: Text(
          showFullKey == true
              ? "${getSurahName(context, surahInfoModel.id)}\nAyah: ${localizedNumber(context, ayahKey.split(":").first.toInt())}:${localizedNumber(context, ayahNumber)}"
              : localizedNumber(context, ayahNumber),
        ),
      ),
      const Spacer(),
      SizedBox(
        height: 30,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TafsirView(ayahKey: ayahKey),
              ),
            );
          },
          child: Text(l10n.tafsirButton),
        ),
      ),
      const Gap(5),
      SizedBox(
        height: 30,
        width: 30,
        child: BlocBuilder<QuranViewCubit, QuranViewState>(
          builder: (context, quranViewState) {
            return IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: themeState.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: themeState.primary),
                ),
              ),
              onPressed: () {
                showShareBottomDialog(
                  context,
                  ayahKey,
                  SurahInfoModel.fromMap(metaDataSurah[surahNumber.toString()]),
                  quranViewState.quranScriptType,
                  translation,
                  footNote,
                );
              },
              tooltip: l10n.shareButton,
              icon: const Icon(FluentIcons.share_24_filled, size: 18),
            );
          },
        ),
      ),
      const Gap(5),
      SizedBox(
        height: 30,
        width: 30,
        child: IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: themeState.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: themeState.primary),
            ),
          ),
          onPressed: () async {
            showAddNotePopup(context, ayahKey);
          },
          tooltip: l10n.addNoteButton,
          icon: const Icon(FluentIcons.note_add_24_filled, size: 18),
        ),
      ),
      const Gap(5),
      SizedBox(
        height: 30,
        width: 30,
        child: IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: themeState.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: themeState.primary),
            ),
          ),
          onPressed: () {
            showAddToPinnedPopup(context, ayahKey);
          },
          tooltip: l10n.pinToCollectionButton,
          icon: const Icon(FluentIcons.pin_24_filled, size: 18),
        ),
      ),
      const Gap(5),
      SizedBox(
        height: 30,
        width: 30,
        child: BlocBuilder<PlayerStateCubit, PlayerState>(
          builder: (context, playerState) {
            return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
              builder: (context, ayahKeyManagement) {
                bool isPlaying = playerState.isPlaying;
                bool isCurrent =
                    ayahKeyManagement.current == ayahKey &&
                    context.read<AudioUiCubit>().state.isInsideQuranPlayer ==
                        true;

                return getPlayButtonWidget(
                  context,
                  ayahKey,
                  isCurrent,
                  isPlaying,
                  ayahKeyManagement,
                  playerState,
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

IconButton getPlayButtonWidget(
  BuildContext context,
  String ayahKey,
  bool isCurrent,
  bool isPlaying,
  AyahKeyManagement ayahKeyManagement,
  PlayerState playerState,
) {
  ThemeState themeState = context.read<ThemeCubit>().state;
  return IconButton(
    style: IconButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: themeState.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: themeState.primary),
      ),
    ),
    onPressed: () async {
      if (context.read<AudioUiCubit>().state.isInsideQuranPlayer == false) {
        AudioPlayerManager.playSingleAyah(
          ayahKey: ayahKey,
          reciterInfoModel: context.read<SegmentedQuranReciterCubit>().state,
          instantPlay: true,
          isInsideQuran: true,
        );
      } else if (isCurrent && isPlaying) {
        AudioPlayerManager.audioPlayer.pause();
      } else if (isCurrent) {
        AudioPlayerManager.audioPlayer.play();
      } else {
        log("Current Ayah: $ayahKey");
        bool isPlayList = context.read<AudioUiCubit>().state.isPlayList;
        if (isPlayList &&
            ayahKeyManagement.current.split(":").first ==
                ayahKey.split(":").first) {
          await AudioPlayerManager.audioPlayer.seek(
            Duration.zero,
            index: ayahKeyManagement.ayahList.indexOf(ayahKey),
          );
          AudioPlayerManager.audioPlayer.play();
        } else {
          AudioPlayerManager.playSingleAyah(
            ayahKey: ayahKey,
            reciterInfoModel: context.read<SegmentedQuranReciterCubit>().state,
            instantPlay: true,
            isInsideQuran: true,
          );
        }
      }
    },
    icon:
        (isCurrent && playerState.state == just_audio.ProcessingState.loading)
            ? const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircularProgressIndicator(strokeWidth: 3),
            )
            : Icon(
              isPlaying && isCurrent
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              size: 18,
            ),
  );
}
