import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/common_functions/remove_html_tag.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_sajda.dart"
    show metaDataSajda;
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/word_by_word_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/utils/show_popup_word_function.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/fast_translation_text.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/tafsir/presentation/screens/tafsir_view.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/popups/add_to_pinned_popup.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/popups/add_note_popup.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/share_bottom_dialog.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/data/processor/script_processor.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:just_audio/just_audio.dart" as just_audio;

import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";

/// Top-level helper function for backward compatibility.
Widget getAyahByAyahCard({
  Key? key,
  required String ayahKey,
  required BuildContext context,
  bool? showFullKey,
  bool showTopOptions = true,
  bool showOnlyAyah = false,
  bool keepMargin = true,
  bool isCenter = false,
  bool removeBorder = false,
  required List<TranslationOfAyah> translationListWithInfo,
  required List wordByWord,
  bool? showBottomsheetOnTap,
}) {
  return AyahByAyahCard(
    key: key,
    ayahKey: ayahKey,
    showFullKey: showFullKey,
    showTopOptions: showTopOptions,
    showOnlyAyah: showOnlyAyah,
    keepMargin: keepMargin,
    isCenter: isCenter,
    removeBorder: removeBorder,
    translationListWithInfo: translationListWithInfo,
    wordByWord: wordByWord,
    showBottomsheetOnTap: showBottomsheetOnTap,
  );
}

/// A high-performance, modern card representing a single Ayah with
/// its Arabic calligraphy, actions toolbar, translation, footnotes, and word-by-word pills.
class AyahByAyahCard extends StatelessWidget {
  final String ayahKey;
  final bool? showFullKey;
  final bool showTopOptions;
  final bool showOnlyAyah;
  final bool keepMargin;
  final bool isCenter;
  final bool removeBorder;
  final List<TranslationOfAyah> translationListWithInfo;
  final List wordByWord;
  final bool? showBottomsheetOnTap;

