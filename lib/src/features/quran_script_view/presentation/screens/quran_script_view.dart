import "dart:async";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/navigation_info_model.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/surah_header_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/navigation/next_and_previous_navigation.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/gen_ayahs_key.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/get_page_number.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/pages_render/quran_page_renderer.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

import "package:al_quran_v3/src/features/audio/presentation/widgets/audio_controller_ui.dart";

class QuranScriptView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;
  final int? currentIndex;
  final NavigationInfoModel Function(int index)? getNavigationInfo;
  const QuranScriptView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
    this.currentIndex,
    this.getNavigationInfo,
  });

  @override
  State<QuranScriptView> createState() => _QuranScriptViewState();
}

class _QuranScriptViewState extends State<QuranScriptView> {
  final GlobalKey _mainContentKey = GlobalKey();
  final ItemScrollController itemScrollControllerAyahByAyah =
      ItemScrollController();
  final ItemPositionsListener itemPositionsListenerAyahByAyah =
      ItemPositionsListener.create();

  final ItemScrollController itemScrollControllerReadingMode =
      ItemScrollController();
  final ItemPositionsListener itemPositionsListenerReadingMode =
      ItemPositionsListener.create();

  final ItemScrollController itemScrollControllerSurahList =
      ItemScrollController();
  final ItemScrollController itemScrollControllerAyahList =
      ItemScrollController();
  final ItemPositionsListener itemPositionsListenerAyahList =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollControllerPagesList =
      ItemScrollController();
  final ItemPositionsListener itemPositionsListenerPagesList =
      ItemPositionsListener.create();

  StreamSubscription? _ayahKeyCubitSubscription;
  String? scrolledAyahOnAudioPlay;
  int? lastScrolledPageIndex;
  String? _lastTopAyahKey;
  int? _lastTopPageIndex;
  Timer? _historyDebounceTimer;

  late List<String> ayahsList;
  List<List<String>> pagesList = [];

  Future<void> scrollToAyah(dynamic key, {Duration? duration}) async {
    if (key is String) {
      if (itemScrollControllerAyahByAyah.isAttached) {
        int index = ayahsList.indexOf(key);
        if (index != -1) {
          if (duration == Duration.zero) {
            itemScrollControllerAyahByAyah.jumpTo(
              index: index,
              alignment: 0.15,
            );
          } else {
            itemScrollControllerAyahByAyah.scrollTo(
              index: index,
              alignment: 0.15,
              duration: duration ?? const Duration(milliseconds: 200),
            );
          }
        }
      }
    } else if (key is List<String>) {
      if (itemScrollControllerReadingMode.isAttached) {
        int index = pagesList.indexOf(key);
        if (index != -1) {
          itemScrollControllerReadingMode.scrollTo(
            index: index,
            alignment: 0.15,
            duration: const Duration(milliseconds: 200),
          );
        }
      }
    }
  }

  void _onAyahByAyahScrollPositionChanged() {
    final positions = itemPositionsListenerAyahByAyah.itemPositions.value;
    if (positions.isEmpty) return;

    ItemPosition? topItem;
    for (final p in positions) {
      if (p.itemTrailingEdge > 0.05) {
        if (topItem == null || p.itemLeadingEdge < topItem.itemLeadingEdge) {
          topItem = p;
        }
      }
    }

    if (topItem != null && topItem.index < ayahsList.length) {
      final String ayahKey = ayahsList[topItem.index];
      if (_lastTopAyahKey != ayahKey) {
        _lastTopAyahKey = ayahKey;
        final int surahNumber = int.tryParse(ayahKey.split(":").first) ?? 1;
        final surahInfoModel = SurahInfoModel.fromMap(
          metaDataSurah["$surahNumber"]!,
        );

        context.read<AyahByAyahInScrollInfoCubit>().setData(
          surahInfoModel: surahInfoModel,
          dropdownAyahKey: ayahKey,
        );

        _historyDebounceTimer?.cancel();
        _historyDebounceTimer = Timer(const Duration(milliseconds: 350), () {
          if (mounted) {
            context.read<QuranHistoryCubit>().addHistory(ayahKey: ayahKey);
          }
        });
      }
    }
  }

