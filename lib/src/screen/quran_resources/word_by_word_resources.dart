import "dart:developer";

import "package:al_quran_v3/src/functions/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_code.dart";
import "package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart"
    as wbw_data_source;
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class WordByWordResources extends StatefulWidget {
  const WordByWordResources({super.key});

  @override
  State<WordByWordResources> createState() => _WordByWordResourcesState();
}

class _WordByWordResourcesState extends State<WordByWordResources> {
  List<String> downloadedLanguages = [];
  String? selectedLanguage;
  String? downloadingLanguageKey;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await WordByWordFunction.init();
    setState(() {
      downloadedLanguages =
          WordByWordFunction.getDownloadedWordByWordLanguages();
      selectedLanguage = WordByWordFunction.getSelectedWordByWordLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.watch<ThemeCubit>().state;
    List<String> availableLanguageKeys =
        wbw_data_source.wordByWordTranslation.keys.toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: List.generate(availableLanguageKeys.length, (index) {
          String languageKey = availableLanguageKeys[index];
          Map<String, dynamic>? wbwInfo = WordByWordFunction.getLanguageInfo(
            languageKey,
          );

          if (wbwInfo == null) {
            return const SizedBox.shrink();
          }

          bool isDownloaded = downloadedLanguages.contains(languageKey);
          bool isSelected = selectedLanguage == languageKey;
          bool isDownloading = downloadingLanguageKey == languageKey;

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
                      selectedLanguage = languageKey;
                    });
                    await WordByWordFunction.setSelectedWordByWordLanguage(
                      languageKey,
                    );
                  } else {
                    log("Language '$languageKey' is already selected.");
                  }
                } else {
                  setState(() {
                    downloadingLanguageKey = languageKey;
                  });
                  log(
                    "Starting download for: $languageKey",
                    name: "WbWResourcesUI",
                  );
                  bool success = await WordByWordFunction.downloadResource(
                    context: context,
                    languageKey: languageKey,
                  );
                  if (success) {
                    await WordByWordFunction.setSelectedWordByWordLanguage(
                      languageKey,
                    );
                  }

                  await _loadInitialData();
                  setState(() {
                    downloadingLanguageKey = null;
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
                            wbwInfo["name"] ?? languageKey,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (wbwInfo["language"] != null &&
                              wbwInfo["language"] != wbwInfo["name"])
                            Text(
                              languageNativeNames[languageKey] ??
                                  wbwInfo["language"],
                            ),
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
