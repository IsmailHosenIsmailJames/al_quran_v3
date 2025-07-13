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
    ThemeState themeState = context.read<ThemeCubit>().state;
    List words =
        (isUthmani ? uthmaniScript : indopakScript)[scriptInfo.surahNumber
            .toString()][scriptInfo.ayahNumber.toString()];
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.textStyle?.fontSize ?? 24,
      height: scriptInfo.textStyle?.height ?? 2,
      fontFamily: isUthmani ? "me_quran_volt_newmet" : "AlQuranNeov5x1",
      letterSpacing: 0,
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

    String? highlightingWordIndex;
    if (scriptInfo.forImage == true) {
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
                                : themeState.primaryShade200,
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
                            scriptCategory: QuranScriptType.uthmani,
                          );
                        }),
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
                  return TextSpan(
                    style:
                        highlightingWordIndex ==
                                "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${(index + 1)}"
                            ? TextStyle(
                              backgroundColor:
                                  scriptInfo.showWordHighlights == false
                                      ? null
                                      : themeState.primaryShade200,
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
                                  scriptCategory: QuranScriptType.uthmani,
                                );
                              }),
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
