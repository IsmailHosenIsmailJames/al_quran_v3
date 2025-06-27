import "dart:developer";

import "package:al_quran_v3/src/functions/quran_resources/quran_tafsir_function.dart"; // Changed
import "package:al_quran_v3/src/resources/quran_resources/language_code.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TafsirResources extends StatefulWidget {
  // Changed
  const TafsirResources({super.key}); // Changed

  @override
  State<TafsirResources> createState() => _TafsirResourcesState(); // Changed
}

class _TafsirResourcesState extends State<TafsirResources> {
  // Changed
  List<String> expandedLanguageKey = [];
  List<Map> downloadedTafsirs = // Changed
      QuranTafsirFunction.getDownloadedTafsirBooks(); // Changed
  Map? selectedTafsir = QuranTafsirFunction.getTafsirSelection(); // Changed

  Map? downloadingData;

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: List.generate(tafsirInformationWithScore.length, (index) {
          // Changed
          String keyOfMap = tafsirInformationWithScore.keys.elementAt(
            index,
          ); // Changed
          List<Map<String, dynamic>> value =
              tafsirInformationWithScore[keyOfMap]!; // Changed

          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(roundedRadius),
                onTap: () {
                  setState(() {
                    if (expandedLanguageKey.contains(keyOfMap)) {
                      expandedLanguageKey.remove(keyOfMap);
                    } else {
                      expandedLanguageKey.add(keyOfMap);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageNativeNames[keyOfMap] ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        expandedLanguageKey.contains(keyOfMap)
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),

              if (expandedLanguageKey.contains(keyOfMap))
                getBooksList(themeState, value, context),
            ],
          );
        }),
      ),
    );
  }

  Container getBooksList(
    ThemeState themeState,
    List<Map<String, dynamic>> value,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeState.primaryShade100),
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: List.generate(value.length, (index) {
          Map<String, dynamic> data = value[index];
          Map? matchedTafsir = downloadedTafsirs.firstOrNullWhere(
            // Changed
            (element) => element["name"] == data["full_path"],
          );
          bool needDownload = matchedTafsir == null; // Changed
          bool isSelected = false;
          if (!needDownload && selectedTafsir != null) {
            // Changed
            if (selectedTafsir!["name"] == matchedTafsir["name"] && // Changed
                selectedTafsir!["language"] == // Changed
                    matchedTafsir["language"]) {
              // Changed
              isSelected = true;
            }
          }

          bool isDownloading = false;
          if (downloadingData != null) {
            if (downloadingData!["full_path"] == data["full_path"]) {
              isDownloading = true;
            }
          }

          return getBookWidget(
            isSelected,
            needDownload,
            data,
            context,
            isDownloading,
          );
        }),
      ),
    );
  }

  InkWell getBookWidget(
    bool isSelected,
    bool needDownload,
    Map<String, dynamic> data,
    BuildContext context,
    bool isDownloading,
  ) {
    return InkWell(
      onTap: () async {
        if (!isSelected && !needDownload) {
          QuranTafsirFunction.setTafsirSelection(
            // Changed
            data["full_path"],
            data["language"],
          );
          selectedTafsir = // Changed
              QuranTafsirFunction.getTafsirSelection(); // Changed
          setState(() {});
        } else if (isSelected) {
          log("Already Selected");
        } else {
          setState(() {
            downloadingData = data;
          });
          log(downloadingData.toString(), name: "downloadingData");
          await QuranTafsirFunction.downloadResources(
            // Changed
            context: context,
            isSetupProcess: false,
            tafsirBook: data["full_path"], // Changed
            tafsirLanguage: data["language"], // Changed
          );
          downloadedTafsirs = // Changed
              QuranTafsirFunction.getDownloadedTafsirBooks(); // Changed
          downloadingData = null;
          setState(() {});
        }
      },

      borderRadius: BorderRadius.circular(roundedRadius),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(data["name"] ?? "")),
            SizedBox(
              height: 30,
              width: 30,
              child:
                  isDownloading
                      ? const CircularProgressIndicator(strokeWidth: 3)
                      : needDownload
                      ? const Icon(FluentIcons.arrow_download_24_filled)
                      : isSelected
                      ? Icon(
                        Icons.check_box_rounded,
                        color: context.read<ThemeCubit>().state.primary,
                      )
                      : const Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.grey,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