  void _onReadingModeScrollPositionChanged() {
    final positions = itemPositionsListenerReadingMode.itemPositions.value;
    if (positions.isEmpty) return;

    ItemPosition? topItem;
    for (final p in positions) {
      if (p.itemTrailingEdge > 0.05) {
        if (topItem == null || p.itemLeadingEdge < topItem.itemLeadingEdge) {
          topItem = p;
        }
      }
    }

    if (topItem != null && topItem.index < pagesList.length) {
      final int pageIdx = topItem.index;
      if (_lastTopPageIndex != pageIdx) {
        _lastTopPageIndex = pageIdx;
        final List<String> currentPage = pagesList[pageIdx];
        final String firstAyah = currentPage.first;
        final int surahNumber = int.tryParse(firstAyah.split(":").first) ?? 1;
        final int pageNumber = getPageNumber(firstAyah) ?? 0;
        final surahInfoModel = SurahInfoModel.fromMap(
          metaDataSurah["$surahNumber"]!,
        );

        context.read<AyahByAyahInScrollInfoCubit>().setData(
          surahInfoModel: surahInfoModel,
          dropdownAyahKey: currentPage,
        );

        _historyDebounceTimer?.cancel();
        _historyDebounceTimer = Timer(const Duration(milliseconds: 350), () {
          if (mounted) {
            context.read<QuranHistoryCubit>().addHistory(
              pageNumber: pageNumber,
              ayahKey: firstAyah,
            );
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _historyDebounceTimer?.cancel();
    _ayahKeyCubitSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ayahsList = getListOfAyahKeyExperimental(
      startAyahKey: widget.startKey,
      endAyahKey: widget.endKey,
    );

    // Pre-warm translation cache in background for smooth, instant rendering
    prewarmAyahsTranslation(ayahsList);

    List<String> parts = [];
    int lastPage = getPageNumber(ayahsList.first) ?? 0;

    for (String ayahKey in ayahsList) {
      int page = getPageNumber(ayahKey) ?? 0;
      if (lastPage == page) {
        if (ayahKey ==
            getEndAyahKeyFromSurahNumber(ayahKey.split(":").first.toInt())) {
          parts.add(ayahKey);
          pagesList.add(parts);
          parts = [];
        } else {
          parts.add(ayahKey);
        }
      } else {
        lastPage = page;
        parts.add(ayahKey);
        if (parts.length > 1) {
          pagesList.add(parts);
          parts = [];
        }
      }
    }

    if (parts.isNotEmpty) {
      pagesList.add(parts);
      parts = [];
    }

    // Attach native scroll position listeners for zero-overhead visibility detection
    itemPositionsListenerAyahByAyah.itemPositions.addListener(
      _onAyahByAyahScrollPositionChanged,
    );
    itemPositionsListenerReadingMode.itemPositions.addListener(
      _onReadingModeScrollPositionChanged,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AyahByAyahInScrollInfoCubit>().stream.listen((event) {
        if (!isLandScape) return;
        if (previousDropdownAyahKey != event.dropdownAyahKey) {
          final dynamic dropdownAyahKey = event.dropdownAyahKey;
          if (dropdownAyahKey != null && dropdownAyahKey is String) {
            final index = ayahsList.indexOf(dropdownAyahKey);
            if (index != -1) {
              bool isVisible = isItemVisible(
                itemPositionsListenerAyahList,
                index,
              );
              if (!isVisible && itemScrollControllerAyahList.isAttached) {
                itemScrollControllerAyahList.scrollTo(
                  index: index,
                  duration: const Duration(milliseconds: 200),
                  alignment: 0.5,
                );
              }
            }
          } else if (event.dropdownAyahKey != null &&
              dropdownAyahKey is List<String>) {
            final index = pagesList.indexOf(event.dropdownAyahKey);
            if (index != -1) {
              bool isVisible = isItemVisible(
                itemPositionsListenerPagesList,
                index,
              );
              if (!isVisible && itemScrollControllerPagesList.isAttached) {
                itemScrollControllerPagesList.scrollTo(
                  index: index,
                  duration: const Duration(milliseconds: 200),
                  alignment: 0.5,
                );
              }
            }
          }
        }
        previousDropdownAyahKey = event.dropdownAyahKey;
      });
    });

    _ayahKeyCubitSubscription = context.read<AyahKeyCubit>().stream.listen((
      event,
    ) {
      context.read<AyahToHighlight>().changeAyah(event.current);
      if (scrolledAyahOnAudioPlay != null &&
          event.current == scrolledAyahOnAudioPlay) {
        return;
      }
      if (context.read<AyahByAyahInScrollInfoCubit>().state.isAyahByAyah) {
        scrollToAyah(event.current);
      } else {
        int index = pagesList.indexWhere(
          (element) => element.contains(event.current),
        );
        if (index != -1 && index != lastScrolledPageIndex) {
          lastScrolledPageIndex = index;
          scrollToAyah(pagesList[index]);
        }
        context.read<SegmentedQuranReciterCubit>().temporaryHilightAyah(
          event.current,
        );
      }

      scrolledAyahOnAudioPlay = event.current;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (AudioPlayerManager.audioPlayer.currentIndex != null) {
        final currentPlayingAyah = context.read<AyahKeyCubit>().state.current;

        if (currentPlayingAyah.isNotEmpty &&
            ayahsList.contains(currentPlayingAyah)) {
          if (context.read<AyahByAyahInScrollInfoCubit>().state.isAyahByAyah) {
            scrollToAyah(currentPlayingAyah, duration: Duration.zero);
          } else {
            int index = pagesList.indexWhere(
              (element) => element.contains(currentPlayingAyah),
            );
            if (index != -1) {
              scrollToAyah(pagesList[index], duration: Duration.zero);
            }
          }
          return;
        }
      }

      if (widget.toScrollKey != null) {
        if (context.read<AyahByAyahInScrollInfoCubit>().state.isAyahByAyah) {
          scrollToAyah(widget.toScrollKey, duration: Duration.zero);
        } else {
          int index = pagesList.indexWhere(
            (element) => element.contains(widget.toScrollKey),
          );
          if (index != -1) {
            scrollToAyah(pagesList[index], duration: Duration.zero);
          }
        }
      }
    });
  }

  dynamic previousDropdownAyahKey;
  bool isLandScape = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    double width = MediaQuery.of(context).size.width;
    isLandScape = width > 600;

    final mainContent = Stack(
      key: _mainContentKey,
      children: [
        quranScriptWidget(l10n),
        const SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: AudioControllerUi(),
          ),
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: isLandScape
          ? null
          : AppBar(
              title: appBarTitle(),
              actions: [
                getAyahsDropDown(themeState),
                getChangesViewButton(themeState),
                getSettingsButton(themeState, context),
              ],
            ),
      body: isLandScape
          ? Row(
              children: [
                SafeArea(
                  right: false,
                  bottom: false,
                  top: true,
                  left: true,
                  child: sideBarOfSurahAndAyah(themeState, context),
                ),
                Expanded(child: mainContent),
              ],
            )
          : mainContent,
    );
  }

  Column sideBarOfSurahAndAyah(ThemeState themeState, BuildContext context) {
    return Column(
      children: [
        Container(
          width: 210,
          height: 45,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: themeState.primaryShade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              BackButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: themeState.primaryShade100,
                ),
              ),
              const Gap(5),
              getChangesViewButton(themeState),
              const Gap(5),
              getSettingsButton(themeState, context),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 120,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: themeState.primaryShade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    BlocBuilder<
                      AyahByAyahInScrollInfoCubit,
                      AyahByAyahInScrollInfoState
                    >(
                      builder: (context, ayahState) {
                        return ScrollablePositionedList.builder(
                          itemScrollController: itemScrollControllerSurahList,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          itemCount: 114,
                          itemBuilder: (context, index) {
                            bool isCurrent =
                                (index + 1) == ayahState.surahInfoModel?.id;
                            return OutlinedButton(
                              style: outlineButtonDesignSidebar(
                                isCurrent,
                                themeState,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuranScriptView(
                                      startKey: "${index + 1}:1",
                                      endKey: getEndAyahKeyFromSurahNumber(
                                        index + 1,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    getSurahName(context, index + 1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isCurrent
                                          ? themeState.primary
                                          : Colors.grey,
                                    ),
                                  ),
                                  if (isCurrent) const Gap(5),
                                  if (isCurrent)
                                    const Icon(
                                      Icons.radio_button_checked,
                                      size: 12,
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),

              Container(
                width: 80,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: themeState.primaryShade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    BlocBuilder<
                      AyahByAyahInScrollInfoCubit,
                      AyahByAyahInScrollInfoState
                    >(
                      builder: (context, ayahState) {
                        if (ayahState.isAyahByAyah) {
                          return ScrollablePositionedList.builder(
                            itemScrollController: itemScrollControllerAyahList,
                            itemPositionsListener:
                                itemPositionsListenerAyahList,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemCount: ayahsList.length,
                            itemBuilder: (context, index) {
                              bool isCurrent =
                                  ayahState.dropdownAyahKey == ayahsList[index];

                              return OutlinedButton(
                                style: outlineButtonDesignSidebar(
                                  isCurrent,
                                  themeState,
                                ),
                                onPressed: () {
                                  scrollToAyah(ayahsList[index]);
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) async {
                                    context
                                        .read<AyahByAyahInScrollInfoCubit>()
                                        .setData(
                                          dropdownAyahKey: ayahsList[index],
                                        );
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${localizedNumber(context, ayahsList[index].split(":").first.toInt())}:${localizedNumber(context, ayahsList[index].split(":").last.toInt())}",
                                    ),
                                    if (isCurrent) const Gap(5),
                                    if (isCurrent)
                                      const Icon(
                                        Icons.radio_button_checked,
                                        size: 12,
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return ScrollablePositionedList.builder(
                            itemScrollController: itemScrollControllerPagesList,
                            itemPositionsListener:
                                itemPositionsListenerPagesList,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemCount: pagesList.length,
                            itemBuilder: (context, index) {
                              bool isCurrent =
                                  ayahState.dropdownAyahKey == pagesList[index];
                              return OutlinedButton(
                                style: outlineButtonDesignSidebar(
                                  isCurrent,
                                  themeState,
                                ),
                                onPressed: () {
                                  scrollToAyah(pagesList[index]);
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) async {
                                    context
                                        .read<AyahByAyahInScrollInfoCubit>()
                                        .setData(
                                          dropdownAyahKey: pagesList[index],
                                        );
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      localizedNumber(
                                        context,
                                        getPageNumber(pagesList[index].first) ??
                                            0,
                                      ),
                                    ),
                                    if (isCurrent) const Gap(5),
                                    if (isCurrent)
                                      const Icon(
                                        Icons.radio_button_checked,
                                        size: 12,
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ButtonStyle outlineButtonDesignSidebar(
    bool isCurrent,
    ThemeState themeState,
  ) {
    return OutlinedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: BorderSide(
        color: isCurrent ? themeState.primary : themeState.mutedGray,
        width: isCurrent ? 1.5 : 1,
      ),
    );
  }

  Widget quranScriptWidget(AppLocalizations l10n) {
    const double topPadding = 6;

    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      buildWhen: (previous, current) {
        return previous.isAyahByAyah != current.isAyahByAyah;
      },
      builder: (context, state) {
        if (state.isAyahByAyah) {
          // Ayah-by-Ayah Mode
          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollControllerAyahByAyah,
            itemPositionsListener: itemPositionsListenerAyahByAyah,
            itemCount: ayahsList.length + 1,
            padding: const EdgeInsets.only(top: topPadding, bottom: 100),
            itemBuilder: (context, index) {
              if (index == ayahsList.length) {
                return NextAndPreviousNavigation(widget: widget);
              }
              final ayahKey = ayahsList[index];
              final ayahKeySplit = ayahKey.split(":");
              final int surahNumber = ayahKeySplit.first.toInt();
              final int ayahNumber = ayahKeySplit.last.toInt();
              final String surahEndAyahKey =
                  surahNumber == ayahsList.last.split(":").last.toInt()
                  ? ayahsList.last
                  : getEndAyahKeyFromSurahNumber(surahNumber);
              final bool isSurahHeadingIncluded = ayahNumber == 1;
              final int pageNumber = getPageNumber(ayahKey) ?? 0;
              PageInfoModel? pageInfo;
              try {
                pageInfo = PageInfoModel.fromMap(
                  quranPagesInfo[pageNumber - 1],
                );
              } catch (_) {}

              final bool isPageStart =
                  pageInfo?.start == ayahNumber || index == 0;

              final TranslationWithWordByWord? translationData =
                  getTranslationFromCache(ayahKey);

              return Column(
                children: [
                  if (isSurahHeadingIncluded)
                    SurahInfoHeaderBuilder(
                      headerInfoModel: SurahHeaderInfoModel(
                        surahInfoModel: SurahInfoModel.fromMap(
                          metaDataSurah["$surahNumber"]!,
                        ),
                        startAyahKey: ayahKey,
                        endAyahKey: surahEndAyahKey,
                      ),
                    ),
                  if (isPageStart) pageLabelOfQuran(context, l10n, pageNumber),
                  translationData != null
                      ? AyahByAyahCard(
                          ayahKey: ayahKey,
                          translationListWithInfo:
                              translationData.translationList,
                          wordByWord: translationData.wordByWord ?? [],
                        )
                      : FutureBuilder<TranslationWithWordByWord>(
                          future: getTranslationWithWordByWord(ayahKey),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState !=
                                ConnectionState.done) {
                              return const SizedBox(height: 180);
                            }
                            return AyahByAyahCard(
                              ayahKey: ayahKey,
                              translationListWithInfo:
                                  asyncSnapshot.data?.translationList ?? [],
                              wordByWord: asyncSnapshot.data?.wordByWord ?? [],
                            );
                          },
                        ),
                ],
              );
            },
          );
        } else {
          // Continuous Reading Mode
          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollControllerReadingMode,
            itemPositionsListener: itemPositionsListenerReadingMode,
            itemCount: pagesList.length + 1,
            padding: const EdgeInsets.only(top: topPadding, bottom: 100),
            itemBuilder: (context, index) {
              if (index == pagesList.length) {
                return NextAndPreviousNavigation(widget: widget);
              }
              int pageNumber = getPageNumber(pagesList[index].first) ?? 0;
              List<String> currentPage = pagesList[index];
              String firstAyah = currentPage.first;
              int surahNumber = firstAyah.split(":").first.toInt();

              String? surahEndAyahKey;
              for (int i = index; i < pagesList.length; i++) {
                List<String>? pageToCheck = pagesList[i];
                if (pageToCheck.last ==
                    getEndAyahKeyFromSurahNumber(surahNumber)) {
                  surahEndAyahKey = pageToCheck.last;
                  break;
                }
              }

              return Column(
                children: [
                  if (firstAyah.split(":").last == "1" || index == 0)
                    SurahInfoHeaderBuilder(
                      headerInfoModel: SurahHeaderInfoModel(
                        surahInfoModel: SurahInfoModel.fromMap(
                          metaDataSurah["$surahNumber"]!,
                        ),
                        startAyahKey: firstAyah,
                        endAyahKey: surahEndAyahKey ?? currentPage.last,
                      ),
                    ),
                  pageLabelOfQuran(context, l10n, pageNumber),
                  BlocBuilder<QuranViewCubit, QuranViewState>(
                    builder: (context, quranViewState) {
                      final quranViewCubit = context.read<QuranViewCubit>();
                      TextStyle baseTextStyle = TextStyle(
                        fontSize: quranViewState.fontSize,
                        height: quranViewState.lineHeight,
                        fontFamily:
                            quranViewState.quranScriptType ==
                                QuranScriptType.uthmani
                            ? quranViewCubit.state.uthmaniFontName
                            : quranViewCubit.state.indopakFontName,
                      );
                      return QuranPagesRenderer(
                        ayahsKey: currentPage,
                        baseTextStyle: baseTextStyle,
                        isUthmani:
                            quranViewState.quranScriptType ==
                            QuranScriptType.uthmani,
                        enableWordByWordHighlight:
                            quranViewState.enableWordByWordHighlight,
                        tajweedColorEnable:
                            quranViewState.quranScriptType ==
                                QuranScriptType.uthmani
                            ? quranViewState.useTajweedOnUthmani
                            : quranViewState.useTajweedOnIndopak,
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget appBarTitle() {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      buildWhen: (previous, current) {
        return previous.surahInfoModel != current.surahInfoModel;
      },
      builder: (context, state) {
        return Text(
          state.surahInfoModel == null
              ? ""
              : AppLocalizations.of(
                  context,
                ).surahName(getSurahName(context, state.surahInfoModel!.id)),
          style: const TextStyle(fontSize: 18),
        );
      },
    );
  }

  BlocBuilder<AyahByAyahInScrollInfoCubit, AyahByAyahInScrollInfoState>
  getChangesViewButton(ThemeState themeState) {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      builder: (context, state) {
        return IconButton(
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: themeState.primaryShade100,
          ),
          onPressed: () {
            context.read<AyahByAyahInScrollInfoCubit>().toggleView();
          },
          tooltip: state.isAyahByAyah ? "Ayah by Ayah" : "Reading Mode",
          icon: Icon(
            state.isAyahByAyah
                ? Icons.view_headline_rounded
                : FluentIcons.book_24_regular,
            size: 20,
            color: themeState.primary,
          ),
        );
      },
    );
  }

  IconButton getSettingsButton(ThemeState themeState, BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: themeState.primaryShade100,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuranScriptSettings(asPage: true),
          ),
        );
      },
      tooltip: "Quran Script Settings",
      icon: Icon(Icons.settings_outlined, size: 20, color: themeState.primary),
    );
  }

  Widget getAyahsDropDown(ThemeState themeState) {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      builder: (context, state) {
        return PopupMenuButton<dynamic>(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            backgroundColor: themeState.primaryShade100,
          ),
          tooltip: state.isAyahByAyah ? "Select Ayah" : "Select Page",
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                state.isAyahByAyah
                    ? FluentIcons.text_number_list_ltr_24_regular
                    : FluentIcons.book_open_24_regular,
                size: 19,
                color: themeState.primary,
              ),
              const Gap(2),
              Icon(
                FluentIcons.chevron_down_12_filled,
                size: 10,
                color: themeState.primary,
              ),
            ],
          ),
          onSelected: (dynamic value) {
            scrollToAyah(value);
            context.read<AyahByAyahInScrollInfoCubit>().setData(
              dropdownAyahKey: value,
            );
          },
          itemBuilder: (BuildContext context) {
            if (state.isAyahByAyah) {
              return ayahsList.map((String key) {
                return PopupMenuItem<dynamic>(
                  value: key,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${localizedNumber(context, key.split(":").first.toInt())}:${localizedNumber(context, key.split(":").last.toInt())}",
                      ),
                      if (key == state.dropdownAyahKey)
                        Icon(
                          Icons.radio_button_checked,
                          size: 14,
                          color: themeState.primary,
                        ),
                    ],
                  ),
                );
              }).toList();
            } else {
              return pagesList.map((List<String> key) {
                return PopupMenuItem<dynamic>(
                  value: key,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context).page} ${localizedNumber(context, getPageNumber(key.first) ?? 0)}",
                      ),
                      if (key == state.dropdownAyahKey)
                        Icon(
                          Icons.radio_button_checked,
                          size: 14,
                          color: themeState.primary,
                        ),
                    ],
                  ),
                );
              }).toList();
            }
          },
        );
      },
    );
  }

  Widget pageLabelOfQuran(
    BuildContext context,
    AppLocalizations l10n,
    int pageNumber,
  ) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade300,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : themeState.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : themeState.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              "${l10n.page} ${localizedNumber(context, pageNumber)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: themeState.primary,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  bool isItemVisible(ItemPositionsListener listener, int index) {
    final positions = listener.itemPositions.value;
    for (final position in positions) {
      if (position.index == index) {
        return position.itemLeadingEdge >= 0 && position.itemTrailingEdge <= 1;
      }
    }
    return false;
  }
}
