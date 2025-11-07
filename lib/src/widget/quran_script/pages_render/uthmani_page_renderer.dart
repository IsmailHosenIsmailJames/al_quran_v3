import "dart:developer";

import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_script_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/utils/quran_word/show_popup_word_function.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../theme/controller/theme_cubit.dart";
import "../../../theme/controller/theme_state.dart";

class NonTajweedPageRenderer extends StatelessWidget {
  final bool isUthmani;
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;
  final bool? enableWordByWordHighlight;
  final String? highlightAyah;

  const NonTajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
    required this.isUthmani,
    this.enableWordByWordHighlight,
    this.highlightAyah,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;

    String? wordKey = "";

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
        builder: (context, segmentsReciterState) {
          Map<String, List> audioSegmentsMap = {};

          for (final ayahKey in ayahsKey) {
            List<List>? segments = context
                .read<SegmentedQuranReciterCubit>()
                .getAyahSegments(ayahKey);

            if (segments != null) {
              audioSegmentsMap[ayahKey] = segments;
            }
          }
          return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
            buildWhen: (previous, current) {
              if (enableWordByWordHighlight != true) return false;

              if (context.read<AudioUiCubit>().state.isInsideQuranPlayer ==
                  false) {
                return false;
              }
              String? currentAyahKey =
                  context.read<AyahKeyCubit>().state.current;
              log(currentAyahKey.toString(), name: "currentAyahKey");
              if (ayahsKey.contains(currentAyahKey)) {
                List? segments = audioSegmentsMap[currentAyahKey];
                if (segments != null) {
                  for (List word in segments) {
                    word = word.map((e) => e.toInt()).toList();
                    if (Duration(milliseconds: word[1]) <
                            (current.currentDuration ?? Duration.zero) &&
                        Duration(milliseconds: word[2]) >
                            (current.currentDuration ?? Duration.zero)) {
                      if (wordKey != "$currentAyahKey:${word[0]}") {
                        wordKey = "$currentAyahKey:${word[0]}";
                        return true;
                      }
                      return false;
                    }
                  }
                }
              } else {
                if (wordKey != null) {
                  wordKey = null;
                  return true;
                }
              }
              return false;
            },
            builder: (context, positionState) {
              return Text.rich(
                TextSpan(
                  children:
                      ayahsKey.map((ayahKey) {
                        List words = QuranScriptFunction.getWordListOfAyah(
                          isUthmani
                              ? QuranScriptType.uthmani
                              : QuranScriptType.indopak,
                          ayahKey.split(":").first,
                          ayahKey.split(":").last,
                        );

                        return TextSpan(
                          children:
                              List.generate(words.length, (index) {
                                String word = words[index];
                                bool isLastWord = index == (words.length - 1);

                                return TextSpan(
                                  text: "$word ",
                                  style:
                                      (wordKey == "$ayahKey:${index + 1}" &&
                                                  enableWordByWordHighlight ==
                                                      true) ||
                                              segmentsReciterState
                                                      .showAyahHilight ==
                                                  ayahKey
                                          ? TextStyle(
                                            backgroundColor:
                                                themeState.primaryShade200,
                                            fontFamily:
                                                isLastWord ? "QPC_Hafs" : null,
                                          )
                                          : TextStyle(
                                            fontFamily:
                                                isLastWord ? "QPC_Hafs" : null,
                                          ),

                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () async {
                                          final wordKey = List.generate(
                                            words.length,
                                            (index) => "$ayahKey:${index + 1}",
                                          );
                                          showPopupWordFunction(
                                            context: context,
                                            initWordIndex: index,
                                            wordKeys: wordKey,
                                            wordByWordList:
                                                await WordByWordFunction.getAyahWordByWordData(
                                                  "${wordKey.first.split(":")[0]}:${wordKey.first.split(":")[1]}",
                                                ) ??
                                                [],
                                          );
                                        },
                                );
                              }).toList(),
                        );
                      }).toList(),
                ),
                style: TextStyle(
                  fontSize: baseTextStyle?.fontSize ?? 24,
                  fontFamily:
                      baseTextStyle?.fontFamily ??
                      (isUthmani ? "QPC_Hafs" : "AlQuranNeov5x1"),
                  fontWeight: baseTextStyle?.fontWeight,
                  height: baseTextStyle?.height,
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              );
            },
          );
        },
      ),
    );
  }
}
