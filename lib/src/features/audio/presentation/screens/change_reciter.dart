import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/resources/recitations.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class ChangeReciter extends StatefulWidget {
  final ReciterInfoModel? initReciterIndex;
  final bool? isWordByWord;
  final Function(ReciterInfoModel index)? onReciterChanged;

  const ChangeReciter({
    super.key,
    this.initReciterIndex,
    this.onReciterChanged,
    this.isWordByWord,
  });

  @override
  State<ChangeReciter> createState() => _ChangeReciterState();
}

class _ChangeReciterState extends State<ChangeReciter> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late ReciterInfoModel _selectedReciter;
  late List<ReciterInfoModel> _allReciters;
  String _selectedFilter = "all"; // 'all', 'wbw', 'murattal', 'mujawwad'

  @override
  void initState() {
    super.initState();
    _selectedReciter = widget.initReciterIndex ??
        ReciterInfoModel.fromMap(
          Map<String, dynamic>.from(
            Hive.box("user").get(
              "last_selected_reciter",
              defaultValue: recitationsInfoList[0],
            ),
          ),
        );
    final parsed = recitationsInfoList
        .map((e) => ReciterInfoModel.fromMap(e))
        .toList();

    if (widget.isWordByWord == true) {
      _allReciters = parsed.where((e) => e.segmentsUrl != null).toList();
      _selectedFilter = "wbw";
    } else {
      _allReciters = parsed;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ReciterInfoModel> get _filteredReciters {
    final query = _searchController.text.trim().toLowerCase();
    return _allReciters.where((reciter) {
      // Filter category check
      if (_selectedFilter == "wbw" && reciter.segmentsUrl == null) {
        return false;
      }
      if (_selectedFilter == "murattal" &&
          !(reciter.style?.toLowerCase().contains("murattal") ?? false)) {
        return false;
      }
      if (_selectedFilter == "mujawwad" &&
          !(reciter.style?.toLowerCase().contains("mujawwad") ?? false)) {
        return false;
      }

      // Search query check
      if (query.isEmpty) return true;
      final name = reciter.name.toLowerCase();
      final style = (reciter.style ?? "").toLowerCase();
      final source = (reciter.source ?? "").toLowerCase();
      return name.contains(query) || style.contains(query) || source.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final themeState = context.read<ThemeCubit>().state;
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _filteredReciters;

    final canPop = Navigator.canPop(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      borderRadius: widget.initReciterIndex != null
          ? const BorderRadius.vertical(top: Radius.circular(20))
          : BorderRadius.zero,
      child: SafeArea(
        top: widget.initReciterIndex == null,
        bottom: false,
        child: Column(
          children: [
            if (widget.initReciterIndex != null) ...[
              // Drag Handle
              const Gap(10),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(10),
            ] else ...[
              const Gap(14),
            ],

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.selectReciter,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (canPop)
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.05),
                      ),
                    ),
                ],
              ),
            ),

          const Gap(8),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(FluentIcons.search_20_regular, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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

          const Gap(10),

          // Filter Chips
          if (widget.isWordByWord != true)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("all", "All", themeState, isDark),
                  const Gap(8),
                  _buildFilterChip("wbw", "Word-by-Word", themeState, isDark),
                  const Gap(8),
                  _buildFilterChip("murattal", "Murattal", themeState, isDark),
                  const Gap(8),
                  _buildFilterChip("mujawwad", "Mujawwad", themeState, isDark),
                ],
              ),
            ),

          const Gap(10),
          const Divider(height: 1),

          // Reciters List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FluentIcons.person_search_24_regular,
                          size: 54,
                          color: theme.disabledColor,
                        ),
                        const Gap(12),
                        Text(
                          "No reciters found",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: filtered.length,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    itemBuilder: (context, index) {
                      final reciter = filtered[index];
                      final isSelected = _selectedReciter.link == reciter.link;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(roundedRadius),
                          color: isSelected
                              ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.12)
                              : isDark
                                  ? Colors.white.withValues(alpha: 0.03)
                                  : Colors.black.withValues(alpha: 0.02),
                          border: Border.all(
                            color: isSelected
                                ? themeState.primary
                                : isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : Colors.black.withValues(alpha: 0.06),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(roundedRadius),
                            onTap: () {
                              setState(() {
                                _selectedReciter = reciter;
                              });
                              context
                                  .read<AudioTabReciterCubit>()
                                  .changeReciter(reciter);
                              widget.onReciterChanged?.call(reciter);
                              if (canPop) {
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  // Reciter Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      height: 60,
                                      width: 52,
                                      child: reciter.img != null
                                          ? CachedNetworkImage(
                                              imageUrl: reciter.img!,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) =>
                                                  Container(
                                                color: themeState.primaryShade100,
                                                child: Icon(
                                                  FluentIcons.person_24_filled,
                                                  color: themeState.primary,
                                                  size: 28,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              color: themeState.primaryShade100,
                                              child: Icon(
                                                FluentIcons.person_24_filled,
                                                color: themeState.primary,
                                                size: 28,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const Gap(12),

                                  // Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reciter.name,
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: isSelected
                                                ? themeState.primary
                                                : null,
                                          ),
                                        ),
                                        const Gap(4),
                                        Row(
                                          children: [
                                            if (reciter.style != null &&
                                                reciter.style!.isNotEmpty)
                                              Text(
                                                l10n.style(reciter.style!),
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                                                ),
                                              ),
                                            if (reciter.style != null &&
                                                reciter.source != null)
                                              const Text(" • "),
                                            if (reciter.source != null &&
                                                reciter.source!.isNotEmpty)
                                              Text(
                                                l10n.source(reciter.source!),
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                                                ),
                                              ),
                                          ],
                                        ),
                                        if (reciter.segmentsUrl != null) ...[
                                          const Gap(4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: themeState.primary.withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              "Word-by-word synced",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: themeState.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),

                                  // Selection Indicator
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? themeState.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? themeState.primary
                                            : isDark
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
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
      ),
    ),
  );
}

  Widget _buildFilterChip(
    String filterKey,
    String label,
    ThemeState themeState,
    bool isDark,
  ) {
    final isSelected = _selectedFilter == filterKey;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = filterKey;
        });
      },
      checkmarkColor: Colors.white,
      showCheckmark: true,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        color: isSelected
            ? Colors.white
            : isDark
                ? Colors.grey.shade300
                : Colors.grey.shade800,
      ),
      selectedColor: themeState.primary,
      backgroundColor: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.white,
      side: BorderSide(
        color: isSelected
            ? Colors.transparent
            : (isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade300),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      visualDensity: VisualDensity.compact,
    );
  }
}
