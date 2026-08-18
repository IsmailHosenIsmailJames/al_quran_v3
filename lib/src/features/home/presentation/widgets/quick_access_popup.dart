import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/filter_surah.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Opens the modernized Quick Access configuration bottom sheet.
void showQuickAccessPopup(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const QuickAccessWidget(),
  );
}

class QuickAccessWidget extends StatefulWidget {
  const QuickAccessWidget({super.key});

  @override
  State<QuickAccessWidget> createState() => _QuickAccessWidgetState();
}

class _QuickAccessWidgetState extends State<QuickAccessWidget> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterTab = 0; // 0 = All Surahs, 1 = Selected Shortcuts

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final query = _searchController.text.trim();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141414) : const Color(0xFFF9FAFB),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top Drag Handle
            const Gap(10),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Gap(8),

            // Header Row
            BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
              builder: (context, quickAccessList) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: themeState.primary.withValues(
                            alpha: isDark ? 0.2 : 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FluentIcons.flash_24_filled,
                          size: 18,
                          color: themeState.primary,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.quickAccess,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${quickAccessList.length} shortcuts active on Home",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.grey.shade200,
                          foregroundColor: isDark
                              ? Colors.white
                              : Colors.grey.shade800,
                          visualDensity: VisualDensity.compact,
                        ),
                        icon: const Icon(FluentIcons.dismiss_20_regular, size: 18),
                      ),
                    ],
                  ),
                );
              },
            ),

            const Gap(6),

            // Search Bar & Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Search Input
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: l10n.searchForASurah,
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                        ),
                        prefixIcon: Icon(
                          FluentIcons.search_20_regular,
                          size: 18,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                        suffixIcon: query.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  FluentIcons.dismiss_circle_20_filled,
                                  size: 16,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),

                  const Gap(8),

                  // Filter Segmented Tabs
                  BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
                    builder: (context, quickAccessList) {
                      return Row(
                        children: [
                          _buildTabChip(
                            index: 0,
                            label: l10n.allSurahsCount(114),
                            isSelected: _selectedFilterTab == 0,
                            themeState: themeState,
                            isDark: isDark,
                          ),
                          const Gap(8),
                          _buildTabChip(
                            index: 1,
                            label: l10n.activeShortcutsCount(quickAccessList.length),
                            isSelected: _selectedFilterTab == 1,
                            themeState: themeState,
                            isDark: isDark,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const Gap(10),

            // Surah Cards List
            Expanded(
              child: BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
                builder: (context, quickAccessList) {
                  List<SurahInfoModel> surahs = getFilteredSurah(
                    context,
                    query,
                  );

                  if (_selectedFilterTab == 1) {
                    final selectedIds =
                        quickAccessList.map((e) => e.surahNumber).toSet();
                    surahs = surahs
                        .where((s) => selectedIds.contains(s.id))
                        .toList();
                  }

                  if (surahs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _selectedFilterTab == 1
                                  ? FluentIcons.bookmark_off_24_regular
                                  : FluentIcons.search_24_regular,
                              size: 44,
                              color: isDark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400,
                            ),
                            const Gap(12),
                            Text(
                              _selectedFilterTab == 1
                                  ? l10n.noActiveShortcuts
                                  : l10n.noMatchingSurahs(query),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: surahs.length,
                    separatorBuilder: (context, index) => const Gap(8),
                    itemBuilder: (context, index) {
                      final surah = surahs[index];
                      final matchedAccess = quickAccessList.firstOrNullWhere(
                        (e) => e.surahNumber == surah.id,
                      );
                      final isSelected = matchedAccess != null;

                      return _QuickAccessSurahCard(
                        surah: surah,
                        matchedAccess: matchedAccess,
                        isSelected: isSelected,
                        themeState: themeState,
                        isDark: isDark,
                        l10n: l10n,
                        onToggle: () {
                          if (isSelected) {
                            context
                                .read<QuickAccessCubit>()
                                .removeQuickAccess(matchedAccess);
                          } else {
                            context.read<QuickAccessCubit>().addQuickAccess(
                                  QuickAccessModel(
                                    surahNumber: surah.id,
                                    scrollIndex: 1,
                                    createdAt: DateTime.now(),
                                  ),
                                );
                          }
                          setState(() {});
                        },
                        onUpdateAyah: (newAyah) {
                          context.read<QuickAccessCubit>().updateQuickAccess(
                                QuickAccessModel(
                                  surahNumber: surah.id,
                                  scrollIndex: newAyah,
                                  createdAt: matchedAccess?.createdAt ??
                                      DateTime.now(),
                                ),
                              );
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabChip({
    required int index,
    required String label,
    required bool isSelected,
    required ThemeState themeState,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedFilterTab = index),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white),
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
            style: TextStyle(
              fontSize: 12,
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

class _QuickAccessSurahCard extends StatelessWidget {
  final SurahInfoModel surah;
  final QuickAccessModel? matchedAccess;
  final bool isSelected;
  final ThemeState themeState;
  final bool isDark;
  final AppLocalizations l10n;
  final VoidCallback onToggle;
  final ValueChanged<int> onUpdateAyah;

  const _QuickAccessSurahCard({
    required this.surah,
    required this.matchedAccess,
    required this.isSelected,
    required this.themeState,
    required this.isDark,
    required this.l10n,
    required this.onToggle,
    required this.onUpdateAyah,
  });

  @override
  Widget build(BuildContext context) {
    final localizedName = getSurahName(context, surah.id);
    final surahMeaning = getSurahMeaning(context, surah.id);
    final scrollAyah = matchedAccess?.scrollIndex ?? 1;

    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? themeState.primary.withValues(alpha: isDark ? 0.12 : 0.04)
            : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected
              ? themeState.primary.withValues(alpha: isDark ? 0.6 : 0.4)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.grey.shade200),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Checkmark, Number Badge, Title, Calligraphy
                Row(
                  children: [
                    // Selection indicator
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? themeState.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? themeState.primary
                              : (isDark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400),
                          width: 1.5,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),

                    const Gap(10),

                    // Number Badge
                    QuranIndexBadge(
                      index: surah.id,
                      size: 32,
                    ),

                    const Gap(10),

                    // Surah Name & Verses Count
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizedName,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : Colors.grey.shade900,
                            ),
                          ),
                          if (surahMeaning.isNotEmpty)
                            Text(
                              "$surahMeaning • ${localizedNumber(context, surah.versesCount)} ${l10n.verses}",
                              style: TextStyle(
                                fontSize: 11.5,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const Gap(8),

                    // Arabic Calligraphy in surah-name-v1 font
                    Text(
                      "surah${surah.id.toString().padLeft(3, '0')}",
                      style: TextStyle(
                        fontFamily: "surah-name-v1",
                        fontSize: 22,
                        color: isSelected
                            ? themeState.primary
                            : (isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),

                // If Selected: Start Ayah Selector Pill
                if (isSelected) ...[
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.pin_20_regular,
                          size: 15,
                          color: themeState.primary,
                        ),
                        const Gap(6),
                        Text(
                          "Starting Ayah:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade700,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => _openAyahPicker(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: themeState.primary.withValues(
                                alpha: isDark ? 0.2 : 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: themeState.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Ayah ${localizedNumber(context, scrollAyah)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.primary,
                                  ),
                                ),
                                const Gap(4),
                                Icon(
                                  FluentIcons.chevron_down_16_regular,
                                  size: 13,
                                  color: themeState.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openAyahPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AyahPickerSheet(
        surah: surah,
        currentAyah: matchedAccess?.scrollIndex ?? 1,
        themeState: themeState,
        isDark: isDark,
        onSelected: onUpdateAyah,
      ),
    );
  }
}

class _AyahPickerSheet extends StatefulWidget {
  final SurahInfoModel surah;
  final int currentAyah;
  final ThemeState themeState;
  final bool isDark;
  final ValueChanged<int> onSelected;

  const _AyahPickerSheet({
    required this.surah,
    required this.currentAyah,
    required this.themeState,
    required this.isDark,
    required this.onSelected,
  });

  @override
  State<_AyahPickerSheet> createState() => _AyahPickerSheetState();
}

class _AyahPickerSheetState extends State<_AyahPickerSheet> {
  late int _selectedAyah;

  @override
  void initState() {
    super.initState();
    _selectedAyah = widget.currentAyah;
  }

  @override
  Widget build(BuildContext context) {
    final localizedName = getSurahName(context, widget.surah.id);
    final totalVerses = widget.surah.versesCount;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: widget.isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(14),

          // Title
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Set Starting Ayah",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$localizedName • 1 to $totalVerses Ayahs",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(FluentIcons.dismiss_20_regular),
              ),
            ],
          ),

          const Gap(16),

          // Stepper + Display
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: _selectedAyah > 1
                      ? () => setState(() => _selectedAyah--)
                      : null,
                  style: IconButton.styleFrom(
                    backgroundColor: widget.isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade100,
                  ),
                  icon: const Icon(FluentIcons.subtract_20_regular),
                ),
                const Gap(16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: widget.themeState.primary.withValues(
                      alpha: widget.isDark ? 0.2 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.themeState.primary.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Ayah ${localizedNumber(context, _selectedAyah)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.themeState.primary,
                    ),
                  ),
                ),
                const Gap(16),
                IconButton.filledTonal(
                  onPressed: _selectedAyah < totalVerses
                      ? () => setState(() => _selectedAyah++)
                      : null,
                  style: IconButton.styleFrom(
                    backgroundColor: widget.isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade100,
                  ),
                  icon: const Icon(FluentIcons.add_20_regular),
                ),
              ],
            ),
          ),

          const Gap(14),

          // Slider
          if (totalVerses > 1) ...[
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: widget.themeState.primary,
                thumbColor: widget.themeState.primary,
                inactiveTrackColor: widget.themeState.primary.withValues(
                  alpha: widget.isDark ? 0.2 : 0.15,
                ),
              ),
              child: Slider(
                value: _selectedAyah.toDouble(),
                min: 1.0,
                max: totalVerses.toDouble(),
                divisions: totalVerses > 1 ? totalVerses - 1 : 1,
                onChanged: (val) {
                  setState(() => _selectedAyah = val.round());
                },
              ),
            ),
          ],

          const Gap(8),

          // Quick Preset Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPresetChip("Ayah 1 (Start)", 1),
              if (totalVerses >= 10) _buildPresetChip("Ayah 10", 10),
              if (widget.surah.id == 2 && totalVerses >= 255)
                _buildPresetChip("Ayatul Kursi (255)", 255),
              if (totalVerses >= 50) _buildPresetChip("Ayah 50", 50),
              if (totalVerses >= 100) _buildPresetChip("Ayah 100", 100),
              if (totalVerses > 1)
                _buildPresetChip("Last ($totalVerses)", totalVerses),
            ],
          ),

          const Gap(20),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: widget.themeState.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                widget.onSelected(_selectedAyah);
                Navigator.pop(context);
              },
              child: const Text(
                "Set Shortcut Ayah",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetChip(String label, int ayahNum) {
    final isSelected = _selectedAyah == ayahNum;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      checkmarkColor: Colors.white,
      showCheckmark: true,
      selectedColor: widget.themeState.primary,
      backgroundColor: widget.isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.white,
      side: BorderSide(
        color: isSelected
            ? Colors.transparent
            : (widget.isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade300),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: TextStyle(
        fontSize: 11.5,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        color: isSelected
            ? Colors.white
            : (widget.isDark ? Colors.grey.shade300 : Colors.grey.shade800),
      ),
      onSelected: (_) => setState(() => _selectedAyah = ayahNum),
    );
  }
}
