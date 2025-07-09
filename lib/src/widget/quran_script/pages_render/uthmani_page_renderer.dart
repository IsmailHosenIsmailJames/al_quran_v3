import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart";
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

  const NonTajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
    required this.isUthmani,
    this.enableWordByWordHighlight,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;

    Map<String, List> audioSegmentsMap = {};

    for (final ayahKey in ayahsKey) {
      List<List>? segments = context
          .read<SegmentedQuranReciterCubit>()
          .getAyahSegments(ayahKey);
      if (segments != null) {
        audioSegmentsMap[ayahKey] = segments;
      }
    }

    String? wordKey = "";

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
        builder: (context, segmentsReciterState) {
          return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
            buildWhen: (previous, current) {
              if (enableWordByWordHighlight != true) return false;

              if (context.read<AudioUiCubit>().state.isInsideQuranPlayer ==
                  false) {
                return false;
              }
              String? currentAyahKey =
                  context.read<AyahKeyCubit>().state.current;
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
              log(wordKey.toString(), name: "wordKey");
              return Text.rich(
                TextSpan(
                  children:
                      ayahsKey.map((ayahKey) {
                        List words =
                            (isUthmani ? uthmaniScript : indopakScript)[ayahKey
                                .split(":")
                                .first]?[ayahKey.split(":").last] ??
                            [];

                        return TextSpan(
                          children:
                              List.generate(words.length, (index) {
                                String word = words[index];
                                return TextSpan(
                                  text: "$word ",
                                  style:
                                      (wordKey == "$ayahKey:${index + 1}" &&
                                              enableWordByWordHighlight == true)
                                          ? TextStyle(
                                            backgroundColor:
                                                themeState.primaryShade200,
                                          )
                                          : null,

                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          showPopupWordFunction(
                                            context: context,
                                            initWordIndex: index,
                                            wordKeys: List.generate(
                                              words.length,
                                              (index) =>
                                                  "$ayahKey:${index + 1}",
                                            ),
                                            scriptCategory:
                                                QuranScriptType.uthmani,
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
                      (isUthmani ? "me_quran_volt_newmet" : "IndopakNastaleeq"),
                  fontWeight: baseTextStyle?.fontWeight,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              );
            },
          );
        },
      ),
    );
  }
}
