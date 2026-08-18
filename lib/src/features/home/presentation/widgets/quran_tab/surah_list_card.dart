import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A modern card displaying Surah metadata, full localized title, and Arabic calligraphy.
class SurahListCard extends StatelessWidget {
  final SurahInfoModel surah;

  const SurahListCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final String localizedName = getSurahName(context, surah.id);
    final String surahMeaning = getSurahMeaning(context, surah.id);

    final bool isMakkah = surah.revelationPlace.toLowerCase() == "makkah";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.035) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
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
                  startKey: "${surah.id}:1",
                  endKey: "${surah.id}:${surah.versesCount}",
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                // Geometric Islamic index badge
                QuranIndexBadge(index: surah.id, size: 40),

                const Gap(14),

                // Surah Name, Meaning, Revelation & Verse Count
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Surah Name
                      Text(
                        localizedName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                      if (surahMeaning.isNotEmpty) ...[
                        const Gap(2),
                        Text(
                          surahMeaning,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                      const Gap(4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: themeState.primary.withValues(
                                alpha: isDark ? 0.15 : 0.08,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isMakkah ? "🕋" : "🕌",
                                  style: const TextStyle(fontSize: 9),
                                ),
                                const Gap(3),
                                Text(
                                  isMakkah ? l10n.makki : l10n.madani,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: themeState.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          Text(
                            "${localizedNumber(context, surah.versesCount)} ${l10n.verses}",
                            style: TextStyle(
                              fontSize: 11.5,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Gap(8),

                // Arabic Calligraphy Name (surah-name-v1)
                Text(
                  "surah${surah.id.toString().padLeft(3, '0')}",
                  style: const TextStyle(
                    fontFamily: "surah-name-v1",
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
