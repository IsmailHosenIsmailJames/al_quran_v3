import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// Floating bottom navigation bar for the Mushaf reader view.
class MushafBottomBar extends StatelessWidget {
  final int currentPage;
  final bool isUiVisible;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onNextPage;
  final VoidCallback onPrevPage;
  final VoidCallback onJumpPressed;

  const MushafBottomBar({
    super.key,
    required this.currentPage,
    required this.isUiVisible,
    required this.onPageChanged,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onJumpPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return AnimatedCrossFade(
      firstChild: Container(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
        decoration: BoxDecoration(
          color: (isDark ? const Color(0xFF1A1A1A) : Colors.white)
              .withValues(alpha: 0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Slider scrubber
              Row(
                children: [
                  Text(
                    "1",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: themeState.primary,
                        inactiveTrackColor: themeState.primary
                            .withValues(alpha: isDark ? 0.2 : 0.15),
                        thumbColor: themeState.primary,
                        overlayColor: themeState.primary.withValues(alpha: 0.1),
                        trackHeight: 3.5,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 7,
                        ),
                      ),
                      child: Slider(
                        value: currentPage.toDouble().clamp(
                              1.0,
                              MushafPageHelper.totalPages.toDouble(),
                            ),
                        min: 1.0,
                        max: MushafPageHelper.totalPages.toDouble(),
                        onChanged: (val) {
                          onPageChanged(val.round());
                        },
                      ),
                    ),
                  ),
                  Text(
                    "${MushafPageHelper.totalPages}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const Gap(4),
              // Action buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Next Page in Arabic Mushaf (turns to higher page number)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.shade300,
                      ),
                    ),
                    onPressed: currentPage < MushafPageHelper.totalPages
                        ? onNextPage
                        : null,
                    icon: const Icon(FluentIcons.chevron_left_20_filled,
                        size: 16),
                    label: Text(
                      l10n.next,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.grey.shade200
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                  // Current Page Badge
                  InkWell(
                    onTap: onJumpPressed,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: themeState.primary
                            .withValues(alpha: isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: themeState.primary.withValues(
                            alpha: isDark ? 0.35 : 0.25,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FluentIcons.book_open_20_regular,
                            size: 14,
                            color: themeState.primary,
                          ),
                          const Gap(6),
                          Text(
                            "${l10n.page} $currentPage",
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: themeState.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Previous Page in Arabic Mushaf (turns to lower page number)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.shade300,
                      ),
                    ),
                    onPressed: currentPage > 1 ? onPrevPage : null,
                    label: Text(
                      l10n.previous,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.grey.shade200
                            : Colors.grey.shade800,
                      ),
                    ),
                    icon: const Icon(FluentIcons.chevron_right_20_filled,
                        size: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
      crossFadeState:
          isUiVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );
  }
}