  const AyahByAyahCard({
    super.key,
    required this.ayahKey,
    this.showFullKey,
    this.showTopOptions = true,
    this.showOnlyAyah = false,
    this.keepMargin = true,
    this.isCenter = false,
    this.removeBorder = false,
    required this.translationListWithInfo,
    required this.wordByWord,
    this.showBottomsheetOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;

    final parts = ayahKey.split(":");
    final int surahNumber = int.tryParse(parts.first) ?? 1;
    final int ayahNumber = int.tryParse(parts.last) ?? 1;

    final List<ResourcesModel?> translationBookInfoList =
        translationListWithInfo
            .map<ResourcesModel?>((e) => e.bookInfo)
            .toList();

    final List<String> translationList = translationListWithInfo
        .map<String>((e) => e.translation?["t"] ?? "Translation Not Found")
        .toList();

    final List<Map<int, String>> footNoteAsStringMap = [];
    for (int index = 0; index < translationListWithInfo.length; index++) {
      final Map footNote =
          translationListWithInfo[index].translation?["f"] ?? {};
      String footNoteAsString = "\n";
      if (footNote.isNotEmpty) {
        footNote.forEach((key, value) {
          footNoteAsString += "$key. $value\n";
        });
        footNoteAsStringMap.add({index: footNoteAsString});
      } else {
        footNoteAsStringMap.add({});
      }
    }

    final bool supportsWordByWord =
        WordByWordFunction.getSelectedWordByWordBook() != null;

    final SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah["$surahNumber"]!,
    );

    bool isSajdaAyah = false;
    bool isSajdaRequired = false;
    for (Map sajdaAyah in metaDataSajda) {
      if (sajdaAyah["verse_key"] == ayahKey) {
        isSajdaAyah = true;
        isSajdaRequired = sajdaAyah["required"] ?? false;
        break;
      }
    }

    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        return BlocBuilder<AyahToHighlight, String?>(
          buildWhen: (previous, current) {
            return (previous == ayahKey) || (current == ayahKey);
          },
          builder: (context, ayahToHighlightState) {
            final bool isHighlighted = ayahToHighlightState == ayahKey;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              margin: keepMargin
                  ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                  : EdgeInsets.zero,
              decoration: removeBorder
                  ? null
                  : BoxDecoration(
                      color: isHighlighted
                          ? themeState.primary.withValues(
                              alpha: isDark ? 0.12 : 0.06,
                            )
                          : (isDark ? const Color(0xFF181818) : Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isHighlighted
                            ? themeState.primary
                            : (isDark
                                  ? Colors.white.withValues(alpha: 0.07)
                                  : Colors.grey.shade200),
                        width: isHighlighted ? 1.5 : 1.0,
                      ),
                      boxShadow: [
                        if (!isDark && !isHighlighted)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Toolbar: Verse Index + Actions (Tafsir, Share, Note, Pin, Play)
                  if (showTopOptions && !quranViewState.hideToolbar)
                    _AyahToolbar(
                      ayahKey: ayahKey,
                      ayahNumber: ayahNumber,
                      surahNumber: surahNumber,
                      surahInfoModel: surahInfoModel,
                      showFullKey: showFullKey,
                      translation: translationList,
                      footNoteAsStringMap: footNoteAsStringMap,
                      translationBookInfoList: translationBookInfoList,
                      themeState: themeState,
                      isDark: isDark,
                      l10n: l10n,
                    ),

                  if (!quranViewState.hideQuranAyah) const Gap(12),

                  // Arabic Quran Script
                  if (!quranViewState.hideQuranAyah)
                    _AyahArabicSection(
                      surahNumber: surahNumber,
                      ayahNumber: ayahNumber,
                      quranViewState: quranViewState,
                      themeState: themeState,
                      isCenter: isCenter,
                      showBottomsheetOnTap: showBottomsheetOnTap,
                    ),

                  // Sajda Indicator Banner
                  if (isSajdaAyah) ...[
                    const Gap(10),
                    _SajdaBanner(
                      isSajdaRequired: isSajdaRequired,
                      themeState: themeState,
                      isDark: isDark,
                      l10n: l10n,
                    ),
                  ],

                  // Translation Section
                  if (!showOnlyAyah && !quranViewState.hideTranslation) ...[
                    const Gap(12),
                    _AyahTranslationSection(
                      translationList: translationList,
                      footNoteAsStringMap: footNoteAsStringMap,
                      translationBookInfoList: translationBookInfoList,
                      quranViewState: quranViewState,
                      showOnlyAyah: showOnlyAyah,
                      themeState: themeState,
                      isDark: isDark,
                      l10n: l10n,
                    ),
                  ],

                  // Word-by-Word Expandable Section
                  if (supportsWordByWord &&
                      !quranViewState.hideWordByWord &&
                      wordByWord.isNotEmpty) ...[
                    const Gap(8),
                    if (!quranViewState.alwaysOpenWordByWord)
                      _WordByWordExpandToggle(
                        ayahKey: ayahKey,
                        themeState: themeState,
                        l10n: l10n,
                      ),
                    const Gap(4),
                    _WordByWordContent(
                      ayahKey: ayahKey,
                      quranViewState: quranViewState,
                      wordByWord: wordByWord,
                      surahNumber: surahNumber,
                      ayahNumber: ayahNumber,
                      themeState: themeState,
                      isDark: isDark,
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Subcomponent 1: Ayah Toolbar
// ---------------------------------------------------------------------------
class _AyahToolbar extends StatelessWidget {
  final String ayahKey;
  final int ayahNumber;
  final int surahNumber;
  final SurahInfoModel surahInfoModel;
  final bool? showFullKey;
  final List<String> translation;
  final List<Map<int, String>> footNoteAsStringMap;
  final List<ResourcesModel?> translationBookInfoList;
  final ThemeState themeState;
  final bool isDark;
  final AppLocalizations l10n;

  const _AyahToolbar({
    required this.ayahKey,
    required this.ayahNumber,
    required this.surahNumber,
    required this.surahInfoModel,
    this.showFullKey,
    required this.translation,
    required this.footNoteAsStringMap,
    required this.translationBookInfoList,
    required this.themeState,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Islamic Octagonal Number Badge + Optional Full Surah/Ayah Reference

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuranIndexBadge(index: ayahNumber, size: 32),
            if (showFullKey == true) ...[
              const Gap(8),
              Flexible(
                child: Text(
                  "${getSurahName(context, surahInfoModel.id)} (${localizedNumber(context, surahNumber)}:${localizedNumber(context, ayahNumber)})",
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),

        const Gap(8),

        // Actions Row
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tafsir Action Pill
                  SizedBox(
                    height: 30,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : themeState.primary.withValues(alpha: 0.08),
                        foregroundColor: themeState.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : themeState.primary.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TafsirView(ayahKey: ayahKey),
                          ),
                        );
                      },
                      icon: const Icon(
                        FluentIcons.book_open_20_filled,
                        size: 14,
                      ),
                      label: Text(
                        l10n.tafsirButton,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Gap(4),

                  // Share Action Icon
                  _ActionIconButton(
                    icon: FluentIcons.share_20_regular,
                    tooltip: l10n.shareButton,
                    themeState: themeState,
                    isDark: isDark,
                    onTap: () {
                      showShareBottomDialog(
                        context,
                        ayahKey,
                        SurahInfoModel.fromMap(
                          metaDataSurah[surahNumber.toString()]!,
                        ),
                        context.read<QuranViewCubit>().state.quranScriptType,
                        translation,
                        footNoteAsStringMap,
                        translationBookInfoList,
                      );
                    },
                  ),
                  const Gap(4),

                  // Add Note Action Icon
                  _ActionIconButton(
                    icon: FluentIcons.note_add_20_regular,
                    tooltip: l10n.addNoteButton,
                    themeState: themeState,
                    isDark: isDark,
                    onTap: () => showAddNotePopup(context, ayahKey),
                  ),
                  const Gap(4),

                  // Pin / Bookmark Action Icon
                  _ActionIconButton(
                    icon: FluentIcons.bookmark_20_regular,
                    tooltip: l10n.pinToCollectionButton,
                    themeState: themeState,
                    isDark: isDark,
                    onTap: () => showAddToPinnedPopup(context, ayahKey),
                  ),
                  const Gap(4),

                  // Play / Audio Action Icon
                  _AyahPlayButton(
                    ayahKey: ayahKey,
                    themeState: themeState,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final ThemeState themeState;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    required this.themeState,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: IconButton(
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade100,
          foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade300,
            ),
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 16),
      ),
    );
  }
}

class _AyahPlayButton extends StatelessWidget {
  final String ayahKey;
  final ThemeState themeState;
  final bool isDark;

  const _AyahPlayButton({
    required this.ayahKey,
    required this.themeState,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerStateCubit, PlayerState>(
      builder: (context, playerState) {
        return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
          builder: (context, ayahKeyManagement) {
            final bool isPlaying = playerState.isPlaying;
            final bool isCurrent =
                ayahKeyManagement.current == ayahKey &&
                context.read<AudioUiCubit>().state.isInsideQuranPlayer == true;

            return SizedBox(
              height: 32,
              width: 32,
              child: IconButton(
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(
                  backgroundColor: isCurrent
                      ? themeState.primary
                      : (isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey.shade100),
                  foregroundColor: isCurrent
                      ? Colors.white
                      : themeState.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isCurrent
                          ? themeState.primary
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.grey.shade300),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (context.read<AudioUiCubit>().state.isInsideQuranPlayer ==
                      false) {
                    AudioPlayerManager.playSingleAyah(
                      ayahKey: ayahKey,
                      reciterInfoModel: context
                          .read<SegmentedQuranReciterCubit>()
                          .state,
                      instantPlay: true,
                      isInsideQuran: true,
                    );
                  } else if (isCurrent && isPlaying) {
                    AudioPlayerManager.audioPlayer.pause();
                  } else if (isCurrent) {
                    AudioPlayerManager.audioPlayer.play();
                  } else {
                    bool isPlayList = context
                        .read<AudioUiCubit>()
                        .state
                        .isPlayList;
                    if (isPlayList &&
                        ayahKeyManagement.current.split(":").first ==
                            ayahKey.split(":").first) {
                      await AudioPlayerManager.audioPlayer.seek(
                        Duration.zero,
                        index: ayahKeyManagement.ayahList.indexOf(ayahKey),
                      );
                      AudioPlayerManager.audioPlayer.play();
                    } else {
                      AudioPlayerManager.playSingleAyah(
                        ayahKey: ayahKey,
                        reciterInfoModel: context
                            .read<SegmentedQuranReciterCubit>()
                            .state,
                        instantPlay: true,
                        isInsideQuran: true,
                      );
                    }
                  }
                },
                icon:
                    (isCurrent &&
                        playerState.state == just_audio.ProcessingState.loading)
                    ? const SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        isPlaying && isCurrent
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 18,
                      ),
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Subcomponent 2: Arabic Script
// ---------------------------------------------------------------------------
class _AyahArabicSection extends StatelessWidget {
  final int surahNumber;
  final int ayahNumber;
  final QuranViewState quranViewState;
  final ThemeState themeState;
  final bool isCenter;
  final bool? showBottomsheetOnTap;

  const _AyahArabicSection({
    required this.surahNumber,
    required this.ayahNumber,
    required this.quranViewState,
    required this.themeState,
    required this.isCenter,
    this.showBottomsheetOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCenter ? Alignment.center : Alignment.centerRight,
      child: ScriptProcessor(
        scriptInfo: ScriptInfo(
          surahNumber: surahNumber,
          ayahNumber: ayahNumber,
          quranScriptType: quranViewState.quranScriptType,
          showWordHighlights: quranViewState.enableWordByWordHighlight == true,
          textStyle: TextStyle(
            fontSize: quranViewState.fontSize,
            height: quranViewState.lineHeight,
          ),
        ),
        showBottomsheetOnTap: showBottomsheetOnTap,
        tajweedColorEnable:
            quranViewState.quranScriptType == QuranScriptType.uthmani
            ? quranViewState.useTajweedOnUthmani
            : quranViewState.useTajweedOnIndopak,
        themeState: themeState,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Subcomponent 3: Sajda Banner
// ---------------------------------------------------------------------------
class _SajdaBanner extends StatelessWidget {
  final bool isSajdaRequired;
  final ThemeState themeState;
  final bool isDark;
  final AppLocalizations l10n;

  const _SajdaBanner({
    required this.isSajdaRequired,
    required this.themeState,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            height: 20,
            width: 20,
            image: const AssetImage("assets/img/sajadah.png"),
            color: isDark ? Colors.amber.shade300 : Colors.amber.shade800,
            colorBlendMode: BlendMode.srcIn,
          ),
          const Gap(8),
          Text(
            "${l10n.sajdaAyah} - ${isSajdaRequired ? l10n.required : l10n.optional}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.amber.shade300 : Colors.amber.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Subcomponent 4: Translation & Footnote Section
// ---------------------------------------------------------------------------
class _AyahTranslationSection extends StatelessWidget {
  final List<String> translationList;
  final List<Map<int, String>> footNoteAsStringMap;
  final List<ResourcesModel?> translationBookInfoList;
  final QuranViewState quranViewState;
  final bool showOnlyAyah;
  final ThemeState themeState;
  final bool isDark;
  final AppLocalizations l10n;

  const _AyahTranslationSection({
    required this.translationList,
    required this.footNoteAsStringMap,
    required this.translationBookInfoList,
    required this.quranViewState,
    required this.showOnlyAyah,
    required this.themeState,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(translationBookInfoList.length, (index) {
        final String translation = translationList[index];
        final Map<int, String> footNote = footNoteAsStringMap[index];
        final ResourcesModel? bookModel = translationBookInfoList[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Translation Text with Fast Zero-DOM renderer
              FastTranslationText(
                text: translation,
                style: TextStyle(
                  fontSize: quranViewState.translationFontSize,
                  height: 1.5,
                  color: isDark ? Colors.grey.shade200 : Colors.grey.shade900,
                ),
              ),

              // Footnotes if available and enabled
              if (footNote.isNotEmpty &&
                  !showOnlyAyah &&
                  !quranViewState.hideFootnote) ...[
                const Gap(8),
                _FootnoteWidget(
                  footNote: footNote,
                  quranViewState: quranViewState,
                  themeState: themeState,
                  isDark: isDark,
                  l10n: l10n,
                ),
              ],

              const Gap(4),

              // Translation Source Attribution
              Row(
                children: [
                  Container(
                    height: 1,
                    width: 18,
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                  ),
                  const Gap(6),
                  Text(
                    bookModel?.name ??
                        bookModel?.fileName.split("/").last ??
                        "",
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  if (bookModel?.language != null)
                    Text(
                      " (${languageNativeNames[bookModel!.language.toLowerCase()] ?? ""})",
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _FootnoteWidget extends StatelessWidget {
  final Map<int, String> footNote;
  final QuranViewState quranViewState;
  final ThemeState themeState;
  final bool isDark;
  final AppLocalizations l10n;

  const _FootnoteWidget({
    required this.footNote,
    required this.quranViewState,
    required this.themeState,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FluentIcons.info_16_filled,
                size: 14,
                color: themeState.primary,
              ),
              const Gap(6),
              Text(
                l10n.footNoteTitle,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: themeState.primary,
                ),
              ),
            ],
          ),
          const Gap(6),
          ...footNote.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: FastTranslationText(
                text: entry.value.trim(),
                style: TextStyle(
                  fontSize: quranViewState.translationFontSize - 1.5,
                  height: 1.4,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Subcomponent 5: Word-By-Word Section
// ---------------------------------------------------------------------------
class _WordByWordExpandToggle extends StatelessWidget {
  final String ayahKey;
  final ThemeState themeState;
  final AppLocalizations l10n;

  const _WordByWordExpandToggle({
    required this.ayahKey,
    required this.themeState,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AyahByAyahInScrollInfoCubit>().toggleWordByWord(ayahKey);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.wordByWordTranslation,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
            ),
            BlocBuilder<
              AyahByAyahInScrollInfoCubit,
              AyahByAyahInScrollInfoState
            >(
              builder: (context, scrollState) {
                final isExpanded =
                    scrollState.expandedForWordByWord?.contains(ayahKey) ==
                    true;
                return Icon(
                  isExpanded
                      ? FluentIcons.chevron_up_16_filled
                      : FluentIcons.chevron_down_16_filled,
                  size: 16,
                  color: Colors.grey.shade500,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WordByWordContent extends StatelessWidget {
  final String ayahKey;
  final QuranViewState quranViewState;
  final List<dynamic> wordByWord;
  final int surahNumber;
  final int ayahNumber;
  final ThemeState themeState;
  final bool isDark;

  const _WordByWordContent({
    required this.ayahKey,
    required this.quranViewState,
    required this.wordByWord,
    required this.surahNumber,
    required this.ayahNumber,
    required this.themeState,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AyahByAyahInScrollInfoCubit,
      AyahByAyahInScrollInfoState
    >(
      builder: (context, ayahScrollState) {
        final bool isVisible =
            (ayahScrollState.expandedForWordByWord?.contains(ayahKey) ==
                true) ||
            quranViewState.alwaysOpenWordByWord;

        if (!isVisible) return const SizedBox.shrink();

        return BlocBuilder<SegmentedQuranReciterCubit, ReciterInfoModel>(
          builder: (context, segmentsReciterState) {
            String? highlightingWordIndex;
            final List<List>? segments = context
                .read<SegmentedQuranReciterCubit>()
                .getAyahSegments(ayahKey);

            return BlocBuilder<PlayerPositionCubit, AudioPlayerPositionModel>(
              buildWhen: (previous, current) {
                final currentAyahKey = context
                    .read<AyahKeyCubit>()
                    .state
                    .current;
                if (currentAyahKey == ayahKey && segments != null) {
                  for (List word in segments) {
                    final int start = word[1].toInt();
                    final int end = word[2].toInt();
                    final cur = current.currentDuration ?? Duration.zero;
                    if (Duration(milliseconds: start) < cur &&
                        Duration(milliseconds: end) > cur) {
                      if (highlightingWordIndex !=
                          "$currentAyahKey:${word[0]}") {
                        highlightingWordIndex = "$currentAyahKey:${word[0]}";
                        return true;
                      }
                      return false;
                    }
                  }
                } else if (highlightingWordIndex != null) {
                  highlightingWordIndex = null;
                  return true;
                }
                return false;
              },
              builder: (context, playPositionState) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    textDirection: TextDirection.rtl,
                    children: List.generate(wordByWord.length, (index) {
                      final String currentWordKey =
                          "$surahNumber:$ayahNumber:${index + 1}";
                      final bool isHighlighted =
                          highlightingWordIndex == currentWordKey;

                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          final List<String> wordsKey = List.generate(
                            wordByWord.length,
                            (i) => "$surahNumber:$ayahNumber:${i + 1}",
                          );
                          showPopupWordFunction(
                            context: context,
                            wordKeys: wordsKey,
                            initWordIndex: index,
                            wordByWordList:
                                await WordByWordFunction.getAyahWordByWordData(
                                  "${wordsKey.first.split(":")[0]}:${wordsKey.first.split(":")[1]}",
                                ) ??
                                [],
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? themeState.primary.withValues(alpha: 0.15)
                                : (isDark
                                      ? Colors.white.withValues(alpha: 0.04)
                                      : themeState.primary.withValues(
                                          alpha: 0.06,
                                        )),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isHighlighted
                                  ? themeState.primary
                                  : (isDark
                                        ? Colors.white.withValues(alpha: 0.06)
                                        : themeState.primary.withValues(
                                            alpha: 0.15,
                                          )),
                              width: isHighlighted ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ScriptProcessor(
                                scriptInfo: ScriptInfo(
                                  surahNumber: surahNumber,
                                  ayahNumber: ayahNumber,
                                  quranScriptType:
                                      quranViewState.quranScriptType,
                                  wordIndex: index,
                                  textStyle: TextStyle(
                                    fontSize: quranViewState.fontSize,
                                    height: quranViewState.lineHeight,
                                  ),
                                ),
                                tajweedColorEnable:
                                    quranViewState.quranScriptType ==
                                        QuranScriptType.uthmani
                                    ? quranViewState.useTajweedOnUthmani
                                    : quranViewState.useTajweedOnIndopak,
                                themeState: themeState,
                              ),
                              const Gap(2),
                              Text(
                                removeHtmlTags(wordByWord[index].toString()),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
