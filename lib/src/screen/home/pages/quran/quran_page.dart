import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/resources/meta_data/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/surah_list_view/hizb_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/juz_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/hizb_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/juz_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/ruku_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/page_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/ruku_list_view.dart";
import "package:al_quran_v3/src/screen/surah_list_view/surah_list_view.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List<String> pagesName = ["Surah", "Juz", "Pages", "Hizb", "Ruku"];
  int _pageIndex = 0;
  List<SurahInfoModel> surahInfoList =
      metaDataSurah.values
          .map((value) => SurahInfoModel.fromMap(value))
          .toList();
  List<JuzInfoModel> juzInfoModelList =
      metaDataJuz.values.map((e) => JuzInfoModel.fromMap(e)).toList();
  List<PageInfoModel> pageInfoList =
      quranPagesInfo.map((e) => PageInfoModel.fromMap(e)).toList();
  List<HizbModel> hizbInfoList =
      metaDataHizb.values.map((e) => HizbModel.fromMap(e)).toList();
  List<RukuInfoModel> rukuInfoList =
      metaDataRuku.values.map((e) => RukuInfoModel.fromMap(e)).toList();
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    log(pageController.position.minScrollExtent.toString());
    log(pageController.position.maxScrollExtent.toString());
    log(pageController.position.pixels.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 35,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.primaryShade100,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment(
                    [-1, -0.5, 0, 0.5, 1][_pageIndex].toDouble(),
                    0,
                  ),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryShade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 30,
                    width: (MediaQuery.of(context).size.width - 10) / 5,
                  ),
                ),
                Row(
                  children: List.generate(pagesName.length, (index) {
                    return Expanded(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          pagesName[index],
                          style: TextStyle(
                            fontWeight:
                                _pageIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              controller: pageController,
              children: [
                SurahListView(surahInfoList: surahInfoList),
                JuzListView(juzInfoList: juzInfoModelList),
                PageListView(pageInfoList: pageInfoList),
                HizbListView(hizbInfoList: hizbInfoList),
                RukuListView(rukuInfoList: rukuInfoList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
