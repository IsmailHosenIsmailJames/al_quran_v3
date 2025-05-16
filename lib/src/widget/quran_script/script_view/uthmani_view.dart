import 'dart:developer';

import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/model/audio_player_position_model.dart';
import 'package:al_quran_v3/src/audio/model/ayahkey_management.dart';
import 'package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class UthmaniView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const UthmaniView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        uthmaniScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
            .toString()];
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.fontSize ?? 24,
      fontFamily: 'QPC_Hafs',
    );
    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        TextSpan(
          children: [TextSpan(text: words[scriptInfo.wordIndex!] + ' ')],
        ),
      );
    }

    String ayahKey = '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}';

    Map? audioTimeStamp = Hive.box(
      'segmented_quran_recitation',
    ).get(ayahKey, defaultValue: null);
    List<List>? segments;
    if (audioTimeStamp != null) {
      segments = List<List>.from(audioTimeStamp['segments']);
    }

    int highlightingWordIndex = -1;

    return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
      buildWhen: (previous, current) {
        String? currentAyahKey = context.read<AyahKeyCubit>().state.current;
        if (currentAyahKey == ayahKey) {
          if (segments != null) {
            for (List word in segments) {
              word = word.map((e) => e.toInt()).toList();
              if (Duration(milliseconds: word[1]) <
                      (current.currentDuration ?? Duration.zero) &&
                  Duration(milliseconds: word[2]) >
                      (current.currentDuration ?? Duration.zero)) {
                if (highlightingWordIndex != word[0]) {
                  highlightingWordIndex = word[0];
                  return true;
                }
                return false;
              }
            }
          }
        }
        return false;
      },
      builder: (context, positionState) {
        return Text.rich(
          style: quranStyle,
          textDirection: TextDirection.rtl,
          TextSpan(
            children: List<InlineSpan>.generate(words.length, (index) {
              return TextSpan(
                style:
                    highlightingWordIndex == (index + 1)
                        ? TextStyle(
                          backgroundColor: Colors.green.withValues(alpha: 0.15),
                        )
                        : null,
                text: words[index] + ' ',
                recognizer:
                    scriptInfo.skipWordTap == true
                        ? null
                        : (TapGestureRecognizer()
                          ..onTap = () {
                            showPopupWordFunction(
                              context: context,
                              wordKey:
                                  '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${index + 1}',
                              word: words[index],
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
