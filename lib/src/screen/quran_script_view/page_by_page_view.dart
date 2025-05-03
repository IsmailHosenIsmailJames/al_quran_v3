import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_pages_info.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/ayah_by_ayah_view.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PageByPageView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;

  const PageByPageView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<PageByPageView> createState() => _PageByPageViewState();
}

class _PageByPageViewState extends State<PageByPageView> {
  List<dynamic> pagesInfoWithSurahMetaData = [];
  @override
  void initState() {
    int? startAyahNumber = convertKeyToAyahNumber(widget.startKey);
    int? endAyahNumber = convertKeyToAyahNumber(widget.endKey);

    if (startAyahNumber == null || endAyahNumber == null) return;
    bool checkedFirst = false;
    List<PageInfoModel> currentPagesToShow = [];

    for (int i = 0; i < quranPagesInfo.length; i++) {
      if (quranPagesInfo[i]['s']! >= startAyahNumber ||
          quranPagesInfo[i]['e']! >= endAyahNumber) {
        if (quranPagesInfo[i]['s']! - startAyahNumber > 0 && !checkedFirst) {
          int ayahNumber =
              quranPagesInfo[i]['s']! -
              (quranPagesInfo[i]['s']! - startAyahNumber);
          currentPagesToShow.add(
            PageInfoModel(
              pageNumber: i,
              firstAyahNumber: ayahNumber,
              lastAyahNumber: quranPagesInfo[i - 1]['e']!,
            ),
          );
        } else if (endAyahNumber <= quranPagesInfo[i]['e']!) {
          int firstAyahNumber =
              quranPagesInfo[i]['s']! < startAyahNumber
                  ? startAyahNumber
                  : quranPagesInfo[i]['s']!;
          currentPagesToShow.add(
            PageInfoModel(
              pageNumber: i + 1,
              firstAyahNumber: firstAyahNumber,
              lastAyahNumber: endAyahNumber,
            ),
          );
          break;
        } else {
          currentPagesToShow.add(
            PageInfoModel(
              pageNumber: i + 1,
              firstAyahNumber: quranPagesInfo[i]['s']!,
              lastAyahNumber: quranPagesInfo[i]['e']!,
            ),
          );
        }
        checkedFirst = true;
      }
    }

    for (PageInfoModel pageInfo in currentPagesToShow) {
      List ayahsKeys = getListOfAyahKey(
        startAyahKey: convertAyahNumberToKey(pageInfo.firstAyahNumber)!,
        endAyahKey: convertAyahNumberToKey(pageInfo.lastAyahNumber)!,
      );
      int indexOfInt = ayahsKeys.indexWhere(
        (element) => element.runtimeType == int,
      );
      pagesInfoWithSurahMetaData.add(pageInfo);
      if (indexOfInt != -1) {
        while (ayahsKeys.indexWhere((element) => element.runtimeType == int) !=
            -1) {
          indexOfInt = ayahsKeys.indexWhere(
            (element) => element.runtimeType == int,
          );
          pagesInfoWithSurahMetaData.add(ayahsKeys.sublist(0, indexOfInt));
          pagesInfoWithSurahMetaData.add(ayahsKeys[indexOfInt]);
          ayahsKeys = ayahsKeys.sublist(indexOfInt + 1, ayahsKeys.length);
        }
        if (ayahsKeys.isNotEmpty) {
          pagesInfoWithSurahMetaData.add(ayahsKeys);
        }
      } else {
        pagesInfoWithSurahMetaData.add(ayahsKeys);
      }
    }

    pagesInfoWithSurahMetaData.removeWhere((element) {
      if (element.runtimeType == List<dynamic>) {
        if ((element as List).isEmpty) {
          return true;
        }
      }
      return false;
    });

    if (pagesInfoWithSurahMetaData.first.runtimeType != int &&
        pagesInfoWithSurahMetaData.first.runtimeType != PageInfoModel) {
      pagesInfoWithSurahMetaData.insert(
        0,
        int.parse(widget.startKey.split(':').first),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );
    return ListView.builder(
      itemCount: pagesInfoWithSurahMetaData.length,
      itemBuilder: (context, index) {
        var current = pagesInfoWithSurahMetaData[index];
        if (current.runtimeType == int) {
          return SurahInfoHeaderBuilder(
            surahInfoModel: SurahInfoModel.fromMap(metaDataSurah['$current']),
          );
        } else if (current.runtimeType == List<dynamic>) {
          List<String> ayahsKeyOfPage = List<String>.from(current);
          return QuranPagesRenderer(
            ayahsKey: ayahsKeyOfPage,
            quranScriptType: quranScriptType,
            baseStyle: const TextStyle(fontSize: 24),
          );
        } else {
          return Container(
            width: double.infinity,
            height: 30,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Page: '),
                Text(
                  (current as PageInfoModel).pageNumber.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class PageInfoModel {
  int pageNumber;
  int firstAyahNumber;
  int lastAyahNumber;

  PageInfoModel({
    required this.pageNumber,
    required this.firstAyahNumber,
    required this.lastAyahNumber,
  });

  Map<String, dynamic> toMap() => {
    'pageNumber': pageNumber,
    'firstAyahNumber': firstAyahNumber,
    'lastAyahNumber': lastAyahNumber,
  };
}
