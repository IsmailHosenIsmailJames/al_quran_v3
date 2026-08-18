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

/// A horizontal slider displaying recent reading sessions with compact cards.
class QuranHistoryCarousel extends StatelessWidget {
  const QuranHistoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuranHistoryCubit, QuranHistoryState>(
      builder: (context, historyState) {
        if (historyState.history.isEmpty) {
          return const SizedBox.shrink();
        }

        final recentItems = historyState.history.reversed.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    FluentIcons.history_24_regular,
                    size: 18,
                    color: themeState.primary,
                  ),
                  const Gap(6),
                  Text(
                    l10n.history,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(6),
            SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: recentItems.length,
                separatorBuilder: (context, index) => const Gap(8),
                itemBuilder: (context, index) {
                  final item = recentItems[index];
                  final surahName = getSurahName(context, item.surahNumber);
                  final surahData = metaDataSurah[item.surahNumber.toString()];
                  final int versesCount = int.tryParse(
                        surahData?["verses_count"]?.toString() ?? "7",
                      ) ??
                      7;

                  final label = item.pageNumber != null
                      ? "$surahName • ${l10n.page} ${localizedNumber(context, item.pageNumber)}"
                      : "$surahName • ${l10n.ayah} ${localizedNumber(context, item.ayahNumber ?? 1)}";

                  return InkWell(
                    onTap: () {
                      final toScroll = item.ayahNumber != null
                          ? "${item.surahNumber}:${item.ayahNumber}"
                          : "${item.surahNumber}:1";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuranScriptView(
                            startKey: "${item.surahNumber}:1",
                            endKey: "${item.surahNumber}:$versesCount",
                            toScrollKey: toScroll,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.grey.shade300,
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FluentIcons.book_open_20_regular,
                            size: 15,
                            color: themeState.primary,
                          ),
                          const Gap(6),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey.shade200
                                  : Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(10),
          ],
        );
      },
    );
  }
}
