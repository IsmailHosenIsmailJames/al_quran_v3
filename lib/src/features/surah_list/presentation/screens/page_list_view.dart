import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/utils/basic_functions.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/navigation_info_model.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/widgets/get_surah_index_widget.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";

class PageListView extends StatelessWidget {
  final List<PageInfoModel> pageInfoList;

  const PageListView({super.key, required this.pageInfoList});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    Brightness brightness = Theme.brightnessOf(context);
    Color textColor = brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    final quranViewState = context.read<QuranViewCubit>().state;
    QuranScriptType quranScriptType = quranViewState.quranScriptType;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 120),
      itemCount: pageInfoList.length,
      itemBuilder: (context, index) {
        PageInfoModel pageInfo = pageInfoList[index];
        final ayahKey = convertAyahNumberToKey(pageInfo.start);

        int surahNumber = ayahKey!.split(":").first.toInt();
        return Padding(
          padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              side: BorderSide(
                color: context.read<ThemeCubit>().state.primaryShade200,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuranScriptView(
                    startKey: convertAyahNumberToKey(
                      pageInfoList[index].start,
                    )!,
                    endKey: convertAyahNumberToKey(pageInfoList[index].end)!,
                    currentIndex: index,
                    getNavigationInfo: (i) {
                      return NavigationInfoModel(
                        previousStartKey: i > 0
                            ? convertAyahNumberToKey(pageInfoList[i - 1].start)
                            : null,
                        previousEndKey: i > 0
                            ? convertAyahNumberToKey(pageInfoList[i - 1].end)
                            : null,
                        nextStartKey: i < pageInfoList.length - 1
                            ? convertAyahNumberToKey(pageInfoList[i + 1].start)
                            : null,
                        nextEndKey: i < pageInfoList.length - 1
                            ? convertAyahNumberToKey(pageInfoList[i + 1].end)
                            : null,
                      );
                    },
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
              height: 60,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.page,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          const Gap(10),
                          getIndexNumberWidget(
                            context,
                            index + 1,
                            height: 25,
                            width: 25,
                            textColor: textColor,
                          ),
                        ],
                      ),
                      const Gap(2),
                      Text(
                        appLocalizations.surahAyah(
                          "${getSurahName(context, surahNumber)} -",
                          "${localizedNumber(context, surahNumber)}:${localizedNumber(context, surahNumber)}",
                        ),
                        style: TextStyle(
                          color: brightness == Brightness.light
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerRight,
                      fit: BoxFit.scaleDown,
                      child: ScriptProcessor(
                        scriptInfo: ScriptInfo(
                          textStyle: const TextStyle(fontSize: 20),
                          surahNumber: int.parse(ayahKey.split(":")[0]),
                          ayahNumber: int.parse(ayahKey.split(":")[1]),
                          quranScriptType: quranScriptType,
                          limitWord: 3,
                          skipWordTap: true,
                        ),
                        themeState: context.read<ThemeCubit>().state,
                        tajweedColorEnable:
                            quranViewState.quranScriptType ==
                                QuranScriptType.uthmani
                            ? quranViewState.useTajweedOnUthmani
                            : quranViewState.useTajweedOnIndopak,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
