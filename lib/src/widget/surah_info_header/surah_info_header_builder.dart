import 'package:al_quran_v3/src/audio/cubit/audio_state_cubit.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/resources/quran_script/ayahs_len.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahInfoModel surahInfoModel;
  const SurahInfoHeaderBuilder({super.key, required this.surahInfoModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: AppColors.primaryColor.withValues(alpha: 0.05),
      ),
      height: 120,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  image: DecorationImage(
                    image: AssetImage(
                      surahInfoModel.revelationPlace == 'madinah'
                          ? 'assets/img/madina.jpeg'
                          : 'assets/img/makkah.jpg',
                    ),
                  ),
                ),
              ),
              const Gap(7),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${surahInfoModel.id}. ${surahInfoModel.nameSimple} ( ${surahInfoModel.nameArabic} )',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Verse Count: ${surahInfoModel.versesCount}'),
                  const Text('Translation: '),
                  const Text('Tafsir: '),
                  SizedBox(
                    height: 25,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {},
                      child: Text(
                        'more info',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<AudioStateCubit>().playMultipleAyahAsPlaylist(
                    startAyahKey: '${surahInfoModel.id}:1',
                    endAyahKey: getEndAyahKeyFromSurahNumber(surahInfoModel.id),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getEndAyahKeyFromSurahNumber(int surah) {
  return '$surah:${quranAyahCount[surah - 1]}';
}
