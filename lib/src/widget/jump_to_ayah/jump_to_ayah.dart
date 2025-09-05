import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/utils/filter/filter_surah.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/get_word_list_of_ayah.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/screen/tafsir_view/tafsir_view.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";
import "package:share_plus/share_plus.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "../ayah_by_ayah/get_ayah_card_for_share_as_image.dart";
import "../ayah_by_ayah/share_bottom_dialog.dart";
import "../quran_script/script_view/tajweed_view/tajweed_text_preser.dart";

class JumpToAyahView extends StatefulWidget {
  final String? initAyahKey;
  final bool isAudioPlayer;
  final bool? selectMultipleAndShare;
  final Function(String ayahKey)? onPlaySelected;
  final Function(String ayahKey)? onSelectAyah;

  const JumpToAyahView({
    super.key,
    this.initAyahKey,
    required this.isAudioPlayer,
    this.onPlaySelected,
    this.selectMultipleAndShare,
    this.onSelectAyah,
  });

  @override
  State<JumpToAyahView> createState() => _JumpToAyahViewState();
}

class _JumpToAyahViewState extends State<JumpToAyahView> {
  late int? surahNumber = int.tryParse(widget.initAyahKey?.split(":")[0] ?? "");
  late int? ayahNumber = int.tryParse(widget.initAyahKey?.split(":")[1] ?? "");
  ScrollController surahScrollController = ScrollController();
  ScrollController ayahScrollController = ScrollController();
  TextEditingController surahSearchController = TextEditingController();
  List<String> selectedAyahKeys = [];
  List<SurahInfoModel> surahInfoList =
      metaDataSurah.values.map((e) => SurahInfoModel.fromMap(e)).toList();

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    List<SurahInfoModel> filteredSurah = getFilteredSurah(
      context,
      surahSearchController.text.trim(),
    );
    AppLocalizations l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.grey.shade100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(roundedRadius),
                topRight: Radius.circular(roundedRadius),
              ),
              color: themeState.primaryShade100,
            ),
            width: double.infinity,
            height: 50,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    widget.selectMultipleAndShare == true
                        ? l10n.shareSelectAyahs
                        : l10n.jumpToAyah,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),

          if (widget.selectMultipleAndShare == true) const Gap(8),
          if (widget.selectMultipleAndShare == true)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsGeometry.only(left: 10),
              child: Text("Selected: ${selectedAyahKeys.length}"),
            ),
          if (widget.selectMultipleAndShare == true) const Gap(5),

          if (widget.selectMultipleAndShare == true)
            Stack(
              children: [
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(roundedRadius),
                    color: themeState.primaryShade100,
                  ),

                  child:
                      selectedAyahKeys.isEmpty
                          ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(l10n.selectionEmpty),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedAyahKeys.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(
                                  "${selectedAyahKeys[index]}${selectedAyahKeys.length == index + 1 ? "" : ", "}",
                                ),
                              );
                            },
                          ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40,
                    child: IconButton(
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        selectedAyahKeys.clear();
                        setState(() {});
                      },
                      icon: Icon(Icons.close, color: themeState.primary),
                    ),
                  ),
                ),
              ],
            ),

          if (widget.selectMultipleAndShare == true) const Divider(),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width *
                      (widget.selectMultipleAndShare == true ? 0.6 : 0.65),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: SearchBar(
                          controller: surahSearchController,
                          elevation: WidgetStateProperty.all<double?>(0),
                          backgroundColor: WidgetStateProperty.all<Color?>(
                            themeState.primaryShade100,
                          ),
                          leading: const Icon(FluentIcons.search_24_filled),
                          hintText: l10n.searchForASurah,

                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          controller: surahScrollController,
                          interactive: true,
                          radius: Radius.circular(roundedRadius),
                          thickness: 10,
                          child: ListView.builder(
                            controller: surahScrollController,
                            itemCount: filteredSurah.length,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              SurahInfoModel surah = filteredSurah[index];
                              return SizedBox(
                                height: surah.id == surahNumber ? 40 : 30,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    alignment: Alignment.centerLeft,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        roundedRadius,
                                      ),
                                    ),
                                    backgroundColor:
                                        surah.id == surahNumber
                                            ? themeState.primary.withValues(
                                              alpha: 0.2,
                                            )
                                            : Colors.transparent,
                                    foregroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                    padding: const EdgeInsets.only(left: 10),
                                  ),

                                  onPressed: () {
                                    setState(() {
                                      surahNumber = surah.id;
                                      ayahNumber = 1;
                                    });
                                  },
                                  child: Text(
                                    "${localizedNumber(context, surah.id)}. ${getSurahName(context, surah.id)}",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width *
                      (widget.selectMultipleAndShare == true ? 0.3 : 0.2),
                  child: Scrollbar(
                    controller: ayahScrollController,
                    interactive: true,
                    radius: Radius.circular(roundedRadius),
                    thickness: 10,
                    child: ListView.builder(
                      controller: ayahScrollController,
                      padding: const EdgeInsets.all(10),

                      itemCount:
                          surahNumber != null
                              ? SurahInfoModel.fromMap(
                                metaDataSurah[surahNumber.toString()],
                              ).versesCount
                              : 0,
                      itemBuilder: (context, index) {
                        return Container(
                          height:
                              (index == (ayahNumber ?? 0) - 1) &&
                                      (widget.selectMultipleAndShare != true)
                                  ? 40
                                  : 30,
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,

                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  roundedRadius,
                                ),
                              ),
                              backgroundColor:
                                  (index == (ayahNumber ?? 0) - 1) &&
                                          (widget.selectMultipleAndShare !=
                                              true)
                                      ? themeState.primaryShade300
                                      : Colors.transparent,
                              foregroundColor:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                            onPressed: () {
                              if (widget.selectMultipleAndShare == true) {
                                if (selectedAyahKeys.contains(
                                  "$surahNumber:${index + 1}",
                                )) {
                                  selectedAyahKeys.remove(
                                    "$surahNumber:${index + 1}",
                                  );
                                } else {
                                  selectedAyahKeys.add(
                                    "$surahNumber:${index + 1}",
                                  );
                                }
                              } else {
                                ayahNumber = index + 1;
                              }
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (widget.selectMultipleAndShare == true)
                                  selectedAyahKeys.contains(
                                        "$surahNumber:${index + 1}",
                                      )
                                      ? const Icon(Icons.check_box_rounded)
                                      : const Icon(
                                        Icons.check_box_outline_blank_rounded,
                                      ),
                                if (widget.selectMultipleAndShare == true)
                                  const Gap(20),
                                Text(localizedNumber(context, index + 1)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.selectMultipleAndShare == true)
            Row(
              children: [
                const Gap(5),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      List<XFile> files = [];
                      List<String> fileNames = [];
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SpinKitFoldingCube(
                                        color: themeState.primary,
                                      ),
                                      const Gap(20),
                                      Text(
                                        l10n.generatingImagePleaseWait,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      );

                      for (String ayahKey in selectedAyahKeys) {
                        SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
                          metaDataSurah[ayahKey.split(":").first],
                        );
                        Map translationMap =
                            QuranTranslationFunction.getTranslation(ayahKey) ??
                            {};
                        String translation =
                            translationMap["t"] ?? "Translation Not Found";
                        translation = translation.replaceAll(">", "> ");
                        Map footNote = translationMap["f"] ?? {};
                        String footNoteAsString = "\n";
                        if (footNote.isNotEmpty) {
                          footNote.forEach((key, value) {
                            footNoteAsString += "$key. $value\n";
                          });
                        }
                        List quranScriptWord = getWordListOfAyah(
                          context.read<QuranViewCubit>().state.quranScriptType,
                          ayahKey.split(":").first,
                          ayahKey.split(":").last,
                        );

                        TextStyle scriptTextStyle = TextStyle(
                          fontSize:
                              context.read<QuranViewCubit>().state.fontSize,
                          height:
                              context.read<QuranViewCubit>().state.lineHeight,
                        );

                        Brightness brightness = Theme.of(context).brightness;

                        var imageData = await screenshotController
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
                                    context
                                        .read<QuranViewCubit>()
                                        .state
                                        .quranScriptType,
                                    getPlainTextAyahFromTajweedWords(
                                      List<String>.from(quranScriptWord),
                                    ),
                                    translation,
                                    footNote,
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
                                    translation +
                                    footNoteAsString,
                              ),
                              delay: const Duration(milliseconds: 50),
                            );
                        files.add(
                          XFile.fromData(imageData, mimeType: "image/png"),
                        );
                        fileNames.add(
                          "${getSurahName(context, surahInfoModel.id)} - $ayahKey.png",
                        );
                      }
                      Navigator.pop(context);
                      await SharePlus.instance.share(
                        ShareParams(
                          files: files,
                          fileNameOverrides: fileNames,
                          downloadFallbackEnabled: false,
                          mailToFallbackEnabled: false,
                        ),
                      );
                    },
                    icon: const Icon(FluentIcons.image_24_regular),
                    label: Text(l10n.asImage),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      String text = "";
                      for (String ayahKey in selectedAyahKeys) {
                        SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
                          metaDataSurah[ayahKey.split(":").first],
                        );
                        Map translationMap =
                            QuranTranslationFunction.getTranslation(ayahKey) ??
                            {};
                        String translation =
                            translationMap["t"] ?? "Translation Not Found";
                        translation = translation.replaceAll(">", "> ");
                        Map footNote = translationMap["f"] ?? {};
                        String footNoteAsString = "\n";
                        if (footNote.isNotEmpty) {
                          footNote.forEach((key, value) {
                            footNoteAsString += "$key. $value\n";
                          });
                        }
                        List quranScriptWord = getWordListOfAyah(
                          context.read<QuranViewCubit>().state.quranScriptType,
                          ayahKey.split(":").first,
                          ayahKey.split(":").last,
                        );
                        text +=
                            "${getSurahName(context, surahInfoModel.id)} - $ayahKey\n\n${getPlainTextAyahFromTajweedWords(List<String>.from(quranScriptWord))}\n\nTranslation:\n$translation\n\n${footNote.isNotEmpty ? footNoteAsString : ""}\n";
                      }

                      await SharePlus.instance.share(ShareParams(text: text));
                      Navigator.pop(context);
                    },
                    icon: const Icon(FluentIcons.textbox_16_regular),
                    label: Text(l10n.asText),
                  ),
                ),
                const Gap(5),
              ],
            ),
          if (widget.isAudioPlayer)
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: 5,
              ),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onPlaySelected!("$surahNumber:$ayahNumber");
                },
                label: Text(l10n.playFromSelectedAyah),
                icon: const Icon(Icons.play_circle_outline_rounded, size: 26),
              ),
            ),
          if (!widget.isAudioPlayer && widget.selectMultipleAndShare != true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (widget.onSelectAyah == null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (surahNumber != null && ayahNumber != null) {
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => TafsirView(
                                      ayahKey: "$surahNumber:$ayahNumber",
                                    ),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: l10n.pleaseSelectOne);
                          }
                        },
                        child: Text(l10n.toTafsir),
                      ),
                    ),
                  if (widget.onSelectAyah == null) const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (surahNumber != null && ayahNumber != null) {
                          Navigator.pop(context);
                          if (widget.onSelectAyah != null) {
                            widget.onSelectAyah!("$surahNumber:$ayahNumber");
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => QuranScriptView(
                                      startKey: "$surahNumber:1",
                                      endKey: getEndAyahKeyFromSurahNumber(
                                        surahNumber!,
                                      ),
                                      toScrollKey: "$surahNumber:$ayahNumber",
                                    ),
                              ),
                            );
                          }
                        } else {
                          Fluttertoast.showToast(msg: l10n.pleaseSelectOne);
                        }
                      },
                      child: Text(
                        widget.onSelectAyah != null
                            ? l10n.selectAyah
                            : l10n.toAyah,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
