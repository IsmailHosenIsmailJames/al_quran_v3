import "dart:developer";
import "dart:io";
import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/core/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/filter/filter_surah.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/widget/components/get_surah_index_widget.dart";
import "package:al_quran_v3/src/widget/components/reciter_overview.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";

class AudioDownloadScreen extends StatefulWidget {
  final SurahInfoModel? initDownloadSurah;
  final ReciterInfoModel? reciterInfoModel;
  const AudioDownloadScreen({
    super.key,
    this.initDownloadSurah,
    this.reciterInfoModel,
  });

  @override
  State<AudioDownloadScreen> createState() => _AudioDownloadScreenState();
}

class _AudioDownloadScreenState extends State<AudioDownloadScreen> {
  final TextEditingController searchController = TextEditingController();
  Map<int, GlobalKey> keysOfAllSurah = {};
  @override
  void initState() {
    for (int i = 0; i < 114; i++) {
      keysOfAllSurah.addAll({i + 1: GlobalKey()});
    }
    // scroll after widgets build complete
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.reciterInfoModel != null) {
        context.read<AudioTabReciterCubit>().changeReciter(
          widget.reciterInfoModel!,
        );
      }
      log("Changes reciter", name: "Audio");
      if (widget.initDownloadSurah != null) {
        final key = keysOfAllSurah[widget.initDownloadSurah!.id];
        log(key?.currentContext.toString() ?? "null");
        if (key != null && key.currentContext != null) {
          await Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          log("Scrolling finished to specific surah");
          await onDownloadButtonPressed(
            context,
            AppLocalizations.of(context),
            widget.initDownloadSurah!,
          );
        }
      } else {
        log("No Surah required to download", name: "Audio");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    late final themeState = context.read<ThemeCubit>().state;
    Brightness brightness = Theme.of(context).brightness;
    Color textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    List<SurahInfoModel> filteredSurah = getFilteredSurah(
      context,
      searchController.text.trim(),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: themeState.primaryShade100),
          ),
        ),
        title: Text(l10n.audioDownload),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          bottom: 100.0,
          left: 15,
          right: 15,
          top: MediaQuery.of(context).padding.top + 70,
        ),
        itemCount: 114 + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
              builder: (context, ayahKeyState) {
                int currentIndex =
                    int.parse(ayahKeyState.current.split(":")[1]) - 1;
                return getReciterViewWidget(
                  context,
                  ayahKeyState,
                  currentIndex,
                  showDownloadIconButton: false,
                  showSettingsIconButton: false,
                );
              },
            );
          }
          if (index == 1) {
            return const Gap(10);
          }
          if (index == 2) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 5,
                right: 5,
              ),
              child: SearchBar(
                elevation: WidgetStateProperty.all<double?>(0),
                hintText: l10n.searchForASurah,
                controller: searchController,
                backgroundColor: WidgetStateProperty.all<Color?>(
                  themeState.primaryShade100,
                ),
                leading: const Icon(FluentIcons.search_24_filled),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            );
          }
          index = index - 3;
          return BlocBuilder<AudioDownloadCubit, AudioDownloadState>(
            builder:
                (context, state) => getSurahWidget(
                  context,
                  index,
                  l10n,
                  filteredSurah,
                  textColor,
                  state,
                  themeState,
                ),
          );
        },
      ),
    );
  }

  Widget getSurahWidget(
    BuildContext context,
    int index,
    AppLocalizations l10n,
    List<SurahInfoModel> filteredSurah,
    Color textColor,
    AudioDownloadState state,
    ThemeState themeState,
  ) {
    return FutureBuilder(
      key: keysOfAllSurah[filteredSurah[index].id],
      future: getFilesCount(
        context.read<AudioTabReciterCubit>().state,
        filteredSurah[index],
      ),
      builder: (context, snapshot) {
        bool isAllDownloaded =
            filteredSurah[index].versesCount <= (snapshot.data?.toInt() ?? 0);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          title: Text(getSurahName(context, index + 1)),
          subtitle: Text(
            "${getSurahMeaning(context, index + 1)}\n${localizedNumber(context, snapshot.data ?? 0)}/${l10n.ayahsCount(localizedNumber(context, filteredSurah[index].versesCount))}",
          ),
          leading: getIndexNumberWidget(
            context,
            filteredSurah[index].id,
            textColor: textColor,
            height: 40,
            width: 40,
          ),
          trailing:
              isAllDownloaded
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: themeState.primary),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(l10n.areYouSure),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(l10n.cancel),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      String? path =
                                          AudioPlayerManager.getExpectedSurahDirectoryLocation(
                                            surahInfoModel:
                                                filteredSurah[index],
                                            reciterInfoModel:
                                                context
                                                    .read<
                                                      AudioTabReciterCubit
                                                    >()
                                                    .state,
                                          );
                                      if (path == null) return;
                                      final files = Directory(path).listSync();
                                      for (final e in files) {
                                        await e.delete();
                                      }
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text(l10n.delete),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          FluentIcons.delete_24_filled,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                  : (state.isDownloading &&
                      state.surahNumber == filteredSurah[index].id)
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          value: state.progress,
                          color: themeState.primary,
                          backgroundColor: themeState.primaryShade100,
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: themeState.primaryShade100,
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          AudioPlayerManager.cancelDownload();
                          context
                              .read<AudioDownloadCubit>()
                              .updateIsDownloading(false);
                          context.read<AudioDownloadCubit>().updateProgress(
                            0.0,
                          );
                          context
                              .read<AudioDownloadCubit>()
                              .updateDownloadingSurahNumber(0);
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ],
                  )
                  : IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: themeState.primaryShade100,
                    ),
                    onPressed: () async {
                      await onDownloadButtonPressed(
                        context,
                        l10n,
                        filteredSurah[index],
                      );
                    },
                    icon: const Icon(FluentIcons.arrow_download_24_filled),
                  ),
        );
      },
    );
  }

  Future<void> onDownloadButtonPressed(
    BuildContext context,
    AppLocalizations l10n,
    SurahInfoModel surah,
  ) async {
    final audioDownloadCubit = context.read<AudioDownloadCubit>();
    if (audioDownloadCubit.state.isDownloading) {
      Fluttertoast.showToast(msg: l10n.waitForCurrentDownloadToFinish);
      return;
    }

    audioDownloadCubit.updateIsDownloading(true);
    audioDownloadCubit.updateDownloadingSurahNumber(surah.id);

    log("Downloading Audio Files", name: "Audio");

    await AudioPlayerManager.downloadSurah(
      surahInfoModel: surah,
      reciterInfoModel: context.read<AudioTabReciterCubit>().state,
      audioDownloadCubit: audioDownloadCubit,
    );
    audioDownloadCubit.updateIsDownloading(false);
    audioDownloadCubit.updateDownloadingSurahNumber(0);
    return;
  }

  Future<int> getFilesCount(
    ReciterInfoModel reciter,
    SurahInfoModel surah,
  ) async {
    String? path = AudioPlayerManager.getExpectedSurahDirectoryLocation(
      surahInfoModel: surah,
      reciterInfoModel: reciter,
    );
    if (path == null) return 0;
    final dir = Directory(path);
    if (await dir.exists()) {
      return dir.listSync().length;
    } else {
      return 0;
    }
  }
}
