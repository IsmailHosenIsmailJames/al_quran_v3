import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/settings/quran_script_settings.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/gen_ayahs_key.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/get_page_number.dart";
import "package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";
import "package:visibility_detector/visibility_detector.dart";

import "../../widget/audio/audio_controller_ui.dart";

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
  State<QuranScriptView> createState() => _QuranScriptViewState();
}

class _QuranScriptViewState extends State<QuranScriptView> {
  ItemScrollController itemScrollControllerAyahByAyah = ItemScrollController();
  ItemScrollController itemScrollControllerReadingMode = ItemScrollController();
  ItemScrollController itemScrollControllerSurahList = ItemScrollController();
  ItemScrollController itemScrollControllerAyahList = ItemScrollController();
  ItemPositionsListener itemPositionsListenerAyahList =
      ItemPositionsListener.create();
  ItemScrollController itemScrollControllerPagesList = ItemScrollController();
  ItemPositionsListener itemPositionsListenerPagesList =
      ItemPositionsListener.create();

  late List<String> ayahsList;
  List<List<String>> pagesList = [];

  Future<void> scrollToAyah(dynamic key) async {
    if (key is String) {
      itemScrollControllerAyahByAyah.scrollTo(
        index: ayahsList.indexOf(key),
        duration: const Duration(milliseconds: 200),
      );
    } else if (key is List<String>) {
      itemScrollControllerReadingMode.scrollTo(
        index: pagesList.indexOf(key),
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  void initState() {
    ayahsList = getListOfAyahKeyExperimental(
      startAyahKey: widget.startKey,
      endAyahKey: widget.endKey,
    );
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
        pagesList.add(parts);
        parts = [];
      }
    }
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

    super.initState();
  }

  dynamic previousDropdownAyahKey;
  bool isLandScape = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    double width = MediaQuery.of(context).size.width;
    isLandScape = width > 600;

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
                  const Gap(2),
                  getSettingsButton(themeState, context),
                ],
              ),
      body:
          isLandScape
              ? Row(
                children: [
                  SafeArea(
                    right: false,
                    bottom: false,
                    top: true,
                    left: true,
                    child: sideBarOfSurahAndAyah(themeState, context),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        quranScriptWidget(l10n),
                        const SafeArea(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: AudioControllerUi(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : Stack(
                children: [
                  quranScriptWidget(l10n),
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
                child: BlocBuilder<
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
                                builder:
                                    (context) => QuranScriptView(
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
                                  color:
                                      isCurrent
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
                child: BlocBuilder<
                  AyahByAyahInScrollInfoCubit,
                  AyahByAyahInScrollInfoState
                >(
                  builder: (context, ayahState) {
                    if (ayahState.isAyahByAyah) {
                      return ScrollablePositionedList.builder(
                        itemScrollController: itemScrollControllerAyahList,
                        itemPositionsListener: itemPositionsListenerAyahList,
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
                                    .setData(dropdownAyahKey: ayahsList[index]);
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
                        itemPositionsListener: itemPositionsListenerPagesList,
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
                                    .setData(dropdownAyahKey: pagesList[index]);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Text(
                                  localizedNumber(
                                    context,
                                    getPageNumber(pagesList[index].first) ?? 0,
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
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      builder: (context, state) {
        if (state.isAyahByAyah) {
          // List of ayahs scrollable

          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollControllerAyahByAyah,
            itemCount: ayahsList.length,
            padding: const EdgeInsets.only(top: 30, bottom: 100),
            itemBuilder: (context, index) {
              final ayahKey = ayahsList[index];
              final ayahKeySplit = ayahKey.split(":");
              int surahNumber = ayahKeySplit.first.toInt();

              int ayahNumber = ayahKeySplit.last.toInt();
              String surahEndAyahKey =
                  surahNumber == ayahsList.last.split(":").last.toInt()
                      ? ayahsList.last
                      : getEndAyahKeyFromSurahNumber(surahNumber);
              bool isSurahHeadingIncluded = ayahNumber == 1;
              int pageNumber = getPageNumber(ayahKey) ?? 0;
              PageInfoModel? pageInfo;
              try {
                pageInfo = PageInfoModel.fromMap(
                  quranPagesInfo[pageNumber - 1],
                );
              } catch (_) {}

              bool isPageStart = pageInfo?.start == ayahNumber || index == 0;

              final TranslationWithWordByWord? translationData =
                  getTranslationFromCache(ayahKey);

              return Column(
                children: [
                  if (isSurahHeadingIncluded)
                    SurahInfoHeaderBuilder(
                      headerInfoModel: SurahHeaderInfoModel(
                        SurahInfoModel.fromMap(metaDataSurah["$surahNumber"]!),
                        ayahKey,
                        surahEndAyahKey,
                      ),
                    ),
                  if (isPageStart) pageLabelOfQuran(context, l10n, pageNumber),
                  translationData != null
                      ? getAyahByAyahCard(
                        ayahKey: ayahKey,
                        context: context,
                        translationListWithInfo:
                            translationData.translationList,
                        wordByWord: translationData.wordByWord ?? [],
                      )
                      : FutureBuilder(
                        future: getTranslationWithWordByWord(ayahKey),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.connectionState !=
                              ConnectionState.done) {
                            return const SizedBox(height: 250);
                          }
                          return getAyahByAyahCard(
                            ayahKey: ayahKey,
                            context: context,
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
          // Reading mode
          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollControllerReadingMode,
            itemCount: pagesList.length,
            padding: const EdgeInsets.only(top: 30, bottom: 100),
            itemBuilder: (context, index) {
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
              return VisibilityDetector(
                key: Key(pageNumber.toString()),
                onVisibilityChanged: (info) {
                  if (!context.mounted) {
                    return;
                  }
                  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
                    metaDataSurah[surahNumber.toString()]!,
                  );

                  context.read<AyahByAyahInScrollInfoCubit>().setData(
                    surahInfoModel: surahInfoModel,
                    dropdownAyahKey: currentPage,
                  );
                },
                child: Column(
                  children: [
                    if (firstAyah.split(":").last == "1" || index == 0)
                      SurahInfoHeaderBuilder(
                        headerInfoModel: SurahHeaderInfoModel(
                          SurahInfoModel.fromMap(
                            metaDataSurah[surahNumber.toString()]!,
                          ),
                          firstAyah,
                          surahEndAyahKey ?? currentPage.last,
                        ),
                      ),
                    pageLabelOfQuran(context, l10n, pageNumber),
                    BlocBuilder<QuranViewCubit, QuranViewState>(
                      builder:
                          (context, quranViewState) => QuranPagesRenderer(
                            ayahsKey: currentPage,
                            quranScriptType: quranViewState.quranScriptType,
                            baseStyle: TextStyle(
                              fontSize: quranViewState.fontSize,
                            ),
                          ),
                    ),
                  ],
                ),
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
          style: IconButton.styleFrom(
            backgroundColor: themeState.primaryShade100,
            foregroundColor: themeState.primary,
          ),
          onPressed: () {
            final lastPosition = state.dropdownAyahKey;

            context.read<AyahByAyahInScrollInfoCubit>().setData(
              dropdownAyahKey: null,
              isAyahByAyah: !state.isAyahByAyah,
              clearDropdownAyahKey: true,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (lastPosition is String) {
                final index = pagesList.firstWhere(
                  (element) => element.contains(lastPosition),
                );
                scrollToAyah(index);
              }
              if (lastPosition is List<String>) {
                scrollToAyah(lastPosition.first);
              }
            });
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
      width: 90,
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
        builder: (context, ayahScrollInfoState) {
          List<DropdownMenuItem> dropdownItems =
              ayahScrollInfoState.isAyahByAyah
                  ? List.generate(ayahsList.length, (index) {
                    List<String> ayahData = ayahsList[index].toString().split(
                      ":",
                    );
                    return DropdownMenuItem(
                      value: ayahsList[index],
                      child: Center(
                        child: Text(
                          "${localizedNumber(context, ayahData.first.toInt())}:${localizedNumber(context, ayahData.last.toInt())}",
                        ),
                      ),
                    );
                  })
                  : List.generate(pagesList.length, (index) {
                    return DropdownMenuItem(
                      value: pagesList[index],
                      child: Center(
                        child: Text(
                          "${AppLocalizations.of(context).page} - ${localizedNumber(context, getPageNumber(pagesList[index].first))}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  });
          final value = ayahScrollInfoState.dropdownAyahKey;
          final isValidValue = dropdownItems.any((item) => item.value == value);
          return DropdownButton(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            isExpanded: false,
            underline: const SizedBox(),
            value: isValidValue ? value : null,

            items: dropdownItems,

            onChanged: (value) async {
              scrollToAyah(value);
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                context.read<AyahByAyahInScrollInfoCubit>().setData(
                  dropdownAyahKey: value,
                );
              });
            },
          );
        },
      ),
    );
  }

  IconButton getSettingsButton(ThemeState themeState, BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
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

  Container pageLabelOfQuran(
    BuildContext context,
    AppLocalizations l10n,
    int pageNumber,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 30,
      color: context.read<ThemeCubit>().state.primaryShade300,
      alignment: Alignment.center,
      child: Text("${l10n.page} - ${localizedNumber(context, pageNumber)}"),
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
