import "dart:developer";
import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/chapter_header_meta.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/core/widgets/get_surah_index_widget.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/reciter_view_widget.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/filter_surah.dart";
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
  final TextEditingController _searchController = TextEditingController();
  final Map<int, GlobalKey> _keysOfAllSurah = {};

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 114; i++) {
      _keysOfAllSurah[i] = GlobalKey();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.reciterInfoModel != null) {
        context.read<AudioTabReciterCubit>().changeReciter(
              widget.reciterInfoModel!,
            );
      }
      if (widget.initDownloadSurah != null) {
        final key = _keysOfAllSurah[widget.initDownloadSurah!.id];
        if (key?.currentContext != null) {
          await Scrollable.ensureVisible(
            key!.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          if (mounted) {
            await _onDownloadButtonPressed(
              context,
              AppLocalizations.of(context),
              widget.initDownloadSurah!,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.read<ThemeCubit>().state;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredSurahs = getFilteredSurah(
      context,
      _searchController.text.trim(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.audioDownload,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 40,
          left: 14,
          right: 14,
        ),
        children: [
          // Reciter Selector Card
          BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
            builder: (context, ayahKeyState) {
              final currentIndex =
                  int.parse(ayahKeyState.current.split(":")[1]) - 1;
              return getReciterViewWidget(
                context,
                ayahKeyState,
                currentIndex,
                showDownloadIconButton: false,
                showSettingsIconButton: false,
              );
            },
          ),
          const Gap(14),

          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: l10n.searchForASurah,
              prefixIcon: const Icon(FluentIcons.search_20_regular, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : themeState.primaryShade100.withValues(alpha: 0.35),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const Gap(14),

          // Surahs List
          ...filteredSurahs.map(
            (surah) => _buildSurahCard(
              context,
              surah,
              l10n,
              themeState,
              isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahCard(
    BuildContext context,
    SurahInfoModel surah,
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
  ) {
    return BlocBuilder<AudioDownloadCubit, AudioDownloadState>(
      builder: (context, downloadState) {
        return FutureBuilder<int>(
          key: _keysOfAllSurah[surah.id],
          future: _getFilesCount(
            context.read<AudioTabReciterCubit>().state,
            surah,
          ),
          builder: (context, snapshot) {
            final downloadedCount = snapshot.data ?? 0;
            final isAllDownloaded =
                surah.versesCount > 0 && surah.versesCount <= downloadedCount;
            final isDownloadingThis = downloadState.isDownloading &&
                downloadState.surahNumber == surah.id;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedRadius),
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : Colors.white,
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.black.withValues(alpha: 0.06),
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Surah Number
                    getIndexNumberWidget(
                      context,
                      surah.id,
                      textColor: isDark ? Colors.white : Colors.black87,
                      height: 38,
                      width: 38,
                    ),
                    const Gap(12),

                    // Surah Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                getSurahName(context, surah.id),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                chapterHeaderCodes[surah.id - 1],
                                style: const TextStyle(
                                  fontFamily: "SurahName",
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                          const Gap(2),
                          Text(
                            "${getSurahMeaning(context, surah.id)} • ${localizedNumber(context, downloadedCount)}/${l10n.ayahsCount(localizedNumber(context, surah.versesCount))}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),

                    // Action / Status
                    if (isAllDownloaded)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: themeState.primary.withValues(alpha: 0.15),
                            ),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 20,
                              color: themeState.primary,
                            ),
                          ),
                          const Gap(4),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            tooltip: l10n.delete,
                            onPressed: () => _confirmDeleteSurah(context, surah, l10n),
                            icon: const Icon(
                              FluentIcons.delete_20_regular,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ],
                      )
                    else if (isDownloadingThis)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              value: downloadState.progress > 0
                                  ? downloadState.progress
                                  : null,
                              color: themeState.primary,
                              backgroundColor:
                                  themeState.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          const Gap(4),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            tooltip: l10n.cancel,
                            onPressed: () {
                              AudioPlayerManager.cancelDownload();
                              context
                                  .read<AudioDownloadCubit>()
                                  .updateIsDownloading(false);
                              context
                                  .read<AudioDownloadCubit>()
                                  .updateProgress(0.0);
                              context
                                  .read<AudioDownloadCubit>()
                                  .updateDownloadingSurahNumber(0);
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ],
                      )
                    else
                      IconButton.filledTonal(
                        visualDensity: VisualDensity.compact,
                        tooltip: l10n.download,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              themeState.primary.withValues(alpha: 0.15),
                          foregroundColor: themeState.primary,
                        ),
                        onPressed: () async {
                          await _onDownloadButtonPressed(context, l10n, surah);
                        },
                        icon: const Icon(
                          FluentIcons.arrow_download_20_regular,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _confirmDeleteSurah(
    BuildContext context,
    SurahInfoModel surah,
    AppLocalizations l10n,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(l10n.areYouSure),
          content: Text(
            "Delete downloaded audio files for ${getSurahName(context, surah.id)}?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                final path =
                    AudioPlayerManager.getExpectedSurahDirectoryLocation(
                  surahInfoModel: surah,
                  reciterInfoModel:
                      context.read<AudioTabReciterCubit>().state,
                );
                if (path != null) {
                  final dir = Directory(path);
                  if (await dir.exists()) {
                    await dir.delete(recursive: true);
                  }
                }
                Navigator.pop(dialogContext);
                if (mounted) setState(() {});
              },
              child: Text(l10n.delete),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onDownloadButtonPressed(
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

    log("Downloading Audio Files for Surah ${surah.id}", name: "Audio");

    await AudioPlayerManager.downloadSurah(
      surahInfoModel: surah,
      reciterInfoModel: context.read<AudioTabReciterCubit>().state,
      audioDownloadCubit: audioDownloadCubit,
    );

    audioDownloadCubit.updateIsDownloading(false);
    audioDownloadCubit.updateDownloadingSurahNumber(0);
    if (mounted) setState(() {});
  }

  Future<int> _getFilesCount(
    ReciterInfoModel reciter,
    SurahInfoModel surah,
  ) async {
    final path = AudioPlayerManager.getExpectedSurahDirectoryLocation(
      surahInfoModel: surah,
      reciterInfoModel: reciter,
    );
    if (path == null) return 0;
    final dir = Directory(path);
    if (await dir.exists()) {
      return dir.listSync().length;
    }
    return 0;
  }
}
