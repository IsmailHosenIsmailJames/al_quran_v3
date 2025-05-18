import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

class TajweedPageRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;

  const TajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
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
                        tajweedScript[ayahKey.split(":").first]?[ayahKey
                            .split(":")
                            .last] ??
                        [];

                    return TextSpan(
                      children:
                          List.generate(words.length, (index) {
                            String word = words[index];
                            return parseTajweedWord(
                              wordKey: "$ayahKey:${index + 1}",
                              wordHtml: "$word ",
                              baseStyle: TextStyle(
                                fontSize: baseTextStyle?.fontSize ?? 24,
                                fontFamily:
                                    baseTextStyle?.fontFamily ?? "QPC_Hafs",
                                backgroundColor:
                                    wordKey == "$ayahKey:${index + 1}"
                                        ? AppColors.primaryColor.withValues(
                                          alpha: 0.1,
                                        )
                                        : null,
                              ),
                              context: context,
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
