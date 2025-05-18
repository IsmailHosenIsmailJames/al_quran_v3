import "package:al_quran_v3/src/resources/meta_data/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/components/get_surah_index_widget.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class SurahListView extends StatelessWidget {
  final List<SurahInfoModel> surahInfoList;
  const SurahListView({super.key, required this.surahInfoList});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    ScrollController scrollController = ScrollController();

    return Scrollbar(
      controller: scrollController,
      radius: Radius.circular(roundedRadius),
      thickness: 13,
      interactive: true,

      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: surahInfoList.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.05),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuranScriptView(
                          startKey: "${index + 1}:1",
                          endKey:
                              "${index + 1}:${surahInfoList[index].versesCount}",
                        ),
                  ),
                );
              },
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
                    getIndexNumberWidget(
                      context,
                      index + 1,
                      textColor: textColor,
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
                                surahInfoList[index].revelationPlace == "makkah"
                                    ? "assets/img/kaaba_10171102.png"
                                    : "assets/img/masjid-al-nabawi_16183907.png",
                              ),
                            ),
                            const Gap(3),
                            Text(
                              surahInfoList[index].nameSimple,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        Text(
                          meaningOfSurahEnglish[index],
                          style: TextStyle(
                            color:
                                brightness == Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surahInfoList[index].nameArabic,
                          style: TextStyle(fontSize: 18, color: textColor),
                        ),
                        Text(
                          "${surahInfoList[index].versesCount} Ayahs",
                          style: TextStyle(
                            color:
                                brightness == Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
