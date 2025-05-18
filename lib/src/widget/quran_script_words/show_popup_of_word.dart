import 'dart:developer';

import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/audio/player/audio_player_manager.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/segmented_audio_cubit.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class ShowPopupOfWord extends StatelessWidget {
  final String wordKey;
  final String word;
  final QuranScriptType scriptCategory;
  final SurahInfoModel surahInfoModel;
  const ShowPopupOfWord({
    super.key,
    required this.wordKey,
    required this.word,
    required this.scriptCategory,
    required this.surahInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(15),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            '${surahInfoModel.nameSimple} (${surahInfoModel.nameArabic}) - $wordKey',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ScriptProcessor(
            scriptInfo: ScriptInfo(
              surahNumber: int.parse(wordKey.split(':')[0]),
              ayahNumber: int.parse(wordKey.split(':')[1]),
              wordIndex: int.parse(wordKey.split(':')[2]) - 1,
              quranScriptType: scriptCategory,
              fontSize: 40,
            ),
          ),
          const Gap(15),
          SizedBox(
            height: 70,
            width: 70,
            child: BlocBuilder<WordPlayingStateCubit, String?>(
              builder: (context, state) {
                log(state.toString());
                return IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.05,
                    ),
                    foregroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    context.read<WordPlayingStateCubit>().changeState(wordKey);
                    AudioPlayerManager.playWord(wordKey);
                  },
                  icon: Icon(
                    state == wordKey ? Icons.pause_rounded : Icons.play_arrow,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
