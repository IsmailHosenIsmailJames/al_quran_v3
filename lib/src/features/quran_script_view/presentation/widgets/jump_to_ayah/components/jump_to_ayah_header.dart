import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class JumpToAyahHeader extends StatelessWidget {
  final int? selectedSurahNumber;
  final int? selectedAyahNumber;
  final bool selectMultipleAndShare;
  final bool isAudioPlayer;
  final VoidCallback onClose;

  const JumpToAyahHeader({
    super.key,
    required this.selectedSurahNumber,
    required this.selectedAyahNumber,
    required this.selectMultipleAndShare,
    required this.isAudioPlayer,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    String title;
    if (selectMultipleAndShare) {
      title = l10n.shareSelectAyahs;
    } else if (isAudioPlayer) {
      title = l10n.playFromSelectedAyah;
    } else {
      title = l10n.jumpToAyah;
    }

    String? subtitle;
    if (selectedSurahNumber != null && selectedAyahNumber != null) {
      final surahName = getSurahName(context, selectedSurahNumber!);
      final localizedSurahNum = localizedNumber(context, selectedSurahNumber!);
      subtitle =
          "$localizedSurahNum. $surahName • ${l10n.ayahCount(selectedAyahNumber!)}";
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (subtitle != null && !selectMultipleAndShare) ...[
                      const Gap(2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.75,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.black.withValues(alpha: 0.05),
                  padding: const EdgeInsets.all(8),
                  minimumSize: const Size(36, 36),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
