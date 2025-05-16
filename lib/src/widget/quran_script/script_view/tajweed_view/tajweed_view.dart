import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/model/audio_player_position_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'tajweed_text_preser.dart';

class TajweedView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const TajweedView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        tajweedScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
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

    String ayahKey = '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}';

    Map? audioTimeStamp = Hive.box(
      'segmented_quran_recitation',
    ).get(ayahKey, defaultValue: null);
    List<List>? segments;
    if (audioTimeStamp != null) {
      segments = List<List>.from(audioTimeStamp['segments']);
    }

    int highlightingWordIndex = -1;

    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        parseTajweedWord(
          wordKey:
              '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${scriptInfo.wordIndex}',
          wordHtml: words[scriptInfo.wordIndex!] + ' ',
          baseStyle: quranStyle,
          context: context,
          skipWordTap: scriptInfo.skipWordTap,
        ),
      );
    }

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
        } else {
          if (highlightingWordIndex != -1) {
            highlightingWordIndex = -1;
            return true;
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
              return parseTajweedWord(
                wordKey:
                    '${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}:${index + 1}',
                wordHtml: words[index] + ' ',
                baseStyle: quranStyle.copyWith(
                  backgroundColor:
                      (index + 1) == highlightingWordIndex
                          ? AppColors.primaryColor.withValues(alpha: 0.2)
                          : null,
                ),
                context: context,
                skipWordTap: scriptInfo.skipWordTap,
              );
            }),
          ),
        );
      },
    );
  }
}
