import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/get_localized_ayah_key.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:screenshot/screenshot.dart";

import "../quran_script/model/script_info.dart";
import "../quran_script/script_processor.dart";

ScreenshotController screenshotController = ScreenshotController();

Widget getAyahCardForShareAsImage(
  BuildContext context,
  bool showMacOsWindowLikeIcon,
  String ayahKey,
  SurahInfoModel surahInfoModel,
  QuranScriptType quranScriptType,
  String arabic,
  String translation,
  Map footNote,
  TextStyle scriptTextStyle,
  Brightness brightness,
  ThemeState themeState,
) {
  AppLocalizations l10n = AppLocalizations.of(context);

  bool keepFootNote = Hive.box(
    "user",
  ).get("keep_foot_note_on_share", defaultValue: true);

  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(roundedRadius),
      border: Border.all(color: themeState.primary),
      color:
          brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.grey.shade100,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMacOsWindowLikeIcon)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 5,
                width: 5,
              ),
              const Gap(7),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 5,
                width: 5,
              ),
              const Gap(7),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 5,
                width: 5,
              ),
            ],
          ),
        if (showMacOsWindowLikeIcon) const Gap(10),
        Text(
          "${getSurahName(null, surahInfoModel.id)} - ${getAyahLocalized(context, ayahKey)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Gap(20),
        Align(
          alignment: Alignment.center,
          child: ScriptProcessor(
            scriptInfo: ScriptInfo(
              surahNumber: ayahKey.split(":").first.toInt(),
              ayahNumber: ayahKey.split(":").last.toInt(),
              quranScriptType: quranScriptType,

              textStyle: scriptTextStyle,
              forImage: true,
            ),
            themeState: themeState,
          ),
        ),
        const Gap(15),
        Text(
          l10n.translation,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        MediaQuery(
          data: MediaQuery.of(context),
          child: Directionality(
            textDirection: Directionality.of(context),
            child: Html(data: translation),
          ),
        ),
        keepFootNote ? const Gap(10) : const Gap(0),
        if (keepFootNote)
          ...List.generate(footNote.length, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index + 1}.",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                MediaQuery(
                  data: MediaQuery.of(context),
                  child: Directionality(
                    textDirection: Directionality.of(context),
                    child: Html(data: footNote.values.toList()[index]),
                  ),
                ),
                const Gap(5),
              ],
            );
          }),
      ],
    ),
  );
}
