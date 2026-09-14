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

/// Layout mode for presenting search filter options.
enum SearchFilterLayoutMode {
  /// Mobile modal bottom sheet.
  bottomSheet,

  /// Tablet centered modal dialog.
  dialog,

  /// Desktop embedded side panel.
  sidebar,
}

/// A responsive filter view for configuring search criteria, multi-resource selection,
/// and scopes across mobile (bottom sheet), tablet (dialog), and desktop (sidebar).
class SearchFilterSheet extends StatefulWidget {
  final SearchFilterModel initialFilter;
  final List<ResourcesModel> availableTranslations;
  final List<ResourcesModel> availableTafsirs;
  final ValueChanged<SearchFilterModel> onApply;
  final SearchFilterLayoutMode mode;
  final VoidCallback? onClose;

  const SearchFilterSheet({
    super.key,
    required this.initialFilter,
    required this.availableTranslations,
    required this.availableTafsirs,
    required this.onApply,
    this.mode = SearchFilterLayoutMode.bottomSheet,
    this.onClose,
  });

  /// Presents the filter sheet as a modal bottom sheet (mobile).
  static Future<void> showAsBottomSheet({
    required BuildContext context,
    required SearchFilterModel initialFilter,
    required List<ResourcesModel> availableTranslations,
    required List<ResourcesModel> availableTafsirs,
    required ValueChanged<SearchFilterModel> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SearchFilterSheet(
        mode: SearchFilterLayoutMode.bottomSheet,
        initialFilter: initialFilter,
        availableTranslations: availableTranslations,
        availableTafsirs: availableTafsirs,
        onApply: onApply,
        onClose: () => Navigator.pop(sheetContext),
      ),
    );
  }

  /// Presents the filter view as a centered, bounded modal dialog (tablet).
  static Future<void> showAsDialog({
    required BuildContext context,
    required SearchFilterModel initialFilter,
    required List<ResourcesModel> availableTranslations,
    required List<ResourcesModel> availableTafsirs,
    required ValueChanged<SearchFilterModel> onApply,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SearchFilterSheet(
            mode: SearchFilterLayoutMode.dialog,
            initialFilter: initialFilter,
            availableTranslations: availableTranslations,
            availableTafsirs: availableTafsirs,
            onApply: onApply,
            onClose: () => Navigator.pop(dialogContext),
          ),
        ),
      ),
    );
  }

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
  void didUpdateWidget(covariant SearchFilterSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mode == SearchFilterLayoutMode.sidebar &&
        oldWidget.initialFilter != widget.initialFilter) {
      setState(() {
        _filter = widget.initialFilter;
        _selectedTranslations = List.from(widget.initialFilter.selectedTranslations);
        _selectedTafsirs = List.from(widget.initialFilter.selectedTafsirs);
      });
    }
  }

  void _notifySidebarChange() {
    if (widget.mode == SearchFilterLayoutMode.sidebar) {
      final finalFilter = _filter.copyWith(
        selectedTranslations: _selectedTranslations,
        selectedTafsirs: _selectedTafsirs,
      );
      widget.onApply(finalFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final isSidebar = widget.mode == SearchFilterLayoutMode.sidebar;
    final isDialog = widget.mode == SearchFilterLayoutMode.dialog;

    BorderRadius? borderRadius;
    if (isDialog) {
      borderRadius = BorderRadius.circular(20);
    } else if (!isSidebar) {
      borderRadius = const BorderRadius.vertical(top: Radius.circular(24));
    }

    return Material(
      color: isDark ? const Color(0xFF181818) : Colors.white,
      borderRadius: borderRadius,
      clipBehavior: isSidebar ? Clip.none : Clip.antiAlias,
      child: Container(
        constraints: isSidebar
            ? null
            : BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
        padding: EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          top: isSidebar ? 12.0 : 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: isSidebar ? MainAxisSize.max : MainAxisSize.min,
          children: [
            // Drag handle for bottom sheet mode
            if (widget.mode == SearchFilterLayoutMode.bottomSheet) ...[
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
            ],

            // Header: Title + Reset Button + Close/Collapse icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.options_20_regular,
                        size: 20,
                        color: themeState.primary,
                      ),
                      const Gap(8),
                      Expanded(
                        child: Text(
                          l10n.searchFiltersAndOptions,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filter = const SearchFilterModel();
                          _selectedTranslations = List.from(widget.availableTranslations);
                          _selectedTafsirs = List.from(widget.availableTafsirs);
                        });
                        _notifySidebarChange();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        l10n.reset,
                        style: TextStyle(
                          fontSize: 13,
                          color: themeState.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isDialog || isSidebar) ...[
                      const Gap(4),
                      IconButton(
                        tooltip: isSidebar ? "Collapse Filters" : "Close",
                        icon: Icon(
                          isSidebar
                              ? FluentIcons.panel_right_contract_20_regular
                              : FluentIcons.dismiss_20_regular,
                          size: 18,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        onPressed: widget.onClose ?? () => Navigator.pop(context),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ],
                ),
              ],
            ),
            Divider(
              height: 18,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),

            // Scrollable Filter Sections
            Flexible(
              fit: isSidebar ? FlexFit.tight : FlexFit.loose,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  // 1. Exact Phrase Matching Toggle
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.exactPhraseMatch,
                      style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      l10n.matchExactWordsDesc,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    value: _filter.matchExactPhrase,
                    activeThumbColor: themeState.primary,
                    onChanged: (val) {
                      setState(() {
                        _filter = _filter.copyWith(matchExactPhrase: val);
                      });
                      _notifySidebarChange();
                    },
                  ),
                  const Gap(10),

                  // 2. Specific Surah Filter
                  Text(
                    l10n.filterBySurah,
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
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
                        hint: Text(
                          l10n.all114SurahsEntireQuran,
                          style: const TextStyle(fontSize: 13),
                        ),
                        items: [
                          DropdownMenuItem<int?>(
                            value: null,
                            child: Text(
                              l10n.all114SurahsEntireQuran,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          ...List.generate(114, (index) {
                            final surahNum = index + 1;
                            final surahName = getSurahName(context, surahNum);
                            return DropdownMenuItem<int?>(
                              value: surahNum,
                              child: Text(
                                "${localizedNumber(context, surahNum)}. $surahName",
                                style: const TextStyle(fontSize: 13),
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
                          _notifySidebarChange();
                        },
                      ),
                    ),
                  ),
                  const Gap(14),

                  // 3. Revelation Type (All, Meccan, Medinan)
                  Text(
                    l10n.revelationType,
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      _buildRevTypeChip("all", l10n.searchAll, themeState, isDark),
                      const Gap(6),
                      _buildRevTypeChip("meccan", l10n.makki, themeState, isDark),
                      const Gap(6),
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
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          l10n.activeCount(
                            _selectedTranslations.length,
                            widget.availableTranslations.length,
                          ),
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: themeState.primary,
                          ),
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
                          _notifySidebarChange();
                        },
                      );
                    }),
                    const Gap(14),
                  ],

                  // 5. Multi-Select Tafsirs
                  if (widget.availableTafsirs.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.searchInTafsirs,
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          l10n.activeCount(
                            _selectedTafsirs.length,
                            widget.availableTafsirs.length,
                          ),
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: themeState.primary,
                          ),
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
                          _notifySidebarChange();
                        },
                      );
                    }),
                  ],
                ],
              ),
            ),

            // In modal modes, display prominent Apply Button
            if (!isSidebar) ...[
              const Gap(10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeState.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
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
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
          _notifySidebarChange();
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
