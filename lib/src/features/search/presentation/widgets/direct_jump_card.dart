import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A prominent shortcut card shown when user query directly matches a verse reference.
class DirectAyahJumpCard extends StatelessWidget {
  final DirectAyahJumpModel directJump;
  final VoidCallback? onResultSelected;

  const DirectAyahJumpCard({
    super.key,
    required this.directJump,
    this.onResultSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final surahData = metaDataSurah[directJump.surahNumber.toString()];
    final totalVerses = surahData != null
        ? (surahData["verses_count"] as int? ?? 7)
        : 7;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: themeState.primary.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: themeState.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              QuranIndexBadge(
                index: directJump.ayahNumber,
                size: 36,
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FluentIcons.arrow_turn_down_right_20_filled,
                          size: 14,
                          color: themeState.primary,
                        ),
                        const Gap(4),
                        Text(
                          l10n.jumpToAyah,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: themeState.primary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(2),
                    Text(
                      "${directJump.surahName} (${localizedNumber(context, directJump.surahNumber)}:${localizedNumber(context, directJump.ayahNumber)})",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeState.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  onResultSelected?.call();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuranScriptView(
                        startKey: "${directJump.surahNumber}:1",
                        endKey: "${directJump.surahNumber}:$totalVerses",
                        toScrollKey: directJump.ayahKey,
                      ),
                    ),
                  );
                },
                icon: const Icon(FluentIcons.open_20_filled, size: 16),
                label: const Text(
                  "Open",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (directJump.previewArabic != null &&
              directJump.previewArabic!.isNotEmpty) ...[
            const Gap(10),
            Text(
              directJump.previewArabic!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "QPC_Hafs",
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade900,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
