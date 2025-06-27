import "dart:developer";

import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/meta_data/simple_translation.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_code.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TranslationResources extends StatefulWidget {
  const TranslationResources({super.key});

  @override
  State<TranslationResources> createState() => _TranslationResourcesState();
}

class _TranslationResourcesState extends State<TranslationResources> {
  List<Map> downloadedTranslation =
      QuranTranslationFunction.getDownloadedTranslationBooks();
  Map? selectedResources = QuranTranslationFunction.getTranslationSelection();
  Map? downloadingData;

  void _refreshData() {
    setState(() {
      downloadedTranslation =
          QuranTranslationFunction.getDownloadedTranslationBooks();
      selectedResources = QuranTranslationFunction.getTranslationSelection();
      downloadingData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        children: List.generate(simpleTranslation.length, (index) {
          String languageKey = simpleTranslation.keys.elementAt(index);
          List<Map<String, dynamic>> booksInLanguage =
              simpleTranslation[languageKey]!;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ExpansionTile(
              key: PageStorageKey(languageKey),
              title: Text(
                languageNativeNames[languageKey] ?? languageKey,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              children:
                  booksInLanguage.map((bookData) {
                    Map? matchedResources = downloadedTranslation
                        .firstOrNullWhere(
                          (element) => element["name"] == bookData["full_path"],
                        );
                    bool needDownload = matchedResources == null;
                    bool isSelected = false;
                    if (!needDownload && selectedResources != null) {
                      if (selectedResources!["name"] ==
                              matchedResources["name"] &&
                          selectedResources!["language"] ==
                              matchedResources["language"]) {
                        isSelected = true;
                      }
                    }

                    bool isDownloading = false;
                    if (downloadingData != null) {
                      if (downloadingData!["full_path"] ==
                          bookData["full_path"]) {
                        isDownloading = true;
                      }
                    }

                    return _buildBookListTile(
                      bookData,
                      isSelected,
                      needDownload,
                      isDownloading,
                      themeState,
                    );
                  }).toList(),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBookListTile(
    Map<String, dynamic> bookData,
    bool isSelected,
    bool needDownload,
    bool isDownloading,
    ThemeState themeState,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      title: Text(bookData["name"] ?? ""),
      trailing: SizedBox(
        height: 30,
        width: 30,
        child:
            isDownloading
                ? CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(themeState.primary),
                )
                : needDownload
                ? Icon(
                  FluentIcons.arrow_download_24_regular,
                  color: themeState.primary,
                )
                : isSelected
                ? Icon(
                  Icons.check_circle_rounded,
                  color: themeState.primary,
                  size: 26,
                )
                : Icon(
                  Icons.circle_outlined,
                  color: Colors.grey[600],
                  size: 26,
                ),
      ),
      onTap: () async {
        if (isDownloading) return;

        if (!isSelected && !needDownload) {
          QuranTranslationFunction.setTranslationSelection(
            bookData["full_path"],
            bookData["language"],
          );
          _refreshData();
        } else if (isSelected) {
          log("Already Selected: ${bookData['name']}");
        } else {
          setState(() {
            downloadingData = bookData;
          });
          log("Downloading: ${bookData['name']}", name: "downloadingData");
          await QuranTranslationFunction.downloadResources(
            context: context,
            isSetupProcess: false,
            translationBook: bookData["full_path"],
            translationLanguage: bookData["language"],
          );

          if (await QuranTranslationFunction.isAlreadyDownloaded(
            bookData["full_path"],
            bookData["language"],
          )) {
            QuranTranslationFunction.setTranslationSelection(
              bookData["full_path"],
              bookData["language"],
            );
          }
          _refreshData();
        }
      },
    );
  }
}
