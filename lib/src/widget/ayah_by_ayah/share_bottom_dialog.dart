import "package:al_quran_v3/src/functions/get_tafsir_from_db.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/get_ayah_card_for_share_as_image.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart";
import "package:clipboard/clipboard.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

import "../../../main.dart";
import "../../screen/settings/cubit/quran_script_type_cubit.dart";
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

  List quranScriptWord = [];
  switch (context.read<QuranScriptTypeCubit>().state) {
    case QuranScriptType.tajweed:
      {
        quranScriptWord =
            tajweedScript[surahNumber.toString()][ayahNumber.toString()];
      }
    case QuranScriptType.uthmani:
      {
        quranScriptWord =
            uthmaniScript[surahNumber.toString()][ayahNumber.toString()];
      }
    case QuranScriptType.indopak:
      {
        quranScriptWord =
            indopakScript[surahNumber.toString()][ayahNumber.toString()];
      }
  }

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
    alignment: Alignment.centerLeft,
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: textButtonStyle,
                  onPressed: () async {
                    await SharePlus.instance.share(
                      ShareParams(
                        text:
                            "${surahInfoModel.nameSimple} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""}",
                      ),
                    );
                  },
                  icon: Icon(FluentIcons.text_field_24_regular, color: color),
                  label: Text("Share as Text", style: TextStyle(color: color)),
                ),
              ),
              IconButton(
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryShade200,
                ),
                onPressed: () async {
                  await FlutterClipboard.copy(
                    "${surahInfoModel.nameSimple} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""}",
                  );
                  await Fluttertoast.showToast(msg: "Copied with Tafsir");
                  Navigator.pop(context);
                },
                icon: const Icon(FluentIcons.copy_24_regular),
              ),
              const Gap(10),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: textButtonStyle,
              onPressed: () {
                ScreenshotController screenshotController =
                    ScreenshotController();
                screenshotController
                    .captureFromWidget(
                      getAyahCardForShareAsImage(
                        context,
                        Hive.box("user").get(
                          "show_mac_os_window_like_icon",
                          defaultValue: true,
                        ),
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
                    .then((imageBinary) async {
                      await SharePlus.instance.share(
                        ShareParams(
                          files: [
                            XFile.fromData(imageBinary, mimeType: "image/png"),
                          ],
                        ),
                      );
                      Navigator.pop(context);
                    });
              },
              icon: Icon(FluentIcons.image_24_regular, color: color),
              label: Text("Share as Image", style: TextStyle(color: color)),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: textButtonStyle,
                  onPressed: () async {
                    String? tafsir = await getTafsirFromDb(
                      ayahKey,
                      returnAyahKeyIfLinked: false,
                    );
                    await SharePlus.instance.share(
                      ShareParams(
                        text:
                            "${surahInfoModel.nameSimple} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""} \nTafsir:\n${tafsir ?? "Not found"}",
                      ),
                    );

                    Navigator.pop(context);
                  },
                  icon: Icon(FluentIcons.book_24_regular, color: color),
                  label: Text(
                    "Share with Tafsir",
                    style: TextStyle(color: color),
                  ),
                ),
              ),
              IconButton(
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryShade200,
                ),
                onPressed: () async {
                  String? tafsir = await getTafsirFromDb(
                    ayahKey,
                    returnAyahKeyIfLinked: false,
                  );
                  await FlutterClipboard.copy(
                    "${surahInfoModel.nameSimple} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""} \nTafsir:\n${tafsir ?? "Not found"}",
                  );
                  Fluttertoast.showToast(msg: "Copied with Tafsir");
                  Navigator.pop(context);
                },
                icon: const Icon(FluentIcons.copy_24_regular),
              ),
              const Gap(10),
            ],
          ),
          const Gap(20),
        ],
      );
    },
  );
}
