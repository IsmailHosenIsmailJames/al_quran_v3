import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class SelectedAyahsChips extends StatelessWidget {
  final List<String> selectedAyahKeys;
  final ThemeState themeState;
  final Function(String ayahKey) onRemoveAyah;
  final VoidCallback onClearAll;

  const SelectedAyahsChips({
    super.key,
    required this.selectedAyahKeys,
    required this.themeState,
    required this.onRemoveAyah,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : themeState.primaryShade100.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(roundedRadius),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : themeState.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FluentIcons.checkbox_checked_20_filled,
                    size: 16,
                    color: themeState.primary,
                  ),
                  const Gap(6),
                  Text(
                    "Selected: ${selectedAyahKeys.length}",
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeState.primary,
                    ),
                  ),
                ],
              ),
              if (selectedAyahKeys.isNotEmpty)
                InkWell(
                  onTap: onClearAll,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Text(
                      l10n.delete,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(8),
          if (selectedAyahKeys.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                l10n.selectionEmpty,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: selectedAyahKeys.length,
                separatorBuilder: (context, index) => const Gap(6),
                itemBuilder: (context, index) {
                  final key = selectedAyahKeys[index];
                  final parts = key.split(":");
                  final surahId = int.tryParse(parts.first) ?? 1;
                  final ayahId = int.tryParse(parts.length > 1 ? parts.last : "1") ?? 1;
                  final surahName = getSurahName(context, surahId);
                  final label = "$surahName ${localizedNumber(context, ayahId)}";

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: themeState.primary.withValues(alpha: isDark ? 0.25 : 0.15),
                      borderRadius: BorderRadius.circular(roundedRadius),
                      border: Border.all(
                        color: themeState.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : themeState.primary,
                          ),
                        ),
                        const Gap(4),
                        InkWell(
                          onTap: () => onRemoveAyah(key),
                          borderRadius: BorderRadius.circular(10),
                          child: Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: isDark ? Colors.white70 : themeState.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
