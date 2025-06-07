import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/get_ayah_card_for_share_as_image.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

import "../../../main.dart";
import "../../screen/surah_list_view/model/surah_info_model.dart";

void showShareBottomDialog(
  BuildContext context,
  String ayahKey,
  SurahInfoModel surahInfoModel,
  QuranScriptType quranScriptType,
  String translation,
  Map footNote,
) {
  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah[ayahKey.split(":").first],
  );

  int surahNumber = ayahKey.split(":").first.toInt();
  int ayahNumber = ayahKey.split(":").last.toInt();

  List quranScriptWord =
      tajweedScript[surahNumber.toString()][ayahNumber.toString()];
  if (quranScriptType == QuranScriptType.tajweed) {}
  String footNoteAsString = "\n";
  if (footNote.isNotEmpty) {
    footNote.forEach((key, value) {
      footNoteAsString += "$key. $value\n";
    });
  }
  ButtonStyle textButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(),
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
  );
  Color color =
      Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade100
          : Colors.grey.shade800;
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(roundedRadius + 5),
        topRight: Radius.circular(roundedRadius + 5),
      ),
    ),
    context: context,
    builder: (context) {
      return Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(roundedRadius + 5),
                topRight: Radius.circular(roundedRadius + 5),
              ),
              color: AppColors.primaryShade100,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FluentIcons.share_24_regular),
                      Gap(20),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          TextButton(
            style: textButtonStyle,
            onPressed: () async {
              await SharePlus.instance.share(
                ShareParams(
                  text:
                      "${surahInfoModel.nameSimple} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""}",
                ),
              );
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.string(
                  """<?xml version="1.0" ?> <svg fill="#000000" width="800px" height="800px" viewBox="0 0 35 35" data-name="Layer 2" id="b91c4927-91e2-4552-8f07-45dfbc9402e4" xmlns="http://www.w3.org/2000/svg"><path d="M30.026,18.75H3.5a1.25,1.25,0,0,1,0-2.5H30.026a1.25,1.25,0,0,1,0,2.5Z"/><path d="M16.763,5.455H3.5a1.25,1.25,0,0,1,0-2.5H16.763a1.25,1.25,0,0,1,0,2.5Z"/><path d="M30.026,32.045H3.5a1.25,1.25,0,0,1,0-2.5H30.026a1.25,1.25,0,0,1,0,2.5Z"/></svg>""",
                  height: 15,
                  width: 15,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                const Gap(25),
                Text("Share as Text", style: TextStyle(color: color)),
              ],
            ),
          ),
          TextButton(
            style: textButtonStyle,
            onPressed: () {
              ScreenshotController screenshotController =
                  ScreenshotController();
              screenshotController
                  .captureFromWidget(
                    getAyahCardForShareAsImage(
                      context,
                      Hive.box(
                        "user",
                      ).get("show_mac_os_window_like_icon", defaultValue: true),
                      ayahKey,
                      surahInfoModel,
                      quranScriptType,
                      getPlainTextAyahFromTajweedWords(
                        List<String>.from(quranScriptWord),
                      ),
                      translation,
                      footNote,
                    ),
                    context: context,
                  )
                  .then((imageBinary) {
                    SharePlus.instance.share(
                      ShareParams(
                        files: [
                          XFile.fromData(imageBinary, mimeType: "image/png"),
                        ],
                      ),
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FluentIcons.image_24_regular, color: color),
                const Gap(20),
                Text("Share as Image", style: TextStyle(color: color)),
              ],
            ),
          ),
          TextButton(
            style: textButtonStyle,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.string(
                  """<?xml version="1.0" encoding="utf-8"?> <svg fill="#000000" width="800px" height="800px" viewBox="0 0 36 36" version="1.1"  preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <title>add-text-line</title> <path class="clr-i-outline clr-i-outline-path-1" d="M31,21H13a1,1,0,0,0,0,2H31a1,1,0,0,0,0-2Z"></path><path class="clr-i-outline clr-i-outline-path-2" d="M12,16a1,1,0,0,0,1,1H31a1,1,0,0,0,0-2H13A1,1,0,0,0,12,16Z"></path><path class="clr-i-outline clr-i-outline-path-3" d="M27,27H13a1,1,0,0,0,0,2H27a1,1,0,0,0,0-2Z"></path><path class="clr-i-outline clr-i-outline-path-4" d="M15.89,9a1,1,0,0,0-1-1H10V3.21a1,1,0,0,0-2,0V8H2.89a1,1,0,0,0,0,2H8v5.21a1,1,0,0,0,2,0V10h4.89A1,1,0,0,0,15.89,9Z"></path> <rect x="0" y="0" width="36" height="36" fill-opacity="0"/> </svg>""",
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade100
                        : Colors.grey.shade800,
                    BlendMode.srcIn,
                  ),
                ),
                const Gap(20),
                Text("Share with Tafsir", style: TextStyle(color: color)),
              ],
            ),
          ),
          TextButton(
            style: textButtonStyle,
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FluentIcons.share_multiple_24_regular, color: color),
                const Gap(20),
                Text("Share Multiple Ayah", style: TextStyle(color: color)),
              ],
            ),
          ),
        ],
      );
    },
  );
}
