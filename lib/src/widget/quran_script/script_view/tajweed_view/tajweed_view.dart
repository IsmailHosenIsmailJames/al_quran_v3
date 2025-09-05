import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/get_word_list_of_ayah.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../theme/controller/theme_state.dart";
import "tajweed_text_preser.dart";

class TajweedView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  final ThemeState themeState;
  const TajweedView({
    super.key,
    required this.scriptInfo,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    List words = getWordListOfAyah(
      QuranScriptType.tajweed,
      scriptInfo.surahNumber.toString(),
      scriptInfo.ayahNumber.toString(),
    );
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle =
        scriptInfo.textStyle?.copyWith(
          fontFamily: "QPC_Hafs",
          letterSpacing: 0,
        ) ??
        const TextStyle(letterSpacing: 0, fontFamily: "QPC_Hafs");

    String ayahKey = "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}";

    String? highlightingWordIndex;
    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        textAlign: scriptInfo.textAlign,
        parseTajweedWord(
          wordIndex: scriptInfo.wordIndex,
          words: List<String>.from(words),
          baseStyle: quranStyle,
          context: context,
          surahNumber: scriptInfo.surahNumber,
          ayahNumber: scriptInfo.ayahNumber,
          skipWordTap: scriptInfo.skipWordTap ?? false,
        ),
      );
    }

    if (scriptInfo.forImage == true) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        textAlign: scriptInfo.textAlign,
        TextSpan(
          children: List<InlineSpan>.generate(words.length, (index) {
            return parseTajweedWord(
              wordIndex: index,
              words: List<String>.from(words),
              baseStyle: quranStyle,
              context: context,
              surahNumber: scriptInfo.surahNumber,
              ayahNumber: scriptInfo.ayahNumber,
              skipWordTap: scriptInfo.skipWordTap ?? false,
            );
          }),
        ),
      );
    }

    return BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
      builder: (context, segmentsReciterState) {
        List<List>? segments = context
            .read<SegmentedQuranReciterCubit>()
            .getAyahSegments(ayahKey);

        return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
          buildWhen: (previous, current) {
            if (scriptInfo.showWordHighlights == false ||
                context.read<AudioUiCubit>().state.isInsideQuranPlayer ==
                    false) {
              return false;
            }
            String? currentAyahKey = context.read<AyahKeyCubit>().state.current;
            if (currentAyahKey == ayahKey) {
              if (segments != null) {
                for (List word in segments) {
                  word = word.map((e) => e.toInt()).toList();
                  if (Duration(milliseconds: word[1]) <
                          (current.currentDuration ?? Duration.zero) &&
                      Duration(milliseconds: word[2]) >
                          (current.currentDuration ?? Duration.zero)) {
                    if (highlightingWordIndex != "$currentAyahKey:${word[0]}") {
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
          builder: (context, positionState) {
            return Text.rich(
              style: quranStyle,
              textDirection: TextDirection.rtl,
              textAlign: scriptInfo.textAlign,
              TextSpan(
                children: List<InlineSpan>.generate(words.length, (index) {
                  return parseTajweedWord(
                    wordIndex: index,
                    words: List<String>.from(words),
                    baseStyle: quranStyle.copyWith(
                      backgroundColor:
                          scriptInfo.showWordHighlights == false
                              ? null
                              : highlightingWordIndex ==
                                  "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${index + 1}"
                              ? themeState.primaryShade200
                              : null,
                    ),
                    context: context,
                    surahNumber: scriptInfo.surahNumber,
                    ayahNumber: scriptInfo.ayahNumber,
                    skipWordTap: scriptInfo.skipWordTap ?? false,
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
