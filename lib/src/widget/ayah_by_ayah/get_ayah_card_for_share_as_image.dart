import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:gap/gap.dart";

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
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(roundedRadius),
      border: Border.all(color: AppColors.primary),
    ),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMacOsWindowLikeIcon)
          const Row(
            children: [
              CircleAvatar(backgroundColor: Colors.red, radius: 5),
              Gap(7),
              CircleAvatar(backgroundColor: Colors.yellow, radius: 5),
              Gap(7),
              CircleAvatar(backgroundColor: Colors.green, radius: 5),
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
        const Gap(10),
        ...List.generate(footNote.length, (index) {
          return Column(
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
