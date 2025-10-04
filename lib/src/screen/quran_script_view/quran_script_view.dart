import "dart:async";
import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/utils/basic_functions.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/gen_ayahs_key.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/get_page_number.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/landscape_scroll_effect.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/settings/quran_script_settings.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/widget/audio/audio_controller_ui.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/history/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:dartx/dartx.dart";
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
  late AppLocalizations appLocalizations;
  int? _lastFirstVisibleItemIndex;
  double? _lastFirstVisibleItemLeadingEdge;
  StreamSubscription? _ayahKeyCubitSubscription;
  @override
  void initState() {
    String firstAyahInfo = widget.toScrollKey ?? widget.startKey;
    context.read<AyahByAyahInScrollInfoCubit>().setData(
      dropdownAyahKey: firstAyahInfo,
      surahInfoModel: SurahInfoModel.fromMap(
        metaDataSurah[firstAyahInfo.split(":").first],
      ),
    );
    var listOfAyahs = getListOfAyahKey(
      startAyahKey: widget.startKey,
      endAyahKey: widget.endKey,
    );
    listOfAyahs.removeWhere((element) => element.runtimeType == int);
    listOfAyahs = List<String>.from(listOfAyahs);

    Map<int, List<String>> pagesMap = {};

    for (String ayahKey in listOfAyahs) {
      int? pageNum = getPageNumber(ayahKey);
      if (pageNum != null) {
        List<String> ayahKeyListOnPage = pagesMap[pageNum] ?? [];
        ayahKeyListOnPage.add(ayahKey);
        pagesMap[pageNum] = ayahKeyListOnPage;
      }
    }

    List<PageInfoModel> currentPagesToShow = [];
    pagesMap.forEach((key, value) {
      currentPagesToShow.add(
        PageInfoModel(
          start: convertKeyToAyahNumber(value.first)!,
          end: convertKeyToAyahNumber(value.last)!,
          surahNumber: value.first.split(":").first.toInt(),
          pageNumber: key,
        ),
      );
    });

    for (PageInfoModel pageInfo in currentPagesToShow) {
      List ayahsKeys = getListOfAyahKey(
        startAyahKey: convertAyahNumberToKey(pageInfo.start)!,
        endAyahKey: convertAyahNumberToKey(pageInfo.end)!,
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

    for (int i = 0; i < allAyahsKey.length; i++) {
      ayahKeyToKey["${allAyahsKey[i]}"] = GlobalKey();
    }

    if (widget.toScrollKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        // Recalculate targetIndex here if pagesInfoWithSurahMetaData is populated late
        await scrollToAyah(widget.toScrollKey!);
      });
    }

    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isEmpty) return;

      final firstItem = positions.first;
      bool? isScrollingToDown;

      if (_lastFirstVisibleItemIndex != null &&
          _lastFirstVisibleItemLeadingEdge != null) {
        if (firstItem.index > _lastFirstVisibleItemIndex!) {
          isScrollingToDown = true;
        } else if (firstItem.index < _lastFirstVisibleItemIndex!) {
          isScrollingToDown = false;
        } else {
          if (firstItem.itemLeadingEdge < _lastFirstVisibleItemLeadingEdge!) {
            isScrollingToDown = true;
          } else if (firstItem.itemLeadingEdge >
              _lastFirstVisibleItemLeadingEdge!) {
            isScrollingToDown = false;
          }
        }
        if (isScrollingToDown != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            context.read<LandscapeScrollEffect>().changeState(
              isScrollingToDown!,
            );
          });
        }
      }

      _lastFirstVisibleItemIndex = firstItem.index;
      _lastFirstVisibleItemLeadingEdge = firstItem.itemLeadingEdge;
    });

    _ayahKeyCubitSubscription = context.read<AyahKeyCubit>().stream.listen((
      event,
    ) {
      if (context.read<QuranViewCubit>().state.scrollWithRecitation) {
        int? pageNumber = getPageNumber(event.current);
        if (!(latestState?.isAyahByAyah == true) ||
            latestState?.pageByPageList?.contains(pageNumber) == true) {
          if (pageNumber != null) {
            if (pageNumber !=
                context.read<AyahKeyCubit>().state.lastScrolledPageNumber) {
              context.read<AyahKeyCubit>().changeLastScrolledPage(pageNumber);
              scrollToAyah(event.current);
            }
          }
        } else {
          scrollToAyah(event.current);
        }
      }
    });

    super.initState();
  }

  AyahByAyahInScrollInfoState? latestState;

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

  @override
  void dispose() {
    _ayahKeyCubitSubscription?.cancel();
    super.dispose();
  }

  ItemScrollController itemScrollControllerSideBar = ItemScrollController();
  ItemPositionsListener itemPositionsListenerSidebar =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    appLocalizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandScape = width > height;

    return Scaffold(
      appBar:
          isLandScape
              ? null
              : AppBar(
                title: appBarTitle(),
                actions: [
                  getAyahsDropDown(themeState),
                  const Gap(5),
                  getChangesViewButton(themeState),
                  getSettingsButton(themeState, context),
                ],
                titleSpacing: 0,
              ),
      body: Stack(
        children: [
          isLandScape
              ? Row(
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: themeState.primaryShade100),
                        borderRadius: BorderRadius.circular(roundedRadius),
                      ),
                      width: 80,
                      child: BlocBuilder<
                        AyahByAyahInScrollInfoCubit,
                        AyahByAyahInScrollInfoState
                      >(
                        buildWhen: (previous, current) {
                          bool shouldBuild =
                              previous.dropdownAyahKey !=
                              current.dropdownAyahKey;
                          if (shouldBuild) {
                            int selectedIndex = allAyahsKey.indexOf(
                              current.dropdownAyahKey,
                            );
                            WidgetsBinding.instance.addPostFrameCallback((
                              _,
                            ) async {
                              final visibleIndex =
                                  itemPositionsListenerSidebar
                                      .itemPositions
                                      .value
                                      .map((e) => e.index)
                                      .toList();
                              log(visibleIndex.toString());
                              if (!visibleIndex.contains(selectedIndex)) {
                                itemScrollControllerSideBar.scrollTo(
                                  index:
                                      selectedIndex != -1 ? selectedIndex : 0,
                                  duration: const Duration(milliseconds: 200),
                                );
                              }
                            });
                          }
                          return shouldBuild;
                        },
                        builder: (context, state) {
                          int selectedIndex = allAyahsKey.indexOf(
                            state.dropdownAyahKey,
                          );
                          return ScrollablePositionedList.builder(
                            itemCount: allAyahsKey.length,
                            initialScrollIndex:
                                selectedIndex != -1 ? selectedIndex : 0,
                            itemScrollController: itemScrollControllerSideBar,
                            itemPositionsListener: itemPositionsListenerSidebar,
                            itemBuilder: (context, index) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      selectedIndex == index
                                          ? themeState.primary
                                          : themeState.primaryShade100,
                                  foregroundColor:
                                      selectedIndex == index
                                          ? Colors.white
                                          : themeState.primary,
                                ),
                                onPressed: () {},
                                child: Text(allAyahsKey[index].toString()),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(child: ayahPositionedListPart(isLandScape)),
                ],
              )
              : ayahPositionedListPart(isLandScape),
          if (isLandScape)
            SafeArea(
              child: Align(
                alignment: const Alignment(-.65, -1),
                child: BlocBuilder<LandscapeScrollEffect, bool>(
                  builder: (context, isScrollDown) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(left: 10),
                      width: isScrollDown ? 50 : 260,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade400,
                            blurRadius: 10,
                            offset: const Offset(-3, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_rounded),
                              ),
                              SizedBox(
                                width: 100,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: appBarTitle(),
                                ),
                              ),
                              const Gap(5),
                              if (!isLandScape) getAyahsDropDown(themeState),
                              if (!isLandScape) const Gap(5),

                              getChangesViewButton(themeState),

                              getSettingsButton(themeState, context),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          const SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: AudioControllerUi(),
            ),
          ),
        ],
      ),
    );
  }

  ScrollablePositionedList ayahPositionedListPart(bool isLandScape) {
    return ScrollablePositionedList.builder(
      itemCount: pagesInfoWithSurahMetaData.length,
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      scrollOffsetController: scrollOffsetController,
      scrollOffsetListener: scrollOffsetListener,
      semanticChildCount: pagesInfoWithSurahMetaData.length,
      padding: EdgeInsets.only(bottom: 200, top: isLandScape ? 50 : 0),
      itemBuilder: (context, index) {
        return SafeArea(child: getElementWidget(index));
      },
    );
  }

  Widget appBarTitle() {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      buildWhen: (previous, current) {
        return previous.surahInfoModel?.toMap() !=
            current.surahInfoModel?.toMap();
      },
      builder: (context, state) {
        latestState = state;
        return Text(
          state.surahInfoModel == null
              ? ""
              : appLocalizations.surahName(
                getSurahName(context, state.surahInfoModel!.id),
              ),
          style: const TextStyle(fontSize: 18),
        );
      },
    );
  }

  IconButton getSettingsButton(ThemeState themeState, BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: themeState.primaryShade100,
        foregroundColor: themeState.primary,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuranScriptSettings(asPage: true),
          ),
        );
      },
      icon: const Icon(FluentIcons.settings_24_filled),
    );
  }

  BlocBuilder<AyahByAyahInScrollInfoCubit, AyahByAyahInScrollInfoState>
  getChangesViewButton(ThemeState themeState) {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      buildWhen: (previous, current) {
        return previous.isAyahByAyah != current.isAyahByAyah;
      },
      builder: (context, state) {
        latestState = state;
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
    );
  }

  Container getAyahsDropDown(ThemeState themeState) {
    return Container(
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
          latestState = state;
          return DropdownButton(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            isExpanded: false,
            underline: const SizedBox(),
            value: state.dropdownAyahKey,
            items: List.generate(allAyahsKey.length, (index) {
              List<String> ayahData = allAyahsKey[index].toString().split(":");
              return DropdownMenuItem(
                value: allAyahsKey[index],
                child: Center(
                  child: Text(
                    "${localizedNumber(context, ayahData.first.toInt())}:${localizedNumber(context, ayahData.last.toInt())}",
                  ),
                ),
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

      int? pageNumber = previousPageInfo?.start;

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
          latestState = state;
          bool isPageByPageThisPage =
              state.pageByPageList?.contains(pageNumber) == true;

          return state.isAyahByAyah == true && isPageByPageThisPage == false
              ? Column(
                children: List.generate(ayahsKeyOfPage.length, (idx) {
                  return FutureBuilder(
                    future: getTranslationWithWordByWord(ayahsKeyOfPage[idx]),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState !=
                          ConnectionState.done) {
                        return const SizedBox(height: 250);
                      }
                      return getAyahByAyahCard(
                        key: ayahKeyToKey[ayahsKeyOfPage[idx]],
                        ayahKey: ayahsKeyOfPage[idx],
                        context: context,
                        translationMap: asyncSnapshot.data?.translation ?? {},
                        wordByWord: asyncSnapshot.data?.wordByWord ?? [],
                      );
                    },
                  );
                }),
              )
              : VisibilityDetector(
                key: Key("page-$index}"),
                onVisibilityChanged: (info) {
                  if (!context.mounted) {
                    return;
                  }
                  context.read<QuranHistoryCubit>().addHistory(
                    ayahsKeyOfPage.first,
                  );

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
        builder: (context, state) {
          latestState = state;
          return Container(
            width: MediaQuery.of(context).size.width,
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
                    Text(appLocalizations.page),
                    Text(
                      " - ${localizedNumber(context, (current as PageInfoModel).pageNumber)}",

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
          );
        },
      );
    }
  }
}
