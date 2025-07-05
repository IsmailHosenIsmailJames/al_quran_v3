import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/juz_info_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/components/get_surah_index_widget.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_processor.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/controller/theme_cubit.dart";

class JuzListView extends StatelessWidget {
  final List<JuzInfoModel> juzInfoList;
  const JuzListView({super.key, required this.juzInfoList});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    Brightness brightness = Theme.of(context).brightness;
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;
    QuranScriptType quranScriptType =
        context.read<QuranViewCubit>().state.quranScriptType;
    ScrollController scrollController = ScrollController();

    return Scrollbar(
      controller: scrollController,
      radius: Radius.circular(roundedRadius),
      thickness: 13,
      interactive: true,

      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        controller: scrollController,
        itemCount: juzInfoList.length,
        itemBuilder: (context, index) {
          JuzInfoModel current = juzInfoList[index];
          String firstKey = current.firstVerseKey;

          int surahNumber = firstKey.split(":").first.toInt();
          int ayahNumber = firstKey.split(":").last.toInt();

          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                backgroundColor: context
                    .read<ThemeCubit>()
                    .state
                    .primary
                    .withValues(alpha: 0.05),
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuranScriptView(
                          startKey: juzInfoList[index].firstVerseKey,
                          endKey: juzInfoList[index].lastVerseKey,
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
                              appLocalizations.juz,
                              style: TextStyle(
                                fontSize: 17,
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
                            "${listOfSurahNameEnglish[surahNumber - 1]} -",
                            "${localizedNumber(context, surahNumber)}:${localizedNumber(context, ayahNumber)}",
                          ),
                          style: TextStyle(
                            color:
                                brightness == Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: ScriptProcessor(
                          scriptInfo: ScriptInfo(
                            surahNumber: int.parse(
                              juzInfoList[index].firstVerseKey.split(":")[0],
                            ),
                            ayahNumber: int.parse(
                              juzInfoList[index].firstVerseKey.split(":")[1],
                            ),
                            quranScriptType: quranScriptType,
                            limitWord: 4,
                            skipWordTap: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
