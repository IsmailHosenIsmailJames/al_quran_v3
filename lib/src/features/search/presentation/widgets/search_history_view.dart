import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Widget displaying recent search history and clean guide placeholder.
class SearchHistoryView extends StatelessWidget {
  final List<String> history;
  final ValueChanged<String> onQuerySelected;
  final ValueChanged<String> onDeleteHistoryItem;
  final VoidCallback onClearAllHistory;

  const SearchHistoryView({
    super.key,
    required this.history,
    required this.onQuerySelected,
    required this.onDeleteHistoryItem,
    required this.onClearAllHistory,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      children: [
        // 1. Recent Searches (if available)
        if (history.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FluentIcons.history_20_regular,
                    size: 18,
                    color: themeState.primary,
                  ),
                  const Gap(8),
                  Text(
                    l10n.recentSearches,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: onClearAllHistory,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.clearAll,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: themeState.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: history.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                child: InkWell(
                  onTap: () => onQuerySelected(item),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 4,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade200
                                : Colors.grey.shade800,
                          ),
                        ),
                        const Gap(4),
                        InkWell(
                          onTap: () => onDeleteHistoryItem(item),
                          borderRadius: BorderRadius.circular(100),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              FluentIcons.dismiss_12_regular,
                              size: 14,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Gap(24),
        ],

        // 2. Clean Search Guide Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      FluentIcons.search_info_24_regular,
                      size: 20,
                      color: themeState.primary,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      l10n.searchGuideTitle,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Text(
                l10n.searchGuideDescription,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
