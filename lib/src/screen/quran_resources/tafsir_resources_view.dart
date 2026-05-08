import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/utils/filter/search_pattern_in_text.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_resources.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TafsirResourcesView extends StatefulWidget {
  final String searchQuery;
  const TafsirResourcesView({super.key, this.searchQuery = ''});

  @override
  State<TafsirResourcesView> createState() => _TafsirResourcesViewState();
}

class _TafsirResourcesViewState extends State<TafsirResourcesView> {
  late List<ResourcesModel> downloadedTafsirs;

  List<ResourcesModel>? selectedTafsir;

  ResourcesModel? downloadingData;

  void _refreshData() async {
    downloadedTafsirs = QuranTafsirFunction.getDownloadedTafsirBooks();
    selectedTafsir = await QuranTafsirFunction.getTafsirSelections();
    downloadingData = null;
    setState(() {});
  }

  @override
  void initState() {
    downloadedTafsirs = QuranTafsirFunction.getDownloadedTafsirBooks();
    QuranTafsirFunction.getTafsirSelections().then((value) {
      int previousLen = selectedTafsir?.length ?? 0;
      selectedTafsir = value;
      if (previousLen == 0) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: List.generate(tafsirResources.length, (index) {
              String languageKey = tafsirResources.keys.sorted().elementAt(
                index,
              );
              List<ResourcesModel> booksInLanguage =
                  tafsirResources[languageKey]
                      ?.map((e) => ResourcesModel.fromMap(e))
                      .toList() ??
                  [];
                  
              if (booksInLanguage.isEmpty) {
                return const SizedBox();
              }
              
              bool matchesSearch = widget.searchQuery.isEmpty || 
                  booksInLanguage.first.language.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
                  booksInLanguage.first.languageNative.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
                  searchPatternInText(widget.searchQuery.toLowerCase(), booksInLanguage.first.language.toLowerCase()) > 80.0 ||
                  searchPatternInText(widget.searchQuery.toLowerCase(), booksInLanguage.first.languageNative.toLowerCase()) > 80.0;

              if (!matchesSearch) {
                return const SizedBox();
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                elevation: 0,
                child: ExpansionTile(
                  key: PageStorageKey(languageKey),
                  title: Text(
                    booksInLanguage.first.languageNative,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    booksInLanguage.first.language
                        .replaceAll("_", " ")
                        .capitalize(),
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  children: booksInLanguage.map((bookData) {
                    ResourcesModel? matchedTafsir = downloadedTafsirs
                        .firstOrNullWhere(
                          (element) => element.fullPath == bookData.fullPath,
                        );
                    bool needDownload = matchedTafsir == null;
                    bool isSelected = false;
                    if (!needDownload && selectedTafsir != null) {
                      if (selectedTafsir?.any(
                            (element) =>
                                element.fullPath == matchedTafsir.fullPath,
                          ) ==
                          true) {
                        isSelected = true;
                      }
                    }

                    bool isDownloading = false;
                    if (downloadingData != null) {
                      if (downloadingData?.fullPath == bookData.fullPath) {
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
    ResourcesModel tafsirBook,
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
      title: Text(tafsirBook.name),
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
                  downloadingData = tafsirBook;
                });
                log(
                  "Downloading Tafsir: ${tafsirBook.name}",
                  name: "TafsirResourcesViewUI",
                );
                await QuranTafsirFunction.downloadResources(
                  context: context,
                  isSetupProcess: false,
                  tafsirBook: tafsirBook,
                );

                if (await QuranTafsirFunction.isAlreadyDownloaded(tafsirBook)) {
                  await QuranTafsirFunction.setTafsirSelection(tafsirBook);
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
                  await QuranTafsirFunction.removeTafsirSelection(tafsirBook);
                } else {
                  await QuranTafsirFunction.setTafsirSelection(tafsirBook);
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
                  await QuranTafsirFunction.removeFromListAlreadyDownloaded(
                    tafsirBook,
                  );
                  _refreshData();
                } else if (value == 'redownload') {
                  await QuranTafsirFunction.removeFromListAlreadyDownloaded(
                    tafsirBook,
                  );
                  _refreshData();
                  setState(() {
                    downloadingData = tafsirBook;
                  });
                  await QuranTafsirFunction.downloadResources(
                    context: context,
                    isSetupProcess: false,
                    tafsirBook: tafsirBook,
                  );

                  if (await QuranTafsirFunction.isAlreadyDownloaded(
                    tafsirBook,
                  )) {
                    await QuranTafsirFunction.setTafsirSelection(tafsirBook);
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
          await QuranTafsirFunction.setTafsirSelection(tafsirBook);
          _refreshData();
        } else if (isSelected) {
          await QuranTafsirFunction.removeTafsirSelection(tafsirBook);
          _refreshData();
        } else {
          setState(() {
            downloadingData = tafsirBook;
          });
          log(
            "Downloading Tafsir: ${tafsirBook.name}",
            name: "TafsirResourcesViewUI",
          );
          await QuranTafsirFunction.downloadResources(
            context: context,
            isSetupProcess: false,
            tafsirBook: tafsirBook,
          );

          if (await QuranTafsirFunction.isAlreadyDownloaded(tafsirBook)) {
            await QuranTafsirFunction.setTafsirSelection(tafsirBook);
          }
          _refreshData();
        }
      },
    );
  }
}
