import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/screen/settings/settings_page.dart";
import "package:al_quran_v3/src/screen/setup/book_select_popup.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/segmented_resources_manager.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/home/home_page.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  List<TafsirBookModel>? selectableTafsirBook;

  String? appLanguage;
  String? translationLanguageCode;
  String? tafsirLanguageCode;

  void changeAppLanguage(MyAppLocalization localeInfo) {
    appLanguage = localeInfo.locale.languageCode;
    String? languageName = codeToLanguageMap[appLanguage];
    context.read<LanguageCubit>().changeLanguage(localeInfo);

    if (translationResources.keys.contains(languageName)) {
      translationLanguageCode = appLanguage;

      context.read<ResourcesProgressCubitCubit>().changeTranslationBook(
        translationResources[codeToLanguageMap[translationLanguageCode]]
            ?.map((e) => TranslationBookModel.fromMap(e))
            .toList()
            .first,
      );
    }

    if (tafsirInformationWithScore.keys.contains(languageName)) {
      tafsirLanguageCode = appLanguage;
      selectableTafsirBook =
          tafsirInformationWithScore[codeToLanguageMap[tafsirLanguageCode]]
              ?.map((e) => TafsirBookModel.fromMap(e))
              .toList() ??
          [];
      selectableTafsirBook?.sort((a, b) => b.score.compareTo(a.score));
      if (selectableTafsirBook?.isNotEmpty == true) {
        context.read<ResourcesProgressCubitCubit>().changeTafsirBook(
          selectableTafsirBook!.first,
        );
      }
    }
  }

  void changeTranslationLanguage(String value) {
    translationLanguageCode = value;
    context.read<ResourcesProgressCubitCubit>().changeTranslationBook(null);
  }

  void changeTafsirLanguage(String value) {
    tafsirLanguageCode = value;
    context.read<ResourcesProgressCubitCubit>().changeTafsirBook(null);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectableTafsirBook =
          tafsirInformationWithScore[codeToLanguageMap[tafsirLanguageCode]]
              ?.map((e) => TafsirBookModel.fromMap(e))
              .toList() ??
          [];
    });
  }

  late ThemeState themeState = context.read<ThemeCubit>().state;

  @override
  void initState() {
    if (!kIsWeb) {
      changeAppLanguage(context.read<LanguageCubit>().state);
    }
    QuranTranslationFunction.init();
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.appLanguage),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(FluentIcons.settings_24_regular),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<LanguageCubit, MyAppLocalization>(
                builder: (context, state) {
                  return RadioGroup<MyAppLocalization>(
                    groupValue: state,
                    onChanged: (value) {
                      if (value != null) {
                        changeAppLanguage(value);
                      }
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: usedAppLanguageMap.length,
                      itemBuilder: (context, index) {
                        final MyAppLocalization appLoc =
                            usedAppLanguageMap[index];
                        return RadioListTile<MyAppLocalization>(
                          value: appLoc,
                          title: Text(appLoc.native),
                          subtitle: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(appLoc.english),
                                const Gap(7),
                                if (doesHaveFootNote(
                                  appLoc.english.toLowerCase(),
                                ))
                                  getFeaturesMark(
                                    context,
                                    appLocalizations.footnote,
                                  ),
                                if (doesHaveTafsirSupport(
                                  appLoc.english.toLowerCase(),
                                ))
                                  getFeaturesMark(
                                    context,
                                    appLocalizations.tafsir,
                                  ),
                                if (doesHaveWordByWordTranslation(
                                  appLoc.english.toLowerCase(),
                                ))
                                  getFeaturesMark(
                                    context,
                                    appLocalizations.wordByWord,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            BlocBuilder<
              ResourcesProgressCubitCubit,
              ResourcesProgressCubitState
            >(
              builder:
                  (context, state) => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(roundedRadius),
                      boxShadow: [
                        BoxShadow(color: themeState.mutedGray, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appLocalizations.translation,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  Text(
                                    context
                                            .read<ResourcesProgressCubitCubit>()
                                            .state
                                            .translationBookModel
                                            ?.name ??
                                        "",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  scrollControlDisabledMaxHeightRatio: 0.85,
                                  context: context,
                                  showDragHandle: true,
                                  builder: (context) {
                                    return const BookSelectPopup(
                                      isTafsir: false,
                                    );
                                  },
                                );
                              },
                              child: Text(appLocalizations.change),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appLocalizations.tafsir,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  Text(
                                    context
                                            .read<ResourcesProgressCubitCubit>()
                                            .state
                                            .tafsirBookModel
                                            ?.name ??
                                        "",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  scrollControlDisabledMaxHeightRatio: 0.85,
                                  context: context,
                                  showDragHandle: true,
                                  builder: (context) {
                                    return const BookSelectPopup(
                                      isTafsir: true,
                                    );
                                  },
                                );
                              },
                              child: Text(appLocalizations.change),
                            ),
                          ],
                        ),
                        const Gap(10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              downloadResources(
                                context
                                    .read<ResourcesProgressCubitCubit>()
                                    .state,
                              );
                            },
                            icon: const Icon(
                              FluentIcons.arrow_download_24_filled,
                            ),
                            label: Text(appLocalizations.saveAndDownload),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadResources(
    ResourcesProgressCubitState processState,
  ) async {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    if (translationLanguageCode == null ||
        tafsirLanguageCode == null ||
        processState.translationBookModel == null ||
        processState.tafsirBookModel == null) {
      Fluttertoast.showToast(msg: appLocalizations.pleaseSelectRequiredOption);
    }
    final userBox = Hive.box("user");
    await userBox.put("app_language", appLanguage);

    context.read<ResourcesProgressCubitCubit>().onProcess();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => dialogForShowDownloadProcess(processState),
    );
    bool success1 = await QuranTranslationFunction.downloadResources(
      context: context,
      translationBook: processState.translationBookModel!,
      isSetupProcess: true,
    );
    bool success2 = await QuranTafsirFunction.downloadResources(
      context: context,
      tafsirBook: processState.tafsirBookModel!,
      isSetupProcess: true,
    );
    String language = codeToLanguageMap[translationLanguageCode ?? ""] ?? "";
    TranslationBookModel? supportedWbW = wordByWordTranslation.values
        .map((e) => TranslationBookModel.fromMap(e))
        .firstOrNullWhere(
          (element) => element.language.toLowerCase() == language.toLowerCase(),
        );
    log(supportedWbW?.fullPath ?? "Null", name: "WBW Full Path");
    bool success3 =
        supportedWbW != null
            ? await WordByWordFunction.downloadResource(
              context: context,
              book: supportedWbW,
              isSetupProcess: true,
            )
            : true;
    bool success4 = await SegmentedResourcesManager.downloadResources(
      context,
      context.read<SegmentedQuranReciterCubit>().state.segmentsUrl!,
    );
    if (success1 && success2 && success3 && success4) {
      userBox.put("is_setup_complete", true);
      // success and route to home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );

      // clear process state
      context.read<ResourcesProgressCubitCubit>().success();
    } else {
      // error and show 'Something went wrong' in cubit
      log([success1, success2, success3, success4].toString());
      context.read<ResourcesProgressCubitCubit>().failure(
        appLocalizations.unableToDownloadResources,
      );
    }
  }

  Dialog dialogForShowDownloadProcess(
    ResourcesProgressCubitState processState,
  ) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),

        height: 150,
        width: double.infinity,
        alignment: Alignment.center,
        child: BlocBuilder<
          ResourcesProgressCubitCubit,
          ResourcesProgressCubitState
        >(
          builder: (context, state) {
            if (state.onProcess == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.justAMoment,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Gap(20),
                  LinearProgressIndicator(
                    value:
                        (state.percentage == null ||
                                state.percentage == 0.0 ||
                                state.percentage == 1.0)
                            ? null
                            : state.percentage,
                    color: themeState.primary,
                    borderRadius: BorderRadius.circular(roundedRadius),
                    minHeight: 8,
                  ),
                  const Gap(10),
                  Text(
                    appLocalizations.processProgress(
                      state.processName ?? "",
                      state.percentage != null
                          ? "${(state.percentage! * 100).toStringAsFixed(2)}%"
                          : "",
                    ),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else if (state.isSuccess == true) {
              return Text(appLocalizations.success);
            } else if (state.errorMessage != null) {
              return Column(
                children: [
                  Text(
                    "${state.errorMessage}",
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadResources(processState);
                    },
                    child: Text(appLocalizations.retry),
                  ),
                ],
              );
            }
            return LinearProgressIndicator(
              color: themeState.primary,
              borderRadius: BorderRadius.circular(roundedRadius),
              minHeight: 8,
            );
          },
        ),
      ),
    );
  }
}

