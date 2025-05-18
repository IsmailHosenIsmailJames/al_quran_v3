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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              children: List.generate(pagesName.length, (index) {
                return Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor:
                          _pageIndex == index
                              ? AppColors.primaryColor
                              : Colors.transparent,
                      foregroundColor:
                          _pageIndex == index
                              ? Colors.white
                              : AppColors.primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    child: Text(
                      pagesName[index],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child:
                [
                  SurahListView(surahInfoList: surahInfoList),
                  JuzListView(juzInfoList: juzInfoModelList),
                  PageListView(pageInfoList: pageInfoList),
                  HizbListView(hizbInfoList: hizbInfoList),
                  RukuListView(rukuInfoList: rukuInfoList),
                ][_pageIndex],
          ),
        ],
      ),
    );
  }
}
