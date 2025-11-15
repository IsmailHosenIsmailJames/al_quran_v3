import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/utils/get_tafsir_from_db.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_script_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/get_ayah_card_for_share_as_image.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_text_preser.dart";
import "package:clipboard/clipboard.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:screenshot/screenshot.dart";
import "package:share_plus/share_plus.dart";

import "../../screen/surah_list_view/model/surah_info_model.dart";
import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

void showShareBottomDialog(
  BuildContext context,
  String ayahKey,

  SurahInfoModel surahInfoModel,
  QuranScriptType quranScriptType,
  List<String> translation,
  List<Map> footNote,
  List<TranslationBookModel?> booksInfo,
) {
  String translationSingleString = "";

  for (int index = 0; index < translation.length; index++) {
    translationSingleString +=
        "\n${translation[index]}\n${booksInfo[index] != null ? "-(${booksInfo[index]?.name ?? ""})\n\n" : ""}";
    if (footNote[index].isNotEmpty) {
      footNote[index].forEach((key, value) {
        translationSingleString += "$key - $value\n";
      });
    }
  }

  ThemeState themeState = context.read<ThemeCubit>().state;
  AppLocalizations l10n = AppLocalizations.of(context);

  SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
    metaDataSurah[ayahKey.split(":").first],
  );

  List quranScriptWord = QuranScriptFunction.getWordListOfAyah(
    context.read<QuranViewCubit>().state.quranScriptType,
    ayahKey.split(":").first,
    ayahKey.split(":").last,
  );

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
              color: themeState.primaryShade100,
            ),
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(FluentIcons.share_24_regular),
                      const Gap(20),
                      Text(
                        l10n.shareButton,
                        style: const TextStyle(
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
                            "${getSurahName(context, surahInfoModel.id)}"
                            " - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\n"
                            "${l10n.translation}:\n$translationSingleString",
                      ),
                    );
                  },
                  icon: Icon(FluentIcons.text_field_24_regular, color: color),
                  label: Text(l10n.shareAsText, style: TextStyle(color: color)),
                ),
              ),
              IconButton(
                color: themeState.primary,
                style: IconButton.styleFrom(
                  backgroundColor: themeState.primaryShade200,
                ),
                onPressed: () async {
                  await FlutterClipboard.copy(
                    "${getSurahName(context, surahInfoModel.id)}"
                    " - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\n"
                    "${l10n.translation}:\n$translationSingleString",
                  );
                  await Fluttertoast.showToast(msg: l10n.copiedWithTafsir);
                  Navigator.pop(context);
                },
                icon: const Icon(FluentIcons.copy_24_regular),
              ),
              const Gap(10),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton.icon(
              style: textButtonStyle,
              onPressed: () async {
                TextStyle scriptTextStyle = TextStyle(
                  fontSize: context.read<QuranViewCubit>().state.fontSize,
                  height: context.read<QuranViewCubit>().state.lineHeight,
                );
                Brightness brightness = Theme.of(context).brightness;
                final imageBinary = await screenshotController
                    .captureFromLongWidget(
                      InheritedTheme.captureAll(
                        context,
                        Material(
                          child: getAyahCardForShareAsImage(
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
                            booksInfo,
                            scriptTextStyle,
                            brightness,
                            themeState,
                          ),
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 500,
                        maxHeight: 3000,
                        minWidth: 300,
                        maxWidth: 500,
                      ),
                      context: context,
                      pixelRatio: getPixelRatioForImage(
                        getPlainTextAyahFromTajweedWords(
                              List<String>.from(quranScriptWord),
                            ) +
                            translationSingleString.toString(),
                      ),
                      delay: const Duration(milliseconds: 200),
                    );
                screenshotController = ScreenshotController();
                await SharePlus.instance.share(
                  ShareParams(
                    files: [XFile.fromData(imageBinary, mimeType: "image/png")],
                    fileNameOverrides: [
                      "${getSurahName(context, surahInfoModel.id)} - $ayahKey.png",
                    ],
                    downloadFallbackEnabled: false,
                    mailToFallbackEnabled: false,
                  ),
                );

                Navigator.pop(context);
              },
              icon: Icon(FluentIcons.image_24_regular, color: color),
              label: Text(l10n.shareAsImage, style: TextStyle(color: color)),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: textButtonStyle,
                  onPressed: () async {
                    List<TafsirBookModel> downloadedTafsir =
                        QuranTafsirFunction.getDownloadedTafsirBooks();
                    TafsirBookModel? selected;
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding: const EdgeInsets.all(10),

                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  <Widget>[
                                    Text(
                                      l10n.selectTafsirBook,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Divider(),
                                  ] +
                                  List.generate(downloadedTafsir.length, (
                                    index,
                                  ) {
                                    return TextButton(
                                      onPressed: () {
                                        selected = downloadedTafsir[index];
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "${index + 1}. ${downloadedTafsir[index].name}",
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        );
                      },
                    );
                    if (selected == null) return;
                    var tafsir =
                        (await QuranTafsirFunction.getTafsirForBook(
                          selected!,
                          ayahKey,
                        ))?.tafsir;

                    String? tafsirString;
                    if (tafsir != null &&
                        getStringFromTafsirFromDb(tafsir) != null) {
                      tafsirString = getStringFromTafsirFromDb(tafsir)!;
                    }
                    await SharePlus.instance.share(
                      ShareParams(
                        text:
                            "${getSurahName(context, surahInfoModel.id)}"
                            " - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\n"
                            " ${l10n.translation}:\n$translationSingleString"
                            " \n${l10n.tafsir}:\n${tafsirString ?? l10n.notFound}",
                      ),
                    );

                    Navigator.pop(context);
                  },
                  icon: Icon(FluentIcons.book_24_regular, color: color),
                  label: Text(
                    l10n.shareWithTafsir,
                    style: TextStyle(color: color),
                  ),
                ),
              ),
              IconButton(
                color: themeState.primary,
                style: IconButton.styleFrom(
                  backgroundColor: themeState.primaryShade200,
                ),
                onPressed: () async {
                  List<TafsirBookModel> downloadedTafsir =
                      QuranTafsirFunction.getDownloadedTafsirBooks();
                  TafsirBookModel? selected;
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(10),

                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                <Widget>[
                                  Text(
                                    l10n.selectTafsirBook,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Divider(),
                                ] +
                                List.generate(downloadedTafsir.length, (index) {
                                  return TextButton(
                                    onPressed: () {
                                      selected = downloadedTafsir[index];
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "${index + 1}. ${downloadedTafsir[index].name}",
                                    ),
                                  );
                                }),
                          ),
                        ),
                      );
                    },
                  );
                  if (selected == null) return;

                  String? tafsir = getStringFromTafsirFromDb(
                    (await QuranTafsirFunction.getTafsirForBook(
                      selected!,
                      ayahKey,
                    ))?.tafsir,
                    returnAyahKeyIfLinked: false,
                  );
                  await FlutterClipboard.copy(
                    "${getSurahName(context, surahInfoModel.id)}"
                    " - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\n"
                    " ${l10n.translation}:\n$translationSingleString"
                    " \n${l10n.tafsir}:\n${tafsir ?? l10n.notFound}",
                  );
                  await Fluttertoast.showToast(msg: l10n.copiedWithTafsir);
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

double? getPixelRatioForImage(String text) {
  double ratio = text.split(" ").length / 50;
  if (ratio < 5) return 5;
  return ratio;
}
