import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A compact, space-efficient hero card displaying the user's latest reading position.
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
        final surahInfo =
            surahData != null ? SurahInfoModel.fromMap(surahData) : null;
        final String revelationPlace =
            surahInfo?.revelationPlace.toLowerCase() ?? "makkah";
        final isMakkah = revelationPlace == "makkah";
        final int versesCount = surahInfo?.versesCount ?? 7;

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
                endKey: getEndAyahKeyFromSurahNumber(surahNumber),
                toScrollKey: toScroll,
              ),
            ),
          );
        }

        final double readingProgress =
            (hasHistory && ayahNumber != null && versesCount > 0)
                ? (ayahNumber / versesCount).clamp(0.01, 1.0)
                : 0.0;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      themeState.primary.withValues(alpha: 0.25),
                      themeState.primary.withValues(alpha: 0.12),
                      themeState.primary.withValues(alpha: 0.05),
                    ]
                  : [
                      themeState.primary.withValues(alpha: 0.10),
                      themeState.primary.withValues(alpha: 0.03),
                      Colors.white,
                    ],
            ),
            border: Border.all(
              color: themeState.primary.withValues(alpha: isDark ? 0.30 : 0.16),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? themeState.primary.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.025),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onResume,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 10.0,
                ),
                child: Stack(
                  children: [
                    // Watermark Quran Calligraphy in background
                    Positioned(
                      right: 70,
                      top: -12,
                      child: Opacity(
                        opacity: isDark ? 0.09 : 0.05,
                        child: Text(
                          "surah${surahNumber.toString().padLeft(3, '0')}",
                          style: TextStyle(
                            fontFamily: "surah-name-v1",
                            fontSize: 68,
                            color: themeState.primary,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        // Icon Container
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(
                              alpha: isDark ? 0.22 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(
                            FluentIcons.book_pulse_24_filled,
                            size: 19,
                            color: themeState.primary,
                          ),
                        ),

                        const Gap(12),

                        // Title & Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                surahLocalized,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.grey.shade900,
                                ),
                              ),
                              const Gap(3),
                              Row(
                                children: [
                                  Text(
                                    isMakkah
                                        ? "🕋 ${l10n.makki}"
                                        : "🕌 ${l10n.madani}",
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  const Gap(6),
                                  Text(
                                    "•",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                  const Gap(6),
                                  Expanded(
                                    child: Text(
                                      pageNumber != null
                                          ? "${l10n.page} ${localizedNumber(context, pageNumber)}"
                                          : (ayahNumber != null
                                              ? "${l10n.ayah} ${localizedNumber(context, ayahNumber)} (${l10n.verses}: ${localizedNumber(context, versesCount)})"
                                              : "${l10n.verses}: ${localizedNumber(context, versesCount)}"),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (hasHistory && ayahNumber != null) ...[
                                const Gap(5),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: readingProgress,
                                    minHeight: 3.5,
                                    backgroundColor: themeState.primary
                                        .withValues(
                                          alpha: isDark ? 0.2 : 0.12,
                                        ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      themeState.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const Gap(10),

                        // Action Button
                        ElevatedButton(
                          onPressed: onResume,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeState.primary,
                            foregroundColor: Colors.white,
                            elevation: 1.5,
                            shadowColor: themeState.primary.withValues(
                              alpha: 0.35,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(0, 34),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                FluentIcons.play_24_filled,
                                size: 12,
                              ),
                              const Gap(4),
                              Text(
                                hasHistory ? l10n.resume : l10n.startReading,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
