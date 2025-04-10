import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SurahInfoHeaderBuilder extends StatelessWidget {
  final SurahInfoModel surahInfoModel;
  const SurahInfoHeaderBuilder({super.key, required this.surahInfoModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: AppColors.primaryColor.withValues(alpha: 0.1),
      ),
      height: 100,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
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
                  Text('Revelation Order: ${surahInfoModel.revelationOrder}'),
                  Text('Verse Count: ${surahInfoModel.versesCount}'),
                  const Gap(5),
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
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
