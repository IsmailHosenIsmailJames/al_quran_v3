import "dart:developer";

import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart";
import "package:al_quran_v3/src/screen/tafsir_view/tafsir_view.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";

Widget getAyahByAyahCard({
  required String ayahKey,
  required QuranScriptType quranScriptType,
  required BuildContext context,
}) {
  int surahNumber = int.parse(ayahKey.toString().split(":")[0]);
  int ayahNumber = int.parse(ayahKey.toString().split(":")[1]);
  Map translationMap =
      Hive.box("quran_translation").get(ayahKey) ??
      {"t": "Translation Not Found"};
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
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(roundedRadius),
      color: AppColors.primaryColor.withValues(alpha: 0.05),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                bottom: 3,
                top: 3,
              ),
              child: Text(ayahNumber.toString()),
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
              child: IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onPressed: () {},
                tooltip: "Share",
                icon: const Icon(FluentIcons.share_24_filled, size: 18),
              ),
            ),
            const Gap(5),
            SizedBox(
              height: 30,
              width: 30,
              child: IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onPressed: () {},
                tooltip: "Copy",
                icon: const Icon(FluentIcons.copy_16_filled, size: 18),
              ),
            ),
            const Gap(5),
            SizedBox(
              height: 30,
              width: 30,
              child: IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onPressed: () {},
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
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                onPressed: () {
                  log(
                    Hive.box(
                      "segmented_quran_recitation",
                    ).get("1:1").toString(),
                  );
                },
                tooltip: "Bookmark",
                icon: const Icon(Icons.bookmark_added, size: 18),
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
                      bool isCurrent = ayahKeyManagement.current == ayahKey;

                      return IconButton(
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(color: AppColors.primaryColor),
                          ),
                        ),
                        onPressed: () async {
                          if (isCurrent && isPlaying) {
                            AudioPlayerManager.audioPlayer.pause();
                          } else if (isCurrent) {
                            AudioPlayerManager.audioPlayer.play();
                          } else {
                            log("Current Ayah: $ayahKey");
                            bool isPlayList =
                                context.read<AudioUiCubit>().state.isPlayList;
                            if (isPlayList &&
                                ayahKeyManagement.current?.split(":").first ==
                                    ayahKey.split(":").first) {
                              await AudioPlayerManager.audioPlayer.seek(
                                Duration.zero,
                                index: ayahKeyManagement.ayahList?.indexOf(
                                  ayahKey,
                                ),
                              );
                              AudioPlayerManager.audioPlayer.play();
                            } else {
                              AudioPlayerManager.playSingleAyah(
                                ayahKey: ayahKey,
                                reciterInfoModel:
                                    context.read<SegmentedAudioCubit>().state,
                                instantPlay: true,
                              );
                            }
                          }
                        },
                        icon: Icon(
                          isPlaying && isCurrent
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 18,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const Gap(10),
        Align(
          alignment: Alignment.centerRight,
          child: ScriptProcessor(
            scriptInfo: ScriptInfo(
              surahNumber: surahNumber,
              ayahNumber: ayahNumber,
              quranScriptType: quranScriptType,
            ),
          ),
        ),
        const Gap(5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Translation:",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        const Gap(2),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Html(data: capitalizeFirstLatter(translation)),
        ),
        if (footNote.keys.isNotEmpty) const Gap(8),
        if (footNote.keys.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Foot Note:",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ),
        const Gap(2),
        if (footNote.keys.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: List.generate(footNote.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${index + 1}. "),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width * 0.85,

                      child: Html(
                        data: capitalizeFirstLatter(
                          footNote.values.elementAt(index),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        if (supportsWordByWord)
          GestureDetector(
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
                color: AppColors.primaryColor.withValues(alpha: 0.05),
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

                  BlocBuilder<
                    AyahByAyahInScrollInfoCubit,
                    AyahByAyahInScrollInfoState
                  >(
                    builder:
                        (context, state) => Icon(
                          state.expandedForWordByWord?.contains(ayahKey) == true
                              ? Icons.arrow_drop_up
                              : Icons.arrow_right,
                          size: 24,
                          color: Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        if (supportsWordByWord) const Gap(5),
        if (supportsWordByWord)
          BlocBuilder<AyahByAyahInScrollInfoCubit, AyahByAyahInScrollInfoState>(
            builder:
                (context, state) => SizedBox(
                  height:
                      state.expandedForWordByWord?.contains(ayahKey) == true
                          ? null
                          : 0,

                  child:
                      state.expandedForWordByWord?.contains(ayahKey) == true
                          ? Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            textDirection: TextDirection.rtl,
                            children: List.generate(wordByWord.length, (index) {
                              return Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.05,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    roundedRadius,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ScriptProcessor(
                                      scriptInfo: ScriptInfo(
                                        surahNumber: surahNumber,
                                        ayahNumber: ayahNumber,
                                        quranScriptType: quranScriptType,
                                        wordIndex: index,
                                      ),
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
      ],
    ),
  );
}
