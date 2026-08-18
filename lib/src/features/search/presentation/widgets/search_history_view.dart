import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Widget displaying recent search history and popular Quranic suggestion chips.
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

  static const List<Map<String, String>> _suggestedTopics = [
    {"label": "Ayatul Kursi (2:255)", "query": "2:255"},
    {"label": "Surah Al-Kahf", "query": "Kahf"},
    {"label": "Surah Ar-Rahman", "query": "Rahman"},
    {"label": "Surah Yaseen", "query": "Yasin"},
    {"label": "Surah Al-Mulk", "query": "Mulk"},
    {"label": "Patience & Prayer", "query": "patience prayer"},
    {"label": "Mercy of Allah", "query": "mercy"},
    {"label": "Forgiveness", "query": "forgiveness"},
    {"label": "Paradise", "query": "paradise"},
    {"label": "Gratitude", "query": "grateful"},
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      children: [
        // 1. Recent Searches
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
                  const Gap(6),
                  Text(
                    "Recent Searches",
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
                  "Clear All",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: themeState.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: history.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
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
          const Gap(20),
        ],

        // 2. Popular Topics & Suggestions
        Row(
          children: [
            Icon(
              FluentIcons.sparkle_20_regular,
              size: 18,
              color: themeState.primary,
            ),
            const Gap(6),
            Text(
              "Popular Topics & Surahs",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
          ],
        ),
        const Gap(10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _suggestedTopics.map((topic) {
            return InkWell(
              onTap: () => onQuerySelected(topic["query"]!),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.07)
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
                child: Text(
                  topic["label"]!,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
