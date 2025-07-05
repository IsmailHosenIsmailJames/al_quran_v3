import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/functions/encode_decode.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/functions/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/functions/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_info_with_score.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/home/home_page.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/components/get_score_widget.dart";
import "package:al_quran_v3/src/widget/preview_quran_script/ayah_preview_widget.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:al_quran_v3/src/widget/theme/theme_icon_button.dart";
import "package:dartx/dartx.dart";
import "package:dio/dio.dart" as dio;
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
  List<TranslationBookModel>? selectableTranslationBook;
  List<TafsirBookModel>? selectableTafsirBook;

  String? appLanguage;
  String? translationLanguageCode;
  String? tafsirLanguageCode;

  late AppLocalizations appLocalizations;

  void changeAppLanguage(String languageCode) {
    appLanguage = languageCode;
    String? languageName = codeToLanguageMap[appLanguage];
    context.read<LanguageCubit>().changeLanguage(languageCode);

    if (translationResources.keys.contains(languageName)) {
      translationLanguageCode = appLanguage;
      selectableTranslationBook =
          translationResources[codeToLanguageMap[translationLanguageCode]]
              ?.map((e) => TranslationBookModel.fromMap(e))
              .toList() ??
          [];
      selectableTranslationBook?.sort((a, b) => a.score.compareTo(b.score));
      if (selectableTranslationBook?.isNotEmpty == true) {
        context.read<ResourcesProgressCubitCubit>().changeTranslationBook(
          selectableTranslationBook!.first,
        );
      }
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
    selectableTranslationBook =
        translationResources[codeToLanguageMap[translationLanguageCode]]
            ?.map((e) => TranslationBookModel.fromMap(e))
            .toList() ??
        [];
  }

  void changeTafsirLanguage(String value) {
    tafsirLanguageCode = value;
    context.read<ResourcesProgressCubitCubit>().changeTafsirBook(null);
    selectableTafsirBook =
        tafsirInformationWithScore[codeToLanguageMap[tafsirLanguageCode]]
            ?.map((e) => TafsirBookModel.fromMap(e))
            .toList() ??
        [];
  }

  late ThemeState themeState = context.read<ThemeCubit>().state;

  @override
  void initState() {
    if (!kIsWeb) {
      changeAppLanguage(
        context.read<LanguageCubit>().state.locale.languageCode,
      );
    }
    QuranTranslationFunction.init();
    super.initState();
  }

  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadResources(context.read<ResourcesProgressCubitCubit>().state);
        },
        tooltip: appLocalizations.saveAndDownload,
        backgroundColor: themeState.primary,
        foregroundColor: Colors.white,
        child: const Icon(FluentIcons.arrow_download_24_filled),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: fromKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 60,
                  bottom: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 1),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.appLanguage,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Gap(5),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: appLocalizations.selectAppLanguage,
                          ),
                          value: appLanguage,
                          validator: (value) {
                            if (value == null) {
                              return appLocalizations.pleaseSelectOne;
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          isExpanded: true,
                          items: getAppLanguageDropdown(),
                          onChanged: (value) {
                            changeAppLanguage(value.toString());
                            setState(() {});
                          },
                        ),

                        const Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 2),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.quranTranslationLanguage,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Gap(5),
                        DropdownButtonFormField(
                          value: translationLanguageCode,
                          items: getQuranTranslationLanguageDropDownList(),
                          decoration: InputDecoration(
                            hintText:
                                appLocalizations.selectTranslationLanguage,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return appLocalizations.pleaseSelectOne;
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          isExpanded: true,
                          onChanged: (value) {
                            changeTranslationLanguage(value.toString());
                            setState(() {});
                          },
                        ),
                        const Gap(15),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 3),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.quranTranslationBook,
                              style: titleStyle,
                            ),
                          ],
                        ),

                        const Gap(5),
                        BlocBuilder<
                          ResourcesProgressCubitCubit,
                          ResourcesProgressCubitState
                        >(
                          builder: (context, resourcesProcessState) {
                            return DropdownButtonFormField(
                              items: getQuranTranslationBookDropDownList(
                                resourcesProcessState,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    appLocalizations.selectTranslationBook,
                              ),
                              value: resourcesProcessState.translationBookModel,
                              validator: (value) {
                                if (value == null) {
                                  return "Please select one";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              isExpanded: true,
                              onChanged: (value) {
                                context
                                    .read<ResourcesProgressCubitCubit>()
                                    .changeTranslationBook(value);
                              },
                            );
                          },
                        ),
                        const Gap(15),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 4),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.quranTafsirLanguage,
                              style: titleStyle,
                            ),
                          ],
                        ),

                        const Gap(5),
                        DropdownButtonFormField(
                          items: getQuranTafsirLanguageDropDownList(),
                          decoration: InputDecoration(
                            hintText: appLocalizations.selectTafsirLanguage,
                          ),
                          value: tafsirLanguageCode,
                          validator: (value) {
                            if (value == null) {
                              return appLocalizations.pleaseSelectOne;
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          isExpanded: true,
                          onChanged: (value) {
                            changeTafsirLanguage(value.toString());
                            setState(() {});
                          },
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 5),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.quranTafsirBook,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Gap(5),
                        BlocBuilder<
                          ResourcesProgressCubitCubit,
                          ResourcesProgressCubitState
                        >(
                          builder: (context, processState) {
                            return DropdownButtonFormField(
                              items: getQuranTafsirBookDropDownList(
                                processState,
                              ),
                              decoration: InputDecoration(
                                hintText: appLocalizations.selectTafsirBook,
                              ),
                              isExpanded: true,
                              value: processState.tafsirBookModel,
                              validator: (value) {
                                if (value == null) {
                                  return "Please select one";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                context
                                    .read<ResourcesProgressCubitCubit>()
                                    .changeTafsirBook(value);
                              },
                            );
                          },
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: themeState.primary,
                              child: Text(
                                localizedNumber(context, 6),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              appLocalizations.quranScriptAndStyle,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        const Gap(5),
                        getScriptSelectionSegmentedButtons(context),
                        getAyahPreviewWidget(
                          showHeaderOptions: true,
                          showOnlyAyah: true,
                        ),

                        const Gap(80),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: themeIconButton(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadResources(
    ResourcesProgressCubitState processState,
  ) async {
    if (translationLanguageCode == null ||
        tafsirLanguageCode == null ||
        processState.translationBookModel == null ||
        processState.tafsirBookModel == null) {
      Fluttertoast.showToast(msg: appLocalizations.pleaseSelectRequiredOption);
    }
    if (fromKey.currentState?.validate() == true) {
      final userBox = Hive.box("user");
      await userBox.put("app_language", appLanguage);

      context.read<ResourcesProgressCubitCubit>().onProcess();

      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => Dialog(
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
                            value: state.percentage,
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
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
            ),
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
            (element) =>
                element.language.toLowerCase() == language.toLowerCase(),
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
      bool success4 = await downloadDefaultSegmentedQuranRecitation();
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
  }

  Future<bool> downloadDefaultSegmentedQuranRecitation() async {
    String url =
        ApisUrls.base +
        context.read<SegmentedQuranReciterCubit>().state.segmentsUrl!;
    try {
      context.read<ResourcesProgressCubitCubit>().updateProgress(
        null,
        appLocalizations.downloadingSegmentedQuranRecitation,
      );
      final response = await dio.Dio().get(url);
      if (response.statusCode == 200) {
        Box box = Hive.box("segmented_quran_recitation");
        context.read<ResourcesProgressCubitCubit>().updateProgress(
          null,
          appLocalizations.processingSegmentedQuranRecitation,
        );
        Map segmentsInfo = await compute(
          (message) => jsonDecode(decodeBZip2String(message)),
          response.data,
        );

        for (final ayahKey in segmentsInfo.keys) {
          await box.put(ayahKey, segmentsInfo[ayahKey]);
        }
        await Hive.box("segmented_quran_recitation").put(
          "meta_data",
          context.read<SegmentedQuranReciterCubit>().state.toMap(),
        );
        return true;
      } else {
        return false;
      }
    } on dio.DioException catch (e) {
      log(e.message ?? "Null Message");
      return false;
    }
  }

  QuranScriptType selectedScript = QuranScriptType.tajweed;

  List<DropdownMenuItem<TafsirBookModel>>? getQuranTafsirBookDropDownList(
    ResourcesProgressCubitState processState,
  ) {
    List<DropdownMenuItem<TafsirBookModel>> items = [];
    if (selectableTafsirBook?.isEmpty ?? true) return null;
    selectableTafsirBook?.sort((a, b) => b.score.compareTo(a.score));
    for (TafsirBookModel book in selectableTafsirBook ?? []) {
      items.add(
        DropdownMenuItem(
          value: book,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (processState.tafsirBookModel?.fullPath == book.fullPath)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: themeState.primary,
                    ),
                  ),
                buildScoreIndicator(percentage: book.score, size: 20),
                const Gap(8),
                Text(book.name),
              ],
            ),
          ),
        ),
      );
    }

    return items;
  }

  List<DropdownMenuItem>? getQuranTafsirLanguageDropDownList() {
    List<DropdownMenuItem> items = [];
    tafsirInformationWithScore.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: languageToCodeMap[key.toLowerCase()],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (tafsirLanguageCode == languageToCodeMap[key.toLowerCase()])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: themeState.primary,
                    ),
                  ),
                Text(languageNativeNames[key.toLowerCase()] ?? ""),
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  List<DropdownMenuItem<String>> getAppLanguageDropdown() {
    return usedAppLanguageMap.map((e) {
      return DropdownMenuItem(
        value: e["Code"],
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (appLanguage == e["Code"])
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.done_rounded,
                    size: 18,
                    color: themeState.primary,
                  ),
                ),
              Text("${e["Native"] ?? ""} (${e["English"] ?? ""})"),
              ...getSupportInfoForLanguageWidget(key: e["English"] ?? ""),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem>? getQuranTranslationBookDropDownList(
    ResourcesProgressCubitState resourcesProcessState,
  ) {
    List<DropdownMenuItem<TranslationBookModel>> items = [];
    if (selectableTranslationBook?.isEmpty ?? true) return null;
    for (TranslationBookModel book in selectableTranslationBook ?? []) {
      items.add(
        DropdownMenuItem(
          value: book,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (resourcesProcessState.translationBookModel?.fullPath ==
                    book.fullPath)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: themeState.primary,
                    ),
                  ),
                Text(book.name),
                if (book.type == TranslationResourcesType.withFootnoteTags)
                  footNoteTag,
              ],
            ),
          ),
        ),
      );
    }

    return items;
  }

  List<DropdownMenuItem> getQuranTranslationLanguageDropDownList() {
    List<DropdownMenuItem> items = [];
    translationResources.forEach((key, value) {
      items.add(
        DropdownMenuItem(
          value: languageToCodeMap[key.toLowerCase()],
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (translationLanguageCode ==
                    languageToCodeMap[key.toLowerCase()])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.done_rounded,
                      size: 18,
                      color: themeState.primary,
                    ),
                  ),
                Text(languageNativeNames[key.toLowerCase()] ?? ""),
                ...getSupportInfoForLanguageWidget(key: key.toLowerCase()),
              ],
            ),
          ),
        ),
      );
    });
    return items;
  }

  List<Widget> getSupportInfoForLanguageWidget({required String key}) {
    return [
      if (doesHaveFootNote(key.toLowerCase())) footNoteTag,
      if (doesHaveTafsirSupport(key.toLowerCase())) tafsirTag,
      if (doesHaveWordByWordTranslation(key.toLowerCase())) wordByWordTag,
    ];
  }

  late Widget footNoteTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: themeState.primary,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          appLocalizations.footnote,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );

  late Widget tafsirTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: themeState.primary,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          appLocalizations.tafsir,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );

  late Widget wordByWordTag = Container(
    padding: const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: themeState.primary,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.done_rounded, color: Colors.white, size: 15),
        const Gap(5),
        Text(
          appLocalizations.wordByWord,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
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

Widget getScriptSelectionSegmentedButtons(BuildContext context) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return BlocBuilder<QuranViewCubit, QuranViewState>(
        builder:
            (context, quranViewState) => Row(
              spacing: 5,
              children: List.generate(QuranScriptType.values.length, (index) {
                QuranScriptType currentQuranScriptType =
                    QuranScriptType.values[index];
                return Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          quranViewState.quranScriptType ==
                                  currentQuranScriptType
                              ? themeState.primary
                              : Colors.transparent,
                      foregroundColor:
                          quranViewState.quranScriptType ==
                                  currentQuranScriptType
                              ? Colors.white
                              : themeState.primary,
                      side: BorderSide(color: themeState.primary),
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            0 == index ? roundedRadius : 0,
                          ),
                          bottomLeft: Radius.circular(
                            0 == index ? roundedRadius : 0,
                          ),
                          topRight: Radius.circular(
                            2 == index ? roundedRadius : 0,
                          ),
                          bottomRight: Radius.circular(
                            2 == index ? roundedRadius : 0,
                          ),
                        ),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Hive.box(
                        "user",
                      ).put("selected_script", currentQuranScriptType.name);

                      context.read<QuranViewCubit>().changeQuranScriptType(
                        currentQuranScriptType,
                      );
                    },
                    label: Text(
                      getLocalizedQuranScriptType(
                        context,
                        currentQuranScriptType,
                      ).capitalize(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    icon:
                        quranViewState.quranScriptType == currentQuranScriptType
                            ? const Icon(Icons.done_rounded)
                            : null,
                  ),
                );
              }),
            ),
      );
    },
  );
}
