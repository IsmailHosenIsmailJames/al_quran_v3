import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/filter_surah.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class SurahPickerColumn extends StatefulWidget {
  final int selectedSurahNumber;
  final ThemeState themeState;
  final Function(int surahId) onSelectSurah;

  const SurahPickerColumn({
    super.key,
    required this.selectedSurahNumber,
    required this.themeState,
    required this.onSelectSurah,
  });

  @override
  State<SurahPickerColumn> createState() => _SurahPickerColumnState();
}

class _SurahPickerColumnState extends State<SurahPickerColumn> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedSurah();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedSurah() {
    if (!_scrollController.hasClients) return;
    final index = widget.selectedSurahNumber - 1;
    if (index >= 0 && index < 114) {
      final targetOffset = (index * 58.0).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final filteredSurahs = getFilteredSurah(
      context,
      _searchController.text.trim(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 10, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              isDense: true,
              hintText: l10n.searchForASurah,
              hintStyle: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
              prefixIcon: Icon(
                FluentIcons.search_16_regular,
                size: 18,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 16),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      padding: EdgeInsets.zero,
                    )
                  : null,
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
                borderSide: BorderSide(
                  color: isDark ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
                borderSide: BorderSide(
                  color: isDark ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ),

        // Surahs List
        Expanded(
          child: filteredSurahs.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      l10n.notFound,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredSurahs.length,
                  padding: const EdgeInsets.fromLTRB(12, 0, 8, 12),
                  itemBuilder: (context, index) {
                    final SurahInfoModel surah = filteredSurahs[index];
                    final isSelected = surah.id == widget.selectedSurahNumber;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? widget.themeState.primary.withValues(
                                alpha: isDark ? 0.2 : 0.08,
                              )
                            : isDark
                                ? Colors.white.withValues(alpha: 0.02)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(roundedRadius),
                        border: Border.all(
                          color: isSelected
                              ? widget.themeState.primary
                              : isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.grey.shade200,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(roundedRadius),
                          onTap: () => widget.onSelectSurah(surah.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                // Surah Number Badge
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? widget.themeState.primary
                                        : isDark
                                            ? Colors.white.withValues(alpha: 0.06)
                                            : widget.themeState.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    localizedNumber(context, surah.id),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : widget.themeState.primary,
                                    ),
                                  ),
                                ),
                                const Gap(10),

                                // Surah Title and Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        getSurahName(context, surah.id),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w600,
                                          color: isSelected
                                              ? widget.themeState.primary
                                              : null,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Gap(2),
                                      Text(
                                        l10n.ayahsCount(
                                          localizedNumber(context, surah.versesCount),
                                        ),
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          fontSize: 11,
                                          color: theme.textTheme.bodySmall?.color?.withValues(
                                            alpha: 0.65,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (isSelected)
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 18,
                                    color: widget.themeState.primary,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
