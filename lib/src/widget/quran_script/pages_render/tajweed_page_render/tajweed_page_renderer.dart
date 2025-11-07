import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/audio_player_position_model.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_script_function.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../theme/controller/theme_cubit.dart";
import "../../../../theme/controller/theme_state.dart";

class TajweedPageRenderer extends StatelessWidget {
  final List<String> ayahsKey;
  final TextStyle? baseTextStyle;
  final String? highlightAyah;
  final bool? enableWordByWordHighlight;

  const TajweedPageRenderer({
    super.key,
    required this.ayahsKey,
    this.baseTextStyle,
    this.enableWordByWordHighlight,
    this.highlightAyah,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;

    String? wordKey = "";

    bool isDark = Theme.of(context).brightness == Brightness.dark;

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
                          QuranScriptType.tajweed,
                          ayahKey.split(":").first,
                          ayahKey.split(":").last,
                        );

                        return TextSpan(
                          style: TextStyle(
                            backgroundColor:
                                highlightAyah == ayahKey
                                    ? isDark
                                        ? Colors.white.withValues(alpha: 0.05)
                                        : Colors.black.withValues(alpha: 0.05)
                                    : null,
                          ),
                          children:
                              List.generate(words.length, (index) {
                                return parseTajweedWord(
                                  wordIndex: index,
                                  baseStyle: TextStyle(
                                    fontSize: baseTextStyle?.fontSize ?? 24,
                                    fontFamily:
                                        baseTextStyle?.fontFamily ?? "QPC_Hafs",
                                    height: baseTextStyle?.height,
                                    backgroundColor:
                                        (wordKey == "$ayahKey:${index + 1}" &&
                                                    enableWordByWordHighlight ==
                                                        true) ||
                                                segmentsReciterState
                                                        .showAyahHilight ==
                                                    ayahKey
                                            ? themeState.primaryShade200
                                            : null,
                                  ),
                                  surahNumber: ayahKey.split(":").first.toInt(),
                                  ayahNumber: ayahKey.split(":").last.toInt(),
                                  skipWordTap: false,
                                  words: List<String>.from(words),
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
