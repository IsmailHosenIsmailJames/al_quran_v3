import 'dart:developer';

import 'package:al_quran_v3/src/audio/player/audio_player_manager.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahInfoModel surahInfoModel;
  const SurahInfoHeaderBuilder({super.key, required this.surahInfoModel});

  @override
  Widget build(BuildContext context) {
    final Map translationMeta = Hive.box('quran_translation').get('meta_data');
    final Map tafsirMeta = Hive.box('quran_tafsir').get('meta_data');
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
                  Row(
                    children: [
                      const Text('Verse Count: '),
                      Text(
                        surahInfoModel.versesCount.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120 - 30,
                    child: Text(
                      'Translation: ${translationMeta['name'].toString().split('/').last.replaceAll('.simple', '').replaceAll('.json.txt', '').replaceAll('_', ' ').capitalize()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120 - 30,
                    child: Text(
                      'Tafsir: ${tafsirMeta['name'].toString().split('/').last.replaceAll('.json.txt', '').replaceAll('_', ' ').capitalize()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
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
            child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                String startAyahKey = '${surahInfoModel.id}:1';
                String endAyahKey = getEndAyahKeyFromSurahNumber(
                  surahInfoModel.id,
                );

                log(startAyahKey, name: 'Start Ayah Key');
                log(endAyahKey, name: 'End Ayah Key');

                AudioPlayerManager.playMultipleAyahAsPlaylist(
                  context: context,
                  startAyahKey: startAyahKey,
                  endAyahKey: endAyahKey,
                );
              },
              icon: const Icon(Icons.play_arrow_rounded),
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
