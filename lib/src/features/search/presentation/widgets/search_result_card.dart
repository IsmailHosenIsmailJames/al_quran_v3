import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/popups/add_to_pinned_popup.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";
import "package:al_quran_v3/src/features/search/domain/utils/text_highlighter.dart";
import "package:al_quran_v3/src/features/tafsir/presentation/screens/tafsir_view.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A rich, interactive card displaying an Ayah match with highlighted search tokens.
class SearchResultCard extends StatelessWidget {
  final AyahSearchResultModel ayahResult;
  final String query;

  const SearchResultCard({
    super.key,
    required this.ayahResult,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final surahName = getSurahName(context, ayahResult.surahNumber);
    final surahData = metaDataSurah[ayahResult.surahNumber.toString()];
    final totalVerses = surahData != null
        ? (surahData["verses_count"] as int? ?? 7)
        : 7;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF181818) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranScriptView(
                  startKey: "${ayahResult.surahNumber}:1",
                  endKey: "${ayahResult.surahNumber}:$totalVerses",
                  toScrollKey: ayahResult.ayahKey,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Header: Index Badge + Surah/Ayah Title + Quick Actions
                Row(
                  children: [
                    QuranIndexBadge(
                      index: ayahResult.ayahNumber,
                      size: 34,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$surahName (${localizedNumber(context, ayahResult.surahNumber)}:${localizedNumber(context, ayahResult.ayahNumber)})",
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.grey.shade900,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            "${l10n.juz} ${localizedNumber(context, ayahResult.juzNumber)} • ${l10n.page} ${localizedNumber(context, ayahResult.pageNumber)}",
                            style: TextStyle(
                              fontSize: 11.5,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action Buttons (Tafsir, Pin, Copy)
                    _QuickActionIconButton(
                      icon: FluentIcons.book_open_20_regular,
                      tooltip: l10n.tafsir,
                      themeState: themeState,
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TafsirView(
                              ayahKey: ayahResult.ayahKey,
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(6),
                    _QuickActionIconButton(
                      icon: FluentIcons.bookmark_20_regular,
                      tooltip: l10n.pinned,
                      themeState: themeState,
                      isDark: isDark,
                      onTap: () => showAddToPinnedPopup(context, ayahResult.ayahKey),
                    ),
                    const Gap(6),
                    _QuickActionIconButton(
                      icon: FluentIcons.copy_20_regular,
                      tooltip: "Copy Text",
                      themeState: themeState,
                      isDark: isDark,
                      onTap: () {
                        final buffer = StringBuffer();
                        buffer.writeln(ayahResult.arabicText);
                        for (final t in ayahResult.translationMatches) {
                          buffer.writeln(t.text);
                        }
                        buffer.write("($surahName ${ayahResult.ayahKey})");
                        Clipboard.setData(ClipboardData(text: buffer.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Ayah copied to clipboard"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const Gap(12),

                // Arabic Text with Token Highlight
                if (ayahResult.arabicText.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        children: TextHighlighter.highlight(
                          text: ayahResult.arabicText,
                          query: query,
                          baseStyle: TextStyle(
                            fontSize: 19,
                            fontFamily: "QPC_Hafs",
                            height: 1.6,
                            color: isDark ? Colors.grey.shade200 : Colors.grey.shade900,
                          ),
                          highlightColor: themeState.primary,
                          highlightBgColor: themeState.primary.withValues(
                            alpha: isDark ? 0.2 : 0.12,
                          ),
                        ),
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const Gap(10),
                ],

                // Translation Matches Section
                if (ayahResult.translationMatches.isNotEmpty) ...[
                  ...ayahResult.translationMatches.map((t) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: TextHighlighter.highlight(
                                text: t.text,
                                query: query,
                                baseStyle: TextStyle(
                                  fontSize: 13.5,
                                  height: 1.45,
                                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                                ),
                                highlightColor: themeState.primary,
                                highlightBgColor: themeState.primary.withValues(
                                  alpha: isDark ? 0.2 : 0.12,
                                ),
                              ),
                            ),
                          ),
                          if (t.footnote != null && t.matchedInFootnote) ...[
                            const Gap(4),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.03)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text.rich(
                                TextSpan(
                                  children: TextHighlighter.highlight(
                                    text: t.footnote!,
                                    query: query,
                                    baseStyle: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                                    ),
                                    highlightColor: themeState.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const Gap(3),
                          Text(
                            "— ${t.bookInfo.name} (${t.bookInfo.language})",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],

                // Tafsir Matches Section
                if (ayahResult.tafsirMatches.isNotEmpty) ...[
                  const Gap(6),
                  ...ayahResult.tafsirMatches.map((tafsir) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.03)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FluentIcons.book_open_16_filled,
                                size: 14,
                                color: themeState.primary,
                              ),
                              const Gap(6),
                              Text(
                                tafsir.bookInfo.name,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.primary,
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          Text.rich(
                            TextSpan(
                              children: TextHighlighter.highlight(
                                text: tafsir.text,
                                query: query,
                                baseStyle: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.4,
                                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                                ),
                                highlightColor: themeState.primary,
                                highlightBgColor: themeState.primary.withValues(
                                  alpha: isDark ? 0.2 : 0.12,
                                ),
                              ),
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final ThemeState themeState;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickActionIconButton({
    required this.icon,
    required this.tooltip,
    required this.themeState,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: IconButton(
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade100,
          foregroundColor: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.07)
                  : Colors.grey.shade300,
            ),
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 15),
      ),
    );
  }
}
