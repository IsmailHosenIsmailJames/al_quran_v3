import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

class NonTajweedPageRenderer extends StatelessWidget {
  final bool isUthmani;
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;

  const NonTajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
    required this.isUthmani,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, List> audioSegmentsMap = {};

    for (final ayahsKey in ayahsKey) {
      Map? audioTimeStamp = Hive.box(
        "segmented_quran_recitation",
      ).get(ayahsKey, defaultValue: null);
      List<List>? segments;
      if (audioTimeStamp != null) {
        segments = List<List>.from(audioTimeStamp["segments"]);
      }
      if (segments != null) {
        audioSegmentsMap[ayahsKey] = segments;
      }
    }

    String? wordKey = "";

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
        buildWhen: (previous, current) {
          String? currentAyahKey = context.read<AyahKeyCubit>().state.current;
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
                                  wordKey == "$ayahKey:${index + 1}"
                                      ? TextStyle(
                                        backgroundColor: AppColors.primary
                                            .withValues(alpha: 0.15),
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
                                          (index) => "$ayahKey:${index + 1}",
                                        ),
                                        words: List<String>.from(words),
                                        scriptCategory: QuranScriptType.uthmani,
                                      );
                                    },
                            );
                          }).toList(),
                    );
                  }).toList(),
            ),
            style: TextStyle(
              fontSize: baseTextStyle?.fontSize ?? 24,
              fontFamily: baseTextStyle?.fontFamily ?? "QPC_Hafs",
              fontWeight: baseTextStyle?.fontWeight,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          );
        },
      ),
    );
  }
}
