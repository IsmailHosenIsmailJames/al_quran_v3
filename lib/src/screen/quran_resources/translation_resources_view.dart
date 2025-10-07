import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TranslationResourcesView extends StatefulWidget {
  const TranslationResourcesView({super.key});

  @override
  State<TranslationResourcesView> createState() =>
      _TranslationResourcesViewState();
}

class _TranslationResourcesViewState extends State<TranslationResourcesView> {
  List<TranslationBookModel> downloadedTranslation =
      QuranTranslationFunction.getDownloadedTranslationBooks();
  TranslationBookModel? selectedResources =
      QuranTranslationFunction.getTranslationSelection();
  TranslationBookModel? downloadingData;

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
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        children: List.generate(translationResources.length, (index) {
          String languageKey = translationResources.keys.elementAt(index);
          List<TranslationBookModel> booksInLanguage =
              translationResources[languageKey]
                  ?.map(
                    (e) => TranslationBookModel.fromMap(
                      Map<String, dynamic>.from(e),
                    ),
                  )
                  .toList() ??
              [];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            elevation: 0,
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
                    TranslationBookModel? matchedResources =
                        downloadedTranslation.firstOrNullWhere(
                          (element) => element.fullPath == bookData.fullPath,
                        );
                    bool needDownload = matchedResources == null;
                    bool isSelected = false;
                    if (!needDownload && selectedResources != null) {
                      if (selectedResources!.fullPath ==
                          matchedResources.fullPath) {
                        isSelected = true;
                      }
                    }

                    bool isDownloading = false;
                    if (downloadingData != null) {
                      if (downloadingData!.fullPath == bookData.fullPath) {
                        isDownloading = true;
                      }
                    }

                    return _buildBookListTile(
                      appLocalizations,
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
    AppLocalizations appLocalizations,
    TranslationBookModel translationBook,
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
      title: Text(translationBook.name),
      trailing: SizedBox(
        height: 30,
        width: 30,
        child:
            isDownloading
                ? CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(themeState.primary),
                  backgroundColor:
                      context.read<ThemeCubit>().state.primaryShade100,
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
          QuranTranslationFunction.setTranslationSelection(translationBook);
          _refreshData();
        } else if (isSelected) {
          log(
            appLocalizations.alreadySelected(translationBook.name),
            name: "TranslationResourcesViewUI",
          );
        } else {
          setState(() {
            downloadingData = translationBook;
          });
          log("Downloading: ${translationBook.name}", name: "downloadingData");
          await QuranTranslationFunction.downloadResources(
            context: context,
            isSetupProcess: false,
            translationBook: translationBook,
          );

          if (await QuranTranslationFunction.isAlreadyDownloaded(
            translationBook,
          )) {
            QuranTranslationFunction.setTranslationSelection(translationBook);
          }
          _refreshData();
        }
      },
    );
  }
}
