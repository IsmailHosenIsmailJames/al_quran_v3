import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A modern, responsive horizontal scope tab selector for Quran search.
class SearchScopeTabs extends StatelessWidget {
  final SearchScope activeScope;
  final ValueChanged<SearchScope> onScopeSelected;

  const SearchScopeTabs({
    super.key,
    required this.activeScope,
    required this.onScopeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final tabs = [
      _ScopeTabItem(
        scope: SearchScope.all,
        label: l10n.searchAll,
        icon: FluentIcons.globe_search_20_regular,
      ),
      _ScopeTabItem(
        scope: SearchScope.translations,
        label: l10n.translation,
        icon: FluentIcons.local_language_20_regular,
      ),
      _ScopeTabItem(
        scope: SearchScope.arabic,
        label: l10n.searchArabic,
        icon: FluentIcons.text_font_20_regular,
      ),
      _ScopeTabItem(
        scope: SearchScope.tafsir,
        label: l10n.tafsir,
        icon: FluentIcons.book_open_20_regular,
      ),
      _ScopeTabItem(
        scope: SearchScope.surahs,
        label: l10n.surah,
        icon: FluentIcons.list_20_regular,
      ),
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab.scope == activeScope;

          return InkWell(
            onTap: () => onScopeSelected(tab.scope),
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? themeState.primary
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.white),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? themeState.primary
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.07)
                          : Colors.grey.shade300),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tab.icon,
                    size: 16,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                  ),
                  const Gap(6),
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.grey.shade300 : Colors.grey.shade800),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ScopeTabItem {
  final SearchScope scope;
  final String label;
  final IconData icon;

  const _ScopeTabItem({
    required this.scope,
    required this.label,
    required this.icon,
  });
}
