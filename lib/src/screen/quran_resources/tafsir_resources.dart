import 'dart:developer';

import 'package:al_quran_v3/src/functions/quran_resources/quran_tafsir_function.dart';
import 'package:al_quran_v3/src/resources/quran_resources/language_code.dart';
import 'package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/theme/controller/theme_state.dart';
import 'package:dartx/dartx.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TafsirResources extends StatefulWidget {
  const TafsirResources({super.key});

  @override
  State<TafsirResources> createState() => _TafsirResourcesState();
}

class _TafsirResourcesState extends State<TafsirResources> {
  List<Map> downloadedTafsirs = QuranTafsirFunction.getDownloadedTafsirBooks();
  Map? selectedTafsir = QuranTafsirFunction.getTafsirSelection();
  Map? downloadingData;

  void _refreshData() {
    setState(() {
      downloadedTafsirs = QuranTafsirFunction.getDownloadedTafsirBooks();
      selectedTafsir = QuranTafsirFunction.getTafsirSelection();
      downloadingData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        children: List.generate(tafsirInformationWithScore.length, (index) {
          String languageKey = tafsirInformationWithScore.keys.elementAt(index);
          List<Map<String, dynamic>> booksInLanguage =
              tafsirInformationWithScore[languageKey]!;

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
                    Map? matchedTafsir = downloadedTafsirs.firstOrNullWhere(
                      (element) => element["name"] == bookData["full_path"],
                    );
                    bool needDownload = matchedTafsir == null;
                    bool isSelected = false;
                    if (!needDownload && selectedTafsir != null) {
                      if (selectedTafsir!["name"] == matchedTafsir["name"] &&
                          selectedTafsir!["language"] ==
                              matchedTafsir["language"]) {
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
          await QuranTafsirFunction.setTafsirSelection(
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
          log(
            "Downloading Tafsir: ${bookData['name']}",
            name: "TafsirResourcesUI",
          );
          await QuranTafsirFunction.downloadResources(
            context: context,
            isSetupProcess: false,
            tafsirBook: bookData["full_path"],
            tafsirLanguage: bookData["language"],
          );

          if (await QuranTafsirFunction.isAlreadyDownloaded(
            bookData["full_path"],
            bookData["language"],
          )) {
            await QuranTafsirFunction.setTafsirSelection(
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
