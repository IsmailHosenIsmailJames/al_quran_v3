import 'dart:developer';

import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_pages_info.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/model/page_info_model.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart';
import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/widget/audio/audio_controller_ui.dart';
import 'package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart';
import 'package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuranScriptView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;

  const QuranScriptView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<QuranScriptView> createState() => _PageByPageViewState();
}

class _PageByPageViewState extends State<QuranScriptView> {
  List<dynamic> pagesInfoWithSurahMetaData = [];
  @override
  void initState() {
    int? startAyahNumber = convertKeyToAyahNumber(widget.startKey);
    int? endAyahNumber = convertKeyToAyahNumber(widget.endKey);

    if (startAyahNumber == null || endAyahNumber == null) return;
    bool checkedFirst = false;
    List<PageInfoModel> currentPagesToShow = [];
    List allAyahsKey = [];

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

    for (final element in pagesInfoWithSurahMetaData) {
      if (element.runtimeType == List<dynamic>) {
        allAyahsKey.addAll(element);
      }
    }

    if (pagesInfoWithSurahMetaData.first.runtimeType != int &&
        pagesInfoWithSurahMetaData.first.runtimeType != PageInfoModel) {
      pagesInfoWithSurahMetaData.insert(
        0,
        int.parse(widget.startKey.split(':').first),
      );
    }
    int listLen = pagesInfoWithSurahMetaData.length;
    for (int i = 0; i < listLen; i++) {
      if (pagesInfoWithSurahMetaData[i].runtimeType == int) {
        String endAyahKey = getEndAyahKeyFromSurahNumber(
          pagesInfoWithSurahMetaData[i],
        );
        List allAyahsInThisSurah = getListOfAyahKey(
          startAyahKey: '${pagesInfoWithSurahMetaData[i]}:1',
          endAyahKey: endAyahKey,
        );
        String? start;
        String? end;
        for (final key in allAyahsInThisSurah) {
          if (allAyahsKey.contains(key)) {
            start ??= key;
            end = key;
          }
        }
        start ??= allAyahsInThisSurah.first;
        end ??= allAyahsInThisSurah.last;
        try {
          pagesInfoWithSurahMetaData[i] = SurahHeaderInfoModel(
            SurahInfoModel.fromMap(
              metaDataSurah['${pagesInfoWithSurahMetaData[i]}'],
            ),
            start!,
            end!,
          );
        } catch (e) {
          log(e.toString());
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranScriptType quranScriptType = QuranScriptType.values.firstWhere(
      (element) => Hive.box('user').get('selected_script') == element.name,
    );
    return BlocProvider(
      create: (context) => AyahByAyahInScrollInfoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<
            AyahByAyahInScrollInfoCubit,
            AyahByAyahInScrollInfoState
          >(
            buildWhen: (previous, current) {
              return previous.surahInfoModel?.toMap() !=
                  current.surahInfoModel?.toMap();
            },
            builder:
                (context, state) => Text(
                  state.surahInfoModel?.nameSimple == null
                      ? ''
                      : '${state.surahInfoModel?.nameSimple} ( ${state.surahInfoModel?.nameArabic} )',
                  style: const TextStyle(fontSize: 18),
                ),
          ),
          actions: [
            BlocBuilder<
              AyahByAyahInScrollInfoCubit,
              AyahByAyahInScrollInfoState
            >(
              buildWhen: (previous, current) {
                return previous.isAyahByAyah != current.isAyahByAyah;
              },
              builder: (context, state) {
                return IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  onPressed: () {
                    context.read<AyahByAyahInScrollInfoCubit>().setData(
                      isAyahByAyah: !state.isAyahByAyah,
                    );
                  },

                  icon: Icon(
                    state.isAyahByAyah
                        ? CupertinoIcons.book
                        : CupertinoIcons.list_bullet,
                    color: AppColors.primaryColor,
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: pagesInfoWithSurahMetaData.length,
              itemBuilder: (context, index) {
                var current = pagesInfoWithSurahMetaData[index];
                if (current.runtimeType == SurahHeaderInfoModel) {
                  return SurahInfoHeaderBuilder(headerInfoModel: current);
                } else if (current.runtimeType == List<dynamic>) {
                  List<String> ayahsKeyOfPage = List<String>.from(current);
                  // find the page number
                  PageInfoModel? previousPageInfo;
                  if (index != 1) {
                    if (pagesInfoWithSurahMetaData[index - 1].runtimeType ==
                        PageInfoModel) {
                      previousPageInfo = pagesInfoWithSurahMetaData[index - 1];
                    } else if (index > 1 &&
                        pagesInfoWithSurahMetaData[index - 2].runtimeType ==
                            PageInfoModel) {
                      previousPageInfo = pagesInfoWithSurahMetaData[index - 2];
                    } else if (index > 2 &&
                        pagesInfoWithSurahMetaData[index - 3].runtimeType ==
                            PageInfoModel) {
                      previousPageInfo = pagesInfoWithSurahMetaData[index - 3];
                    }
                  }

                  int? pageNumber = previousPageInfo?.pageNumber;

                  return BlocBuilder<
                    AyahByAyahInScrollInfoCubit,
                    AyahByAyahInScrollInfoState
                  >(
                    buildWhen: (previous, current) {
                      return previous.isAyahByAyah != current.isAyahByAyah ||
                          previous.pageByPageList?.contains(pageNumber) !=
                              current.pageByPageList?.contains(pageNumber);
                    },
                    builder: (context, state) {
                      bool isPageByPageThisPage =
                          state.pageByPageList?.contains(pageNumber) == true;

                      return state.isAyahByAyah == true &&
                              isPageByPageThisPage == false
                          ? VisibilityDetector(
                            key: Key(ayahsKeyOfPage.first),
                            onVisibilityChanged: (info) {
                              if (!context.mounted) {
                                return;
                              }
                              try {
                                SurahInfoModel surahInfoModel =
                                    SurahInfoModel.fromMap(
                                      metaDataSurah[ayahsKeyOfPage.first
                                          .split(':')
                                          .first],
                                    );
                                context
                                    .read<AyahByAyahInScrollInfoCubit>()
                                    .setData(surahInfoModel: surahInfoModel);
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: Column(
                              children: List.generate(ayahsKeyOfPage.length, (
                                idx,
                              ) {
                                return getAyahByAyahCard(
                                  ayahKey: ayahsKeyOfPage[idx],
                                  quranScriptType: quranScriptType,
                                  context: context,
                                );
                              }),
                            ),
                          )
                          : VisibilityDetector(
                            key: Key(ayahsKeyOfPage.first),
                            onVisibilityChanged: (info) {
                              if (!context.mounted) {
                                return;
                              }
                              try {
                                SurahInfoModel surahInfoModel =
                                    SurahInfoModel.fromMap(
                                      metaDataSurah[ayahsKeyOfPage.first
                                          .split(':')
                                          .first],
                                    );
                                context
                                    .read<AyahByAyahInScrollInfoCubit>()
                                    .setData(surahInfoModel: surahInfoModel);
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: QuranPagesRenderer(
                              ayahsKey: ayahsKeyOfPage,
                              quranScriptType: quranScriptType,
                              baseStyle: const TextStyle(fontSize: 24),
                            ),
                          );
                    },
                  );
                } else {
                  return BlocBuilder<
                    AyahByAyahInScrollInfoCubit,
                    AyahByAyahInScrollInfoState
                  >(
                    buildWhen:
                        (previous, current) =>
                            (previous.isAyahByAyah != current.isAyahByAyah) ||
                            (previous.pageByPageList != current.pageByPageList),
                    builder:
                        (context, state) => Container(
                          width: double.infinity,
                          height: 30,
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          child: Row(
                            mainAxisAlignment:
                                state.isAyahByAyah
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Gap(15),
                                  const Text('Page: '),
                                  Text(
                                    (current as PageInfoModel).pageNumber
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(15),
                                ],
                              ),
                              if (state.isAyahByAyah)
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: IconButton(
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      List<int> pageByPageList =
                                          state.pageByPageList?.toList() ?? [];

                                      int pageNumber = (current).pageNumber;
                                      if (pageByPageList.contains(pageNumber)) {
                                        pageByPageList.remove(pageNumber);
                                      } else {
                                        pageByPageList.add(pageNumber);
                                      }
                                      context
                                          .read<AyahByAyahInScrollInfoCubit>()
                                          .setData(
                                            pageByPageList: pageByPageList,
                                          );
                                    },

                                    icon: Icon(
                                      state.pageByPageList?.contains(
                                                current.pageNumber,
                                              ) ==
                                              true
                                          ? CupertinoIcons
                                              .list_bullet_below_rectangle
                                          : CupertinoIcons.list_bullet,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                  );
                }
              },
            ),

            const SafeArea(
              child: Align(
                alignment: Alignment(0.9, 0.95),
                child: AudioControllerUi(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
