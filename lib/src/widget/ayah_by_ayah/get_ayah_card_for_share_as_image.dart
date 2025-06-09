import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";

import "../quran_script/model/script_info.dart";
import "../quran_script/script_processor.dart";

Widget getAyahCardForShareAsImage(
  BuildContext context,
  bool showMacOsWindowLikeIcon,
  String ayahKey,
  SurahInfoModel surahInfoModel,
  QuranScriptType quranScriptType,
  String arabic,
  String translation,
  Map footNote,
) {
  bool keepFootNote = Hive.box(
    "user",
  ).get("keep_foot_note_on_share", defaultValue: true);

  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(roundedRadius),
      border: Border.all(color: AppColors.primary),
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.grey.shade100,
    ),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMacOsWindowLikeIcon)
          Row(
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
          "${surahInfoModel.nameSimple} - $ayahKey",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Gap(20),
        Align(
          alignment: Alignment.centerRight,
          child: ScriptProcessor(
            scriptInfo: ScriptInfo(
              surahNumber: ayahKey.split(":").first.toInt(),
              ayahNumber: ayahKey.split(":").last.toInt(),
              quranScriptType: quranScriptType,
              forImage: true,
            ),
          ),
        ),
        const Gap(15),
        const Text(
          "Translation:",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const Gap(10),
        Text(translation),
        keepFootNote ? const Gap(10) : const Gap(0),
        if (keepFootNote)
          ...List.generate(footNote.length, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${footNote.keys.toList()[index]}."),
                Html(data: footNote.values.toList()[index]),
                const Gap(5),
              ],
            );
          }),
      ],
    ),
  );
}
