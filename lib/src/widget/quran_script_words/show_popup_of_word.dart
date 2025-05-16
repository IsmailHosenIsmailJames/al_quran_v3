import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/script_processor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
            ),
          ),
          const Gap(15),
          // SizedBox(
          //   height: 70,
          //   width: 70,
          //   child: IconButton(
          //     style: IconButton.styleFrom(
          //       backgroundColor: AppColors.primaryColor.withValues(alpha: 0.05),
          //       foregroundColor: AppColors.primaryColor,
          //     ),
          //     onPressed: () {
          //       int surahNumber = int.parse(wordKey.split(':')[0]);
          //       int ayahNumber = int.parse(wordKey.split(':')[1]);
          //       int wordIndex = int.parse(wordKey.split(':')[2]) - 1;
          //       ReciterInfoModel reciterInfoModel =
          //           context.read<SegmentedAudioCubit>().state;

          //       List? data =
          //           Hive.box(
          //             'segmented_quran_recitation',
          //           ).get('$surahNumber:$ayahNumber')?['segments'];

          //       if (data != null) {
          //         List wordTimeData = data[wordIndex];
          //         log(wordTimeData.toString());
          //         AudioPlayerManager.playWord(
          //           context: context,
          //           ayahKey: '$surahNumber:$ayahNumber',
          //           reciter: reciterInfoModel,
          //           start: Duration(milliseconds: wordTimeData[1]),
          //           end: Duration(milliseconds: wordTimeData[2]),
          //           surahInfoModel: surahInfoModel,
          //         );
          //       }
          //     },
          //     icon: const Icon(Icons.play_arrow),
          //   ),
          // ),
        ],
      ),
    );
  }
}
