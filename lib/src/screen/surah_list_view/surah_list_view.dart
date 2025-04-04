import 'package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'dart:math';

class SurahListView extends StatelessWidget {
  final List<SurahInfoModel> surahInfoList;
  const SurahListView({super.key, required this.surahInfoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahInfoList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.08),
            ),
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 3,
                bottom: 3,
              ),
              height: 55,
              child: Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Stack(
                      children: [
                        Transform.rotate(
                          angle: 45 * pi / 180,

                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,

                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(
                                roundedRadius - 3,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            surahInfoList[index].id.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              surahInfoList[index].revelationPlace == 'makkah'
                                  ? 'assets/img/kaaba_10171102.png'
                                  : 'assets/img/masjid-al-nabawi_16183907.png',
                            ),
                          ),
                          const Gap(3),
                          Text(
                            surahInfoList[index].nameSimple,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Text(meaningOfSurahEnglish[index]),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surahInfoList[index].nameArabic,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        surahInfoList[index].versesCount.toString() + ' Ayahs',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
