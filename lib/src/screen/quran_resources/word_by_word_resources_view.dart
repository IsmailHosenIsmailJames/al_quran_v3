import "dart:developer";

import "package:al_quran_v3/src/functions/quran_resources/word_by_word_function.dart";
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
    List<TranslationBookModel> availableWbWBooks =
        wordByWordTranslation.values
            .map((e) => TranslationBookModel.fromMap(e))
            .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
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
                color:
                    isSelected
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
                    await WordByWordFunction.setSelectedWordByWordBook(current);
                  } else {
                    log("Language '${current.name}' is already selected.");
                  }
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
                    await WordByWordFunction.setSelectedWordByWordBook(current);
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
                    SizedBox(
                      height: 30,
                      width: 30,
                      child:
                          isDownloading
                              ? CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  themeState.primary,
                                ),
                              )
                              : isDownloaded
                              ? isSelected
                                  ? Icon(
                                    Icons.check_circle_rounded,
                                    color: themeState.primary,
                                    size: 28,
                                  )
                                  : Icon(
                                    Icons.circle_outlined,
                                    color: Colors.grey[600],
                                    size: 28,
                                  )
                              : Icon(
                                FluentIcons.arrow_download_24_regular,
                                color: themeState.primary,
                                size: 28,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
