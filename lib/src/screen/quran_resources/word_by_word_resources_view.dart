import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class WordByWordResourcesView extends StatefulWidget {
  const WordByWordResourcesView({super.key});

  @override
  State<WordByWordResourcesView> createState() =>
      _WordByWordResourcesViewState();
}

class _WordByWordResourcesViewState extends State<WordByWordResourcesView> {
  List<TranslationBookModel> downloadedWbW = [];
  TranslationBookModel? selectedWbw;
  TranslationBookModel? downloadingWbW;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await WordByWordFunction.init();
    setState(() {
      downloadedWbW = WordByWordFunction.getDownloadedWordByWordBooks();
      selectedWbw = WordByWordFunction.getSelectedWordByWordBook();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    List<TranslationBookModel> availableWbWBooks = wordByWordTranslation.values
        .map((e) => TranslationBookModel.fromMap(e))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: List.generate(availableWbWBooks.length, (index) {
              TranslationBookModel current = availableWbWBooks[index];

              bool isDownloaded = downloadedWbW.any(
                (element) => element.fullPath == current.fullPath,
              );

              bool isSelected = selectedWbw?.fullPath == current.fullPath;
              bool isDownloading = downloadingWbW?.fullPath == current.fullPath;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  side: BorderSide(
                    color: isSelected
                        ? themeState.primary
                        : themeState.primaryShade100,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  onTap: () async {
                    if (isDownloading) return;

                    if (isDownloaded) {
                      if (!isSelected) {
                        setState(() {
                          selectedWbw = current;
                        });
                        await WordByWordFunction.setSelectedWordByWordBook(
                          current,
                        );
                      } else {
                        // For WBW, clicking an already selected item might not deselect because we need at least one?
                        // Or we can allow deselecting. Let's check logic.
                        // The function removeSelectedWordByWordBook exists.
                        // Let's allow deselecting on tap if it's already selected.
                        await WordByWordFunction.removeSelectedWordByWordBook();
                        setState(() {
                          selectedWbw = null;
                        });
                      }
                      await _loadInitialData();
                    } else {
                      setState(() {
                        downloadingWbW = current;
                      });
                      log(
                        "Starting download for: ${current.name}",
                        name: "WbWResourcesUI",
                      );
                      bool success = await WordByWordFunction.downloadResource(
                        context: context,
                        book: current,
                        isSetupProcess: false,
                      );
                      if (success) {
                        await WordByWordFunction.setSelectedWordByWordBook(
                          current,
                        );
                      }

                      await _loadInitialData();
                      setState(() {
                        downloadingWbW = null;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                current.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(current.language),
                            ],
                          ),
                        ),
                        if (isDownloading)
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                themeState.primary,
                              ),
                              backgroundColor: context
                                  .read<ThemeCubit>()
                                  .state
                                  .primaryShade100,
                            ),
                          )
                        else if (!isDownloaded)
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                downloadingWbW = current;
                              });
                              log(
                                "Starting download for: ${current.name}",
                                name: "WbWResourcesUI",
                              );
                              bool success =
                                  await WordByWordFunction.downloadResource(
                                    context: context,
                                    book: current,
                                    isSetupProcess: false,
                                  );
                              if (success) {
                                await WordByWordFunction.setSelectedWordByWordBook(
                                  current,
                                );
                              }
                              await _loadInitialData();
                              setState(() {
                                downloadingWbW = null;
                              });
                            },
                            icon: Icon(
                              FluentIcons.arrow_download_24_regular,
                              color: themeState.primary,
                              size: 28,
                            ),
                          )
                        else
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  if (isSelected) {
                                    await WordByWordFunction.removeSelectedWordByWordBook();
                                    setState(() {
                                      selectedWbw = null;
                                    });
                                  } else {
                                    setState(() {
                                      selectedWbw = current;
                                    });
                                    await WordByWordFunction.setSelectedWordByWordBook(
                                      current,
                                    );
                                  }
                                  await _loadInitialData();
                                },
                                icon: Icon(
                                  isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.circle_outlined,
                                  color: isSelected
                                      ? themeState.primary
                                      : Colors.grey[600],
                                  size: 28,
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) async {
                                  if (value == 'delete') {
                                    await WordByWordFunction.removeBookFromDownloaded(
                                      current,
                                    );
                                    await _loadInitialData();
                                  } else if (value == 'redownload') {
                                    await WordByWordFunction.removeBookFromDownloaded(
                                      current,
                                    );
                                    await _loadInitialData();
                                    setState(() {
                                      downloadingWbW = current;
                                    });
                                    bool success =
                                        await WordByWordFunction.downloadResource(
                                          context: context,
                                          book: current,
                                          isSetupProcess: false,
                                        );
                                    if (success) {
                                      await WordByWordFunction.setSelectedWordByWordBook(
                                        current,
                                      );
                                    }
                                    await _loadInitialData();
                                    setState(() {
                                      downloadingWbW = null;
                                    });
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
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
                                              FluentIcons
                                                  .arrow_download_24_regular,
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
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
