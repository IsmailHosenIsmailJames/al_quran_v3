import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A bottom sheet modal for configuring search criteria, multi-resource selection, and filters.
class SearchFilterSheet extends StatefulWidget {
  final SearchFilterModel initialFilter;
  final List<ResourcesModel> availableTranslations;
  final List<ResourcesModel> availableTafsirs;
  final ValueChanged<SearchFilterModel> onApply;

  const SearchFilterSheet({
    super.key,
    required this.initialFilter,
    required this.availableTranslations,
    required this.availableTafsirs,
    required this.onApply,
  });

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  late SearchFilterModel _filter;
  late List<ResourcesModel> _selectedTranslations;
  late List<ResourcesModel> _selectedTafsirs;

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
    _selectedTranslations = List.from(widget.initialFilter.selectedTranslations);
    _selectedTafsirs = List.from(widget.initialFilter.selectedTafsirs);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Material(
      color: isDark ? const Color(0xFF181818) : Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              height: 4,
              width: 36,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(14),

          // Header: Title + Reset Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FluentIcons.options_20_regular,
                    size: 20,
                    color: themeState.primary,
                  ),
                  const Gap(8),
                  Text(
                    l10n.searchFiltersAndOptions,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _filter = const SearchFilterModel();
                    _selectedTranslations = List.from(widget.availableTranslations);
                    _selectedTafsirs = List.from(widget.availableTafsirs);
                  });
                },
                child: Text(
                  l10n.reset,
                  style: TextStyle(color: themeState.primary),
                ),
              ),
            ],
          ),
          const Divider(),

          // Scrollable Filter Sections
          Flexible(
            child: ListView(
              children: [
                // 1. Exact Phrase Matching Toggle
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.exactPhraseMatch,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    l10n.matchExactWordsDesc,
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: _filter.matchExactPhrase,
                  activeThumbColor: themeState.primary,
                  onChanged: (val) {
                    setState(() {
                      _filter = _filter.copyWith(matchExactPhrase: val);
                    });
                  },
                ),
                const Gap(10),

                // 2. Specific Surah Filter
                Text(
                  l10n.filterBySurah,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const Gap(6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int?>(
                      value: _filter.surahNumber,
                      isExpanded: true,
                      hint: Text(l10n.all114SurahsEntireQuran),
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text(l10n.all114SurahsEntireQuran),
                        ),
                        ...List.generate(114, (index) {
                          final surahNum = index + 1;
                          final surahName = getSurahName(context, surahNum);
                          return DropdownMenuItem<int?>(
                            value: surahNum,
                            child: Text(
                              "${localizedNumber(context, surahNum)}. $surahName",
                            ),
                          );
                        }),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _filter = _filter.copyWith(
                            surahNumber: val,
                            clearSurahNumber: val == null,
                          );
                        });
                      },
                    ),
                  ),
                ),
                const Gap(16),

                // 3. Revelation Type (All, Meccan, Medinan)
                Text(
                  l10n.revelationType,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Row(
                  children: [
                    _buildRevTypeChip("all", l10n.searchAll, themeState, isDark),
                    const Gap(8),
                    _buildRevTypeChip("meccan", l10n.makki, themeState, isDark),
                    const Gap(8),
                    _buildRevTypeChip("medinan", l10n.madani, themeState, isDark),
                  ],
                ),
                const Gap(16),

                // 4. Multi-Select Translations
                if (widget.availableTranslations.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.searchInTranslations,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.activeCount(
                          _selectedTranslations.length,
                          widget.availableTranslations.length,
                        ),
                        style: TextStyle(fontSize: 12, color: themeState.primary),
                      ),
                    ],
                  ),
                  const Gap(6),
                  ...widget.availableTranslations.map((book) {
                    final isChecked = _selectedTranslations.any(
                      (b) => b.fullPath == book.fullPath,
                    );
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: themeState.primary,
                      title: Text(
                        book.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                      subtitle: Text(
                        book.language,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedTranslations.add(book);
                          } else {
                            if (_selectedTranslations.length > 1) {
                              _selectedTranslations.removeWhere(
                                (b) => b.fullPath == book.fullPath,
                              );
                            }
                          }
                        });
                      },
                    );
                  }),
                  const Gap(16),
                ],

                // 5. Multi-Select Tafsirs
                if (widget.availableTafsirs.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.searchInTafsirs,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.activeCount(
                          _selectedTafsirs.length,
                          widget.availableTafsirs.length,
                        ),
                        style: TextStyle(fontSize: 12, color: themeState.primary),
                      ),
                    ],
                  ),
                  const Gap(6),
                  ...widget.availableTafsirs.map((book) {
                    final isChecked = _selectedTafsirs.any(
                      (b) => b.fullPath == book.fullPath,
                    );
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      activeColor: themeState.primary,
                      title: Text(
                        book.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                      subtitle: Text(
                        book.language,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedTafsirs.add(book);
                          } else {
                            if (_selectedTafsirs.length > 1) {
                              _selectedTafsirs.removeWhere(
                                (b) => b.fullPath == book.fullPath,
                              );
                            }
                          }
                        });
                      },
                    );
                  }),
                ],
              ],
            ),
          ),

          const Gap(12),

          // Apply Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              final finalFilter = _filter.copyWith(
                selectedTranslations: _selectedTranslations,
                selectedTafsirs: _selectedTafsirs,
              );
              widget.onApply(finalFilter);
              Navigator.pop(context);
            },
            child: Text(
              l10n.apply,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildRevTypeChip(
    String type,
    String label,
    ThemeState themeState,
    bool isDark,
  ) {
    final isSelected = _filter.revelationType == type;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _filter = _filter.copyWith(revelationType: type);
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? themeState.primary
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.grey.shade300),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey.shade300 : Colors.grey.shade800),
            ),
          ),
        ),
      ),
    );
  }
}
