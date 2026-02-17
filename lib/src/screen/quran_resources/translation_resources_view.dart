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
  List<TranslationBookModel?>? selectedResources;

  TranslationBookModel? downloadingData;

  void _refreshData() async {
    selectedResources =
        await QuranTranslationFunction.getTranslationSelections();
    downloadedTranslation =
        QuranTranslationFunction.getDownloadedTranslationBooks();
    downloadingData = null;
    setState(() {});
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return selectedResources == null
        ? const SizedBox()
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 15.0,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: List.generate(translationResources.length, (index) {
                    String languageKey = translationResources.keys.elementAt(
                      index,
                    );
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
                        children: booksInLanguage.map((bookData) {
                          TranslationBookModel? matchedResources =
                              downloadedTranslation.firstOrNullWhere(
                                (element) =>
                                    element.fullPath == bookData.fullPath,
                              );
                          bool needDownload = matchedResources == null;
                          bool isSelected = false;
                          if (!needDownload && selectedResources != null) {
                            if (selectedResources?.any(
                                  (element) =>
                                      element?.fullPath ==
                                      matchedResources.fullPath,
                                ) ==
                                true) {
                              isSelected = true;
                            }
                          }

                          bool isDownloading = false;
                          if (downloadingData != null) {
                            if (downloadingData!.fullPath ==
                                bookData.fullPath) {
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
              ),
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
      subtitle: const Row(children: []),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDownloading)
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(themeState.primary),
                backgroundColor: context
                    .read<ThemeCubit>()
                    .state
                    .primaryShade100,
              ),
            )
          else if (needDownload)
            IconButton(
              onPressed: () async {
                setState(() {
                  downloadingData = translationBook;
                });
                log(
                  "Downloading: ${translationBook.name}",
                  name: "downloadingData",
                );
                await QuranTranslationFunction.downloadResources(
                  context: context,
                  isSetupProcess: false,
                  translationBook: translationBook,
                );

                if (await QuranTranslationFunction.isAlreadyDownloaded(
                  translationBook,
                )) {
                  await QuranTranslationFunction.setTranslationSelection(
                    translationBook,
                  );
                }
                _refreshData();
              },
              icon: Icon(
                FluentIcons.arrow_download_24_regular,
                color: themeState.primary,
              ),
            )
          else ...[
            IconButton(
              onPressed: () async {
                if (isSelected) {
                  await QuranTranslationFunction.removeTranslationSelection(
                    translationBook,
                  );
                } else {
                  await QuranTranslationFunction.setTranslationSelection(
                    translationBook,
                  );
                }
                _refreshData();
              },
              icon: Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected ? themeState.primary : Colors.grey[600],
                size: 26,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'delete') {
                  await QuranTranslationFunction.removeFromListAlreadyDownloaded(
                    translationBook,
                  );
                  _refreshData();
                } else if (value == 'redownload') {
                  await QuranTranslationFunction.removeFromListAlreadyDownloaded(
                    translationBook,
                  );
                  _refreshData();
                  setState(() {
                    downloadingData = translationBook;
                  });
                  await QuranTranslationFunction.downloadResources(
                    context: context,
                    isSetupProcess: false,
                    translationBook: translationBook,
                  );

                  if (await QuranTranslationFunction.isAlreadyDownloaded(
                    translationBook,
                  )) {
                    await QuranTranslationFunction.setTranslationSelection(
                      translationBook,
                    );
                  }
                  _refreshData();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(
                        FluentIcons.delete_24_regular,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(appLocalizations.delete),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'redownload',
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.arrow_download_24_regular,
                        color: themeState.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text("Redownload"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      onTap: () async {
        if (isDownloading) return;

        if (!isSelected && !needDownload) {
          await QuranTranslationFunction.setTranslationSelection(
            translationBook,
          );
          _refreshData();
        } else if (isSelected) {
          await QuranTranslationFunction.removeTranslationSelection(
            translationBook,
          );
          _refreshData();
        } else {
          // Download logic is now also on the icon, but ok to keep here for tile tap
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
            await QuranTranslationFunction.setTranslationSelection(
              translationBook,
            );
          }
          _refreshData();
        }
      },
    );
  }
}
