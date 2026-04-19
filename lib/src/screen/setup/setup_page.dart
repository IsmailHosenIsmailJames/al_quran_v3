import "dart:developer";
import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/screen/quran_script_view/settings/quran_script_settings.dart";
import "package:al_quran_v3/src/screen/settings/settings_page.dart";
import "package:al_quran_v3/src/screen/setup/book_select_popup.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/segmented_resources_manager.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/home/home_page.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/ayah_by_ayah/ayah_by_ayah_card.dart";
import "package:al_quran_v3/src/widget/preview_quran_script/script_selection_segment_button.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  late ThemeState themeState = context.read<ThemeCubit>().state;

  @override
  void initState() {
    context.read<ResourcesProcceessCubit>().changeAppLanguage(
      context,
      context.read<LanguageCubit>().state,
    );

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    bool isLandscape = MediaQuery.of(context).size.width > 600;
    bool isSmallScreen = MediaQuery.of(context).size.height < 450;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isSmallScreen
          ? null
          : AppBar(
              elevation: 0,
              titleSpacing: 0,
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: themeState.mutedGray),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Theme.brightnessOf(context) == Brightness.dark
                  ? Colors.grey.shade900.withValues(alpha: 0.5)
                  : Colors.grey.shade200.withValues(alpha: 0.5),
              title: Text(appLocalizations.appLanguage),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                  icon: const Icon(FluentIcons.settings_24_regular),
                ),
              ],
            ),
      body: Row(
        children: [
          if (isLandscape)
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: themeState.primaryShade200,
                        blurRadius: 150,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/img/Quran_Logo_v3.png",
                    color: themeState.primary,
                  ),
                ),
              ),
            ),
          if (isLandscape) const VerticalDivider(),
          Expanded(
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
                            context
                                .read<ResourcesProcceessCubit>()
                                .changeAppLanguage(context, value);
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
                                    if (context
                                        .read<ResourcesProcceessCubit>()
                                        .doesHaveFootNote(
                                          appLoc.locale.languageCode,
                                        ))
                                      getFeaturesMark(
                                        context,
                                        appLocalizations.footnote,
                                      ),
                                    if (context
                                        .read<ResourcesProcceessCubit>()
                                        .doesHaveTafsirSupport(
                                          appLoc.locale.languageCode,
                                        ))
                                      getFeaturesMark(
                                        context,
                                        appLocalizations.tafsir,
                                      ),
                                    if (context
                                        .read<ResourcesProcceessCubit>()
                                        .doesHaveWordByWordTranslation(
                                          appLoc.locale.languageCode,
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
                  ResourcesProcceessCubit,
                  ResourcesProcceessCubitState
                >(
                  builder: (context, state) => Container(
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
                        getScriptSelectionSegmentedButtons(context),
                        getAyahByAyahCard(
                          ayahKey: "1:1",
                          context: context,
                          translationListWithInfo: [],
                          showTopOptions: false,
                          showOnlyAyah: true,
                          removeBorder: true,
                          keepMargin: false,
                          isCenter: true,
                          wordByWord: [],
                        ),
                        const Gap(10),
                        const QuranFontSelectionWidget(
                          titleStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                                            .read<ResourcesProcceessCubit>()
                                            .state
                                            .selectedTranslationResources
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
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withValues(alpha: 0.7),
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
                                            .read<ResourcesProcceessCubit>()
                                            .state
                                            .selectedTafsirResources
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
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withValues(alpha: 0.7),
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
                        SafeArea(
                          bottom: true,
                          left: false,
                          right: false,
                          top: false,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                downloadResources(
                                  context.read<ResourcesProcceessCubit>().state,
                                );
                              },
                              icon: const Icon(
                                FluentIcons.arrow_download_24_filled,
                              ),
                              label: Text(appLocalizations.saveAndDownload),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadResources(
    ResourcesProcceessCubitState processState,
  ) async {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    final resourcesProcceessCubit = context.read<ResourcesProcceessCubit>();
    if (processState.selectedTranslationResources == null ||
        processState.selectableTafsirResources == null) {
      Fluttertoast.showToast(msg: appLocalizations.pleaseSelectRequiredOption);
      return;
    }
    final userBox = Hive.box("user");
    await userBox.put("app_language", processState.appLanguageCode);

    resourcesProcceessCubit.onProcess();

    showDialog(
      barrierDismissible: false,
      context: context,
      fullscreenDialog: true,
      builder: (context) => dialogForShowDownloadProcess(),
    );
    bool success1 = await QuranTranslationFunction.downloadResources(
      context: context,
      translationBook: processState.selectedTranslationResources!,
      isSetupProcess: true,
    );
    bool success2 = await QuranTafsirFunction.downloadResources(
      context: context,
      tafsirBook: processState.selectedTafsirResources!,
      isSetupProcess: true,
    );
    ResourcesModel? supportedWbW = resourcesProcceessCubit
        .state
        .allResources[processState.appLanguageCode]
        ?.firstOrNullWhere(
          (element) => element.type == ResourceType.word_by_word,
        );
    log(supportedWbW?.fullPath ?? "Null", name: "WBW Full Path");
    bool success3 = supportedWbW != null
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

      QuranTranslationFunction.init(
        locale: context.read<LanguageCubit>().state.locale,
      );
      // success and route to home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );

      // clear process state
      context.read<ResourcesProcceessCubit>().success();
    } else {
      // error and show 'Something went wrong' in cubit
      log([success1, success2, success3, success4].toString());
      context.read<ResourcesProcceessCubit>().failure(
        appLocalizations.unableToDownloadResources,
      );
    }
  }

  Widget dialogForShowDownloadProcess() {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<ResourcesProcceessCubit, ResourcesProcceessCubitState>(
            builder: (context, state) {
              if (state.onProcess == true) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      appLocalizations.justAMoment,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Gap(20),
                    CircularProgressIndicator(
                      value: getProgressValue(state),
                      color: themeState.primary,
                      backgroundColor: themeState.primaryShade200,
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
                        downloadResources(
                          context.read<ResourcesProcceessCubit>().state,
                        );
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
  }

  double? getProgressValue(ResourcesProcceessCubitState state) {
    try {
      double? value =
          (state.percentage == null ||
              state.percentage == 0.0 ||
              state.percentage == 1.0)
          ? null
          : state.percentage;
      if (value == null) return null;
      if (value > 1) {
        return null;
      }
      return value;
    } on Exception catch (_) {
      return 0;
    }
  }
}

Widget getFeaturesMark(
  BuildContext context,
  String name, {
  bool asColumn = false,
}) {
  return Container(
    padding: asColumn
        ? const EdgeInsets.only(left: 3, right: 3, bottom: 2)
        : const EdgeInsets.only(left: 7, right: 7),
    margin: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      color: context.read<ThemeCubit>().state.primaryShade100,
      borderRadius: asColumn
          ? BorderRadius.circular(5)
          : BorderRadius.circular(100),
    ),
    child: asColumn
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