bool doesHaveFootNote(String language) {
  bool doesHaveFootNote = false;
  for (Map map in translationResources[language] ?? []) {
    if (map["type"] == "translation-with-footnote-tags") {
      doesHaveFootNote = true;
      break;
    }
  }
  return doesHaveFootNote;
}

bool doesHaveWordByWordTranslation(String language) {
  bool doesHaveWordByWordTranslation = false;
  wordByWordTranslation.forEach((lang, value) {
    if (language == lang.toLowerCase()) {
      doesHaveWordByWordTranslation = true;
    }
  });

  return doesHaveWordByWordTranslation;
}

bool doesHaveTafsirSupport(String language) {
  bool doesHaveTafsirSupport = false;
  tafsirInformationWithScore.forEach((key, value) {
    if (language == key.toLowerCase()) {
      doesHaveTafsirSupport = true;
    }
  });
  return doesHaveTafsirSupport;
}

Widget getFeaturesMark(
  BuildContext context,
  String name, {
  bool asColumn = false,
}) {
  return Container(
    padding:
        asColumn
            ? const EdgeInsets.only(left: 3, right: 3, bottom: 2)
            : const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: context.read<ThemeCubit>().state.primaryShade100,
      borderRadius:
          asColumn ? BorderRadius.circular(5) : BorderRadius.circular(100),
    ),
    child:
        asColumn
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.done_rounded, size: 15),
                Text(name, style: const TextStyle(fontSize: 12)),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.done_rounded, size: 15),
                const Gap(5),
                Text(name, style: const TextStyle(fontSize: 12)),
              ],
            ),
  );
}
