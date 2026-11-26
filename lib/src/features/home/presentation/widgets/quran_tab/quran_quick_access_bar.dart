import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quick_access_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_state.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quick_access_popup.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A consolidated, space-efficient hub for user Shortcuts and Recent reading sessions.
class QuranQuickAccessBar extends StatefulWidget {
  const QuranQuickAccessBar({super.key});

  @override
  State<QuranQuickAccessBar> createState() => _QuranQuickAccessBarState();
}

class _QuranQuickAccessBarState extends State<QuranQuickAccessBar> {
  int _selectedTabIndex = 0; // 0: Shortcuts, 1: Recent

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<QuickAccessCubit, List<QuickAccessModel>>(
      builder: (context, quickAccessList) {
        return BlocBuilder<QuranHistoryCubit, QuranHistoryState>(
          builder: (context, historyState) {
            final recentItems = historyState.history.reversed.take(10).toList();

            final hasShortcuts = quickAccessList.isNotEmpty;
            final hasRecent = recentItems.isNotEmpty;

            if (!hasShortcuts && !hasRecent) {
              return const SizedBox.shrink();
            }

            // Auto-select valid tab if current tab is empty
            int activeTab = _selectedTabIndex;
            if (!hasShortcuts && activeTab == 0) activeTab = 1;
            if (!hasRecent && activeTab == 1) activeTab = 0;

            final bool showSegmentedToggle = hasShortcuts && hasRecent;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 3.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Section Header / Toggle
                      if (showSegmentedToggle)
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.grey.shade300,
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildTabPill(
                                label: l10n.quickAccess,
                                icon: FluentIcons.flash_24_filled,
                                isSelected: activeTab == 0,
                                themePrimary: themeState.primary,
                                isDark: isDark,
                                onTap: () =>
                                    setState(() => _selectedTabIndex = 0),
                              ),
                              const Gap(4),
                              _buildTabPill(
                                label: l10n.history,
                                icon: FluentIcons.history_24_filled,
                                isSelected: activeTab == 1,
                                themePrimary: themeState.primary,
                                isDark: isDark,
                                onTap: () =>
                                    setState(() => _selectedTabIndex = 1),
                              ),
                            ],
                          ),
                        )
                      else
                        Row(
                          children: [
                            Icon(
                              hasShortcuts
                                  ? FluentIcons.flash_24_regular
                                  : FluentIcons.history_24_regular,
                              size: 16,
                              color: themeState.primary,
                            ),
                            const Gap(6),
                            Text(
                              hasShortcuts ? l10n.quickAccess : l10n.history,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : Colors.grey.shade900,
                              ),
                            ),
                          ],
                        ),

                      // Edit button (visible when on shortcuts)
                      if (activeTab == 0 && hasShortcuts)
                        InkWell(
                          onTap: () => showQuickAccessPopup(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 3.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FluentIcons.edit_20_regular,
                                  size: 14,
                                  color: themeState.primary,
                                ),
                                const Gap(4),
                                Text(
                                  l10n.edit,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: themeState.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Gap(4),

                // Horizontal list of chips
                SizedBox(
                  height: 36,
                  child: activeTab == 0
                      ? _buildShortcutsList(
                          context,
                          quickAccessList,
                          themeState.primary,
                          isDark,
                        )
                      : _buildRecentList(
                          context,
                          recentItems,
                          themeState.primary,
                          isDark,
                          l10n,
                        ),
                ),
                const Gap(6),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTabPill({
    required String label,
    required IconData icon,
    required bool isSelected,
    required Color themePrimary,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? themePrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            ),
            const Gap(5),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutsList(
    BuildContext context,
    List<QuickAccessModel> list,
    Color primaryColor,
    bool isDark,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        final model = list[index];
        final surahData = metaDataSurah[model.surahNumber.toString()];
        final surahInfo = surahData != null
            ? SurahInfoModel.fromMap(surahData)
            : null;
        final surahName = getSurahName(context, model.surahNumber);

        final String? scrollTo =
            ((model.scrollIndex != null) && (model.scrollIndex! > 1))
            ? "${model.surahNumber}:${model.scrollIndex}"
            : null;

        final label =
            surahName +
            (scrollTo != null
                ? " • ${localizedNumber(context, model.scrollIndex)}"
                : "");

        return InkWell(
          onTap: () {
            final totalVerses = surahInfo?.versesCount ?? 7;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranScriptView(
                  startKey: "${model.surahNumber}:1",
                  endKey: "${model.surahNumber}:$totalVerses",
                  toScrollKey: scrollTo,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade300,
                width: 0.9,
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
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentList(
    BuildContext context,
    List<dynamic> recentItems,
    Color primaryColor,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      itemCount: recentItems.length,
      separatorBuilder: (context, index) => const Gap(8),
      itemBuilder: (context, index) {
        final item = recentItems[index];
        final surahName = getSurahName(context, item.surahNumber);

        final label = item.pageNumber != null
            ? "$surahName • ${l10n.page} ${localizedNumber(context, item.pageNumber)}"
            : "$surahName • ${l10n.ayah} ${localizedNumber(context, item.ayahNumber ?? 1)}";

        return InkWell(
          onTap: () {
            final toScroll = item.ayahNumber != null
                ? "${item.surahNumber}:${item.ayahNumber}"
                : "${item.surahNumber}:1";

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuranScriptView(
                  startKey: "${item.surahNumber}:1",
                  endKey: getEndAyahKeyFromSurahNumber(item.surahNumber),
                  toScrollKey: toScroll,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade300,
                width: 0.9,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FluentIcons.book_open_20_regular,
                  size: 13,
                  color: primaryColor,
                ),
                const Gap(5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
