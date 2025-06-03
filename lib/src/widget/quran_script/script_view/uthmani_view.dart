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
import "package:hive_flutter/adapters.dart";

class NonTajweedScriptView extends StatelessWidget {
  final bool isUthmani;
  final ScriptInfo scriptInfo;
  const NonTajweedScriptView({
    super.key,
    required this.scriptInfo,
    required this.isUthmani,
  });

  @override
  Widget build(BuildContext context) {
    List words =
        (isUthmani ? uthmaniScript : indopakScript)[scriptInfo.surahNumber
            .toString()][scriptInfo.ayahNumber.toString()];
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.fontSize ?? 24,
      fontFamily: "QPC_Hafs",
    );
    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        textAlign: scriptInfo.textAlign,
        TextSpan(
          children: [TextSpan(text: words[scriptInfo.wordIndex!] + " ")],
        ),
      );
    }

    String ayahKey = "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}";

    Map? audioTimeStamp = Hive.box(
      "segmented_quran_recitation",
    ).get(ayahKey, defaultValue: null);
    List<List>? segments;
    if (audioTimeStamp != null) {
      segments = List<List>.from(audioTimeStamp["segments"]);
    }

    String? highlightingWordIndex;

    return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
      buildWhen: (previous, current) {
        if (scriptInfo.showWordHighlights == false) return false;
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
              return TextSpan(
                style:
                    highlightingWordIndex ==
                            "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${(index + 1)}"
                        ? TextStyle(
                          backgroundColor:
                              scriptInfo.showWordHighlights == false
                                  ? null
                                  : AppColors.primaryShade200,
                        )
                        : null,
                text: words[index] + " ",
                recognizer:
                    scriptInfo.skipWordTap == true
                        ? null
                        : (TapGestureRecognizer()
                          ..onTap = () {
                            List<String> wordsKey = List.generate(
                              words.length,
                              (i) =>
                                  "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${i + 1}",
                            );
                            showPopupWordFunction(
                              context: context,
                              wordKeys: wordsKey,
                              initWordIndex: index,
                              words: List<String>.from(words),
                              scriptCategory: QuranScriptType.uthmani,
                            );
                          }),
              );
            }),
          ),
        );
      },
    );
  }
}
