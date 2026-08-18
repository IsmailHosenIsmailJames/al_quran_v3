import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A modern hero card displaying the user's latest reading position with quick resume.
class ContinueReadingHeroCard extends StatelessWidget {
  const ContinueReadingHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuranHistoryCubit, QuranHistoryState>(
      builder: (context, historyState) {
        final hasHistory = historyState.history.isNotEmpty;
        final latest = hasHistory ? historyState.history.last : null;

        final int surahNumber = latest?.surahNumber ?? 1;
        final int? ayahNumber = latest?.ayahNumber;
        final int? pageNumber = latest?.pageNumber;

        final surahData = metaDataSurah[surahNumber.toString()];
        final String revelationPlace =
            surahData?["revelation_place"]?.toString().toLowerCase() ?? "makkah";
        final isMakkah = revelationPlace == "makkah";
        final int versesCount =
            int.tryParse(surahData?["verses_count"]?.toString() ?? "7") ?? 7;

        final surahLocalized = getSurahName(context, surahNumber);

        void onResume() {
          final toScroll = ayahNumber != null
              ? "$surahNumber:$ayahNumber"
              : (pageNumber != null ? "$surahNumber:1" : "$surahNumber:1");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuranScriptView(
                startKey: "$surahNumber:1",
                endKey: "$surahNumber:$versesCount",
                toScrollKey: toScroll,
              ),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      themeState.primary.withValues(alpha: 0.28),
                      themeState.primary.withValues(alpha: 0.16),
                      themeState.primary.withValues(alpha: 0.08),
                    ]
                  : [
                      themeState.primary.withValues(alpha: 0.10),
                      themeState.primary.withValues(alpha: 0.04),
                      Colors.white,
                    ],
            ),
            border: Border.all(
              color: themeState.primary.withValues(alpha: isDark ? 0.35 : 0.18),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? themeState.primary.withValues(alpha: 0.14)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onResume,
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stack(
                  children: [
                    // Watermark Quran Calligraphy icon in background
                    Positioned(
                      right: -10,
                      bottom: -15,
                      child: Opacity(
                        opacity: isDark ? 0.07 : 0.05,
                        child: Icon(
                          FluentIcons.book_open_24_regular,
                          size: 130,
                          color: themeState.primary,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: Section title & Makki/Madani badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: themeState.primary.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    FluentIcons.book_pulse_24_filled,
                                    size: 16,
                                    color: themeState.primary,
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  hasHistory
                                      ? l10n.lastRead.toUpperCase()
                                      : l10n.startReading.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    color: themeState.primary,
                                  ),
                                ),
                              ],
                            ),

                            // Revelation place pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.08)
                                    : Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: themeState.primary.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isMakkah ? "🕋" : "🕌",
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  const Gap(4),
                                  Text(
                                    isMakkah ? l10n.makki : l10n.madani,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const Gap(14),

                        // Surah Title & Verse / Page Detail
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    surahLocalized,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.grey.shade900,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    pageNumber != null
                                        ? "${l10n.page} ${localizedNumber(context, pageNumber)}"
                                        : (ayahNumber != null
                                            ? "${l10n.ayah} ${localizedNumber(context, ayahNumber)} (${l10n.verses}: ${localizedNumber(context, versesCount)})"
                                            : "${l10n.verses}: ${localizedNumber(context, versesCount)}"),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Resume Button Action Pill
                            ElevatedButton.icon(
                              onPressed: onResume,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.primary,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shadowColor: themeState.primary.withValues(alpha: 0.4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(
                                FluentIcons.play_24_filled,
                                size: 14,
                              ),
                              label: Text(
                                hasHistory ? l10n.resume : l10n.startReading,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ),
        );
      },
    );
  }
}
