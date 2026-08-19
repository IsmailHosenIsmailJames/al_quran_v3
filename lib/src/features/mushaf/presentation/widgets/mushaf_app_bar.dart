import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A top navigation AppBar for the Mushaf reader view.
class MushafAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentPage;
  final bool isUiVisible;
  final VoidCallback onJumpPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onToggleFullscreen;

  const MushafAppBar({
    super.key,
    required this.currentPage,
    required this.isUiVisible,
    required this.onJumpPressed,
    required this.onDeletePressed,
    required this.onToggleFullscreen,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final pageDetails = MushafPageHelper.getPageDetails(currentPage);

    return AnimatedCrossFade(
      firstChild: Container(
        decoration: BoxDecoration(
          color: (isDark ? const Color(0xFF1A1A1A) : Colors.white)
              .withValues(alpha: 0.95),
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: kToolbarHeight + 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(FluentIcons.chevron_left_24_filled),
                    tooltip: l10n.back,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onJumpPressed,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    pageDetails.surahEnglishName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.grey.shade900,
                                    ),
                                  ),
                                ),
                                const Gap(6),
                                Text(
                                  pageDetails.surahArabicName,
                                  textDirection: TextDirection.rtl,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: themeState.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(1),
                            Text(
                              "${l10n.juz} ${pageDetails.juzNumber} • ${l10n.page} $currentPage/${MushafPageHelper.totalPages}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.book_open_24_regular, size: 20),
                    tooltip: l10n.goToPage,
                    onPressed: onJumpPressed,
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.full_screen_maximize_24_regular,
                        size: 19),
                    tooltip: l10n.fullscreen,
                    onPressed: onToggleFullscreen,
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, size: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onSelected: (val) {
                      if (val == "delete") {
                        onDeletePressed();
                      } else if (val == "jump") {
                        onJumpPressed();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "jump",
                        child: Row(
                          children: [
                            Icon(FluentIcons.navigation_24_regular,
                                size: 18, color: themeState.primary),
                            const Gap(10),
                            Text(l10n.goToPage),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          children: [
                            const Icon(FluentIcons.delete_24_regular,
                                size: 18, color: Colors.red),
                            const Gap(10),
                            Text(
                              l10n.deleteMushafData,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
