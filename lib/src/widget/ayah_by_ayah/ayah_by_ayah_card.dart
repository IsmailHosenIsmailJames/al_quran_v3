import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
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
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";
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
  int surahNumber = int.parse(ayahKey.toString().split(":")[0]);
  int ayahNumber = int.parse(ayahKey.toString().split(":")[1]);
  Map translationMap = QuranTranslationFunction.getTranslation(ayahKey);
  String translation = translationMap["t"] ?? "Translation Not Found";
  translation = translation.replaceAll(">", "> ");
  Map footNote = translationMap["f"] ?? {};
  List wordByWord = [];
  bool supportsWordByWord = false;
  final metaDataOfWordByWord = Hive.box(
    "quran_word_by_word",
  ).get("meta_data", defaultValue: {});
  if (metaDataOfWordByWord != null && metaDataOfWordByWord.isNotEmpty) {
    supportsWordByWord = true;
  }
  if (supportsWordByWord) {
    wordByWord = Hive.box("quran_word_by_word").get(ayahKey) ?? [];
  }
  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah["$surahNumber"],
  );
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
                if (!showOnlyAyah && !quranViewState.hideTranslation)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Translation:",
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
                      "Foot Note:",
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
    child: BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      builder:
          (context, state) => SizedBox(
            height:
                (state.expandedForWordByWord?.contains(ayahKey) == true ||
                        quranViewState.alwaysOpenWordByWord)
                    ? null
                    : 0,

            child:
                (state.expandedForWordByWord?.contains(ayahKey) == true ||
                        quranViewState.alwaysOpenWordByWord)
                    ? Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      textDirection: TextDirection.rtl,
                      children: List.generate(wordByWord.length, (index) {
                        return Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(roundedRadius),
                          ),
                          child: Column(
                            children: [
                              BlocBuilder<QuranViewCubit, QuranViewState>(
                                builder: (context, quranViewState) {
                                  return ScriptProcessor(
                                    scriptInfo: ScriptInfo(
                                      surahNumber: surahNumber,
                                      ayahNumber: ayahNumber,
                                      quranScriptType:
                                          quranViewState.quranScriptType,
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
                              Text(wordByWord[index]),
                            ],
                          ),
                        );
                      }),
                    )
                    : null,
          ),
    ),
  );
}

GestureDetector getWordByWordExpandCloseWidget(
  BuildContext context,
  String ayahKey,
) {
  ThemeState themeState = context.read<ThemeCubit>().state;
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
            "Word by Word Translation:",
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
              child: Text("${index + 1}", style: const TextStyle(fontSize: 12)),
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
              ? "${surahInfoModel.nameSimple}\nAyah: $ayahKey"
              : ayahNumber.toString(),
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
          child: const Text("Tafsir"),
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
              tooltip: "Share",
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
          tooltip: "Add Note",
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
          tooltip: "Pin to Collection",
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
