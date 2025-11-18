import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";
import "package:al_quran_v3/src/screen/quran_script_view/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/screen/quran_script_view/model/surah_header_info.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/page_info_model.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/gen_ayahs_key.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/get_page_number.dart";
import "package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/quran_script/pages_render/pages_render.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scrollable_positioned_list/scrollable_positioned_list.dart";

class QuranScriptViewExperimental extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;
  const QuranScriptViewExperimental({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<QuranScriptViewExperimental> createState() =>
      _QuranScriptViewExperimentalState();
}

class _QuranScriptViewExperimentalState
    extends State<QuranScriptViewExperimental> {
  ItemScrollController? itemScrollControllerAyahByAyah = ItemScrollController();
  ItemPositionsListener? itemPositionsListenerAyahByAyah =
      ItemPositionsListener.create();
  ScrollOffsetController? scrollOffsetControllerAyahByAyah =
      ScrollOffsetController();
  ScrollOffsetListener? scrollOffsetListenerAyahByAyah =
      ScrollOffsetListener.create();

  ItemScrollController? itemScrollControllerReadingMode =
      ItemScrollController();
  ItemPositionsListener? itemPositionsListenerReadingMode =
      ItemPositionsListener.create();
  ScrollOffsetController? scrollOffsetControllerReadingMode =
      ScrollOffsetController();
  ScrollOffsetListener? scrollOffsetListenerReadingMode =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    List<String> ayahsList = getListOfAyahKeyExperimental(
      startAyahKey: widget.startKey,
      endAyahKey: widget.endKey,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Experimental Quran View")),
      body: BlocBuilder<
        AyahByAyahInScrollInfoCubit,
        AyahByAyahInScrollInfoState
      >(
        builder: (context, state) {
          if (state.isAyahByAyah) {
            // List of ayahs scrollable

            return ScrollablePositionedList.builder(
              itemScrollController: itemScrollControllerAyahByAyah,
              scrollOffsetController: scrollOffsetControllerAyahByAyah,
              itemPositionsListener: itemPositionsListenerAyahByAyah,
              scrollOffsetListener: scrollOffsetListenerAyahByAyah,
              itemCount: ayahsList.length,
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
                          SurahInfoModel.fromMap(
                            metaDataSurah["$surahNumber"]!,
                          ),
                          ayahKey,
                          surahEndAyahKey,
                        ),
                      ),
                    if (isPageStart)
                      pageLabelOfQuran(context, l10n, pageNumber),
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
            // extract pages
            List<List<String>> pagesList = [];
            List<String> parts = [];
            int lastPage = getPageNumber(ayahsList.first) ?? 0;

            for (String ayahKey in ayahsList) {
              int page = getPageNumber(ayahKey) ?? 0;
              if (lastPage == page) {
                if (ayahKey ==
                    getEndAyahKeyFromSurahNumber(
                      ayahKey.split(":").first.toInt(),
                    )) {
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

            return ScrollablePositionedList.builder(
              itemScrollController: itemScrollControllerReadingMode,
              scrollOffsetController: scrollOffsetControllerReadingMode,
              itemPositionsListener: itemPositionsListenerReadingMode,
              scrollOffsetListener: scrollOffsetListenerReadingMode,
              itemCount: pagesList.length,
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
                return Column(
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
                );
              },
            );
          }
        },
      ),
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
}
