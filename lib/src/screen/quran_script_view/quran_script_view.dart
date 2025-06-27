import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/settings/quran_script_settings.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/widget/audio/audio_controller_ui.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";
import "package:visibility_detector/visibility_detector.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

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
  List allAyahsKey = [];
  @override
  void initState() {
    int? startAyahNumber = convertKeyToAyahNumber(widget.startKey);
    int? endAyahNumber = convertKeyToAyahNumber(widget.endKey);

    if (startAyahNumber == null || endAyahNumber == null) return;
    bool checkedFirst = false;
    List<PageInfoModel> currentPagesToShow = [];

    for (int i = 0; i < quranPagesInfo.length; i++) {
      if (quranPagesInfo[i]["s"]! >= startAyahNumber ||
          quranPagesInfo[i]["e"]! >= endAyahNumber) {
        if (quranPagesInfo[i]["s"]! - startAyahNumber > 0 && !checkedFirst) {
          int ayahNumber =
              quranPagesInfo[i]["s"]! -
              (quranPagesInfo[i]["s"]! - startAyahNumber);
          currentPagesToShow.add(
            PageInfoModel(
              pageNumber: i,
              firstAyahNumber: ayahNumber,
              lastAyahNumber: quranPagesInfo[i - 1]["e"]!,
            ),
          );
        } else if (endAyahNumber <= quranPagesInfo[i]["e"]!) {
          int firstAyahNumber =
              quranPagesInfo[i]["s"]! < startAyahNumber
                  ? startAyahNumber
                  : quranPagesInfo[i]["s"]!;
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
              firstAyahNumber: quranPagesInfo[i]["s"]!,
              lastAyahNumber: quranPagesInfo[i]["e"]!,
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
        int.parse(widget.startKey.split(":").first),
      );
    }
    int listLen = pagesInfoWithSurahMetaData.length;
    for (int i = 0; i < listLen; i++) {
      if (pagesInfoWithSurahMetaData[i].runtimeType == int) {
        String endAyahKey = getEndAyahKeyFromSurahNumber(
          pagesInfoWithSurahMetaData[i],
        );
        List allAyahsInThisSurah = getListOfAyahKey(
          startAyahKey: "${pagesInfoWithSurahMetaData[i]}:1",
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
              metaDataSurah["${pagesInfoWithSurahMetaData[i]}"],
            ),
            start!,
            end!,
          );
        } catch (e) {
          log(e.toString());
        }
      }
    }

    if (pagesInfoWithSurahMetaData[1].runtimeType != SurahHeaderInfoModel) {
      String? end;
      String startSurahNumber = widget.startKey.split(":").first;
      for (int idx = 0; idx < allAyahsKey.length; idx++) {
        String key = allAyahsKey[idx];
        if (key.split(":").first != startSurahNumber) {
          end = allAyahsKey[idx - 1];
          break;
        }
      }
      end ??= allAyahsKey.last;
      pagesInfoWithSurahMetaData.insert(
        1,
        SurahHeaderInfoModel(
          SurahInfoModel.fromMap(metaDataSurah[startSurahNumber]),
          widget.startKey,
          end!,
        ),
      );
    }

    context.read<AyahByAyahInScrollInfoCubit>().setData(
      dropdownAyahKey: widget.toScrollKey ?? allAyahsKey.first,
    );

    for (int i = 0; i < allAyahsKey.length; i++) {
      ayahKeyToKey["${allAyahsKey[i]}"] = GlobalKey();
    }

    if (widget.toScrollKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Recalculate targetIndex here if pagesInfoWithSurahMetaData is populated late
        await scrollToAyah(widget.toScrollKey!);
      });
    }

    super.initState();
  }

  Future<void> scrollToAyah(String ayahKey) async {
    int? targetIndex;
    for (int i = 0; i < pagesInfoWithSurahMetaData.length; i++) {
      var currentItemData = pagesInfoWithSurahMetaData[i];
      if (currentItemData is List<dynamic> && currentItemData.isNotEmpty) {
        List<String> ayahsKeyOfPage = List<String>.from(currentItemData);
        // Assuming ayahKey might be the first key of a block
        if (ayahsKeyOfPage.first == ayahKey) {
          targetIndex = i;
          break;
        }
        // Or if it can be any key within the block
        if (ayahsKeyOfPage.contains(ayahKey)) {
          targetIndex = i;
          break;
        }
      }
    }

    log(targetIndex.toString(), name: "Target Index");

    if (targetIndex != null && itemScrollController.isAttached) {
      itemScrollController.jumpTo(index: targetIndex);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final GlobalKey? specificAyahKey = ayahKeyToKey[ayahKey];
        if (specificAyahKey != null && specificAyahKey.currentContext != null) {
          await Scrollable.ensureVisible(
            specificAyahKey.currentContext!,
            alignment: 0.0,
          );
        }
      });
    }
  }

  Map<String, GlobalKey> ayahKeyToKey = {};

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    AudioPlayerManager.stopListeningAudioPlayerState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
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
                      ? ""
                      : "${state.surahInfoModel?.nameSimple}",
                  style: const TextStyle(fontSize: 18),
                ),
          ),
          actions: [
            Container(
              width: 80,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(100),
              ),
              child: BlocBuilder<
                AyahByAyahInScrollInfoCubit,
                AyahByAyahInScrollInfoState
              >(
                builder: (context, state) {
                  return DropdownButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    isExpanded: false,

                    value: state.dropdownAyahKey,
                    items: List.generate(allAyahsKey.length, (index) {
                      return DropdownMenuItem(
                        value: allAyahsKey[index],
                        child: Center(child: Text(allAyahsKey[index])),
                      );
                    }),
                    onChanged: (value) async {
                      await scrollToAyah(value.toString());
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        context.read<AyahByAyahInScrollInfoCubit>().setData(
                          dropdownAyahKey: value.toString(),
                        );
                      });
                    },
                  );
                },
              ),
            ),
            const Gap(5),
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
                    backgroundColor: themeState.primaryShade100,
                    foregroundColor: themeState.primary,
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
                  ),
                );
              },
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: themeState.primaryShade100,
                foregroundColor: themeState.primary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const QuranScriptSettings(asPage: true),
                  ),
                );
              },
              icon: const Icon(FluentIcons.settings_24_filled),
            ),
          ],
          titleSpacing: 0,
        ),
        body: Stack(
          children: [
            ScrollablePositionedList.builder(
              itemCount: pagesInfoWithSurahMetaData.length,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              scrollOffsetController: scrollOffsetController,
              scrollOffsetListener: scrollOffsetListener,
              semanticChildCount: pagesInfoWithSurahMetaData.length,

              itemBuilder: (context, index) {
                return getElementWidget(index);
              },
            ),

            const SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: AudioControllerUi(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getElementWidget(int index) {
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

          return state.isAyahByAyah == true && isPageByPageThisPage == false
              ? VisibilityDetector(
                key: Key(ayahsKeyOfPage.first),
                onVisibilityChanged: (info) {
                  if (!context.mounted) {
                    return;
                  }
                  try {
                    SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
                      metaDataSurah[ayahsKeyOfPage.first.split(":").first],
                    );

                    context.read<AyahByAyahInScrollInfoCubit>().setData(
                      surahInfoModel: surahInfoModel,
                      dropdownAyahKey: ayahsKeyOfPage.first,
                    );
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Column(
                  children: List.generate(ayahsKeyOfPage.length, (idx) {
                    return getAyahByAyahCard(
                      key: ayahKeyToKey[ayahsKeyOfPage[idx]],
                      ayahKey: ayahsKeyOfPage[idx],
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
                    SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
                      metaDataSurah[ayahsKeyOfPage.first.split(":").first],
                    );
                    context.read<AyahByAyahInScrollInfoCubit>().setData(
                      surahInfoModel: surahInfoModel,
                    );
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, quranViewState) {
                    return QuranPagesRenderer(
                      ayahsKey: ayahsKeyOfPage,
                      quranScriptType: quranViewState.quranScriptType,
                      enableWordByWordHighlight:
                          quranViewState.enableWordByWordHighlight == true,
                      baseStyle: TextStyle(
                        fontSize: quranViewState.fontSize,
                        height: quranViewState.lineHeight,
                      ),
                    );
                  },
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
              color: context.read<ThemeCubit>().state.primaryShade100,
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
                      const Text("Page: "),
                      Text(
                        (current as PageInfoModel).pageNumber.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(15),
                    ],
                  ),
                  if (state.isAyahByAyah)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        style: IconButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          List<int> pageByPageList =
                              state.pageByPageList?.toList() ?? [];

                          int pageNumber = (current).pageNumber;
                          if (pageByPageList.contains(pageNumber)) {
                            pageByPageList.remove(pageNumber);
                          } else {
                            pageByPageList.add(pageNumber);
                          }
                          context.read<AyahByAyahInScrollInfoCubit>().setData(
                            pageByPageList: pageByPageList,
                          );
                        },

                        icon: Icon(
                          state.pageByPageList?.contains(current.pageNumber) ==
                                  true
                              ? CupertinoIcons.list_bullet_below_rectangle
                              : CupertinoIcons.list_bullet,
                          color: context.read<ThemeCubit>().state.primary,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
      );
    }
  }
}
