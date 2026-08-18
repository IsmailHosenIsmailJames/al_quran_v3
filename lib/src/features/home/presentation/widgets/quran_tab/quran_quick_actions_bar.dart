import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_page.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/screens/kfgqpc_v4_layout_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/screens/quran_resources_screen.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A responsive 4-column quick action grid for core Quran navigation.
class QuranQuickActionsBar extends StatelessWidget {
  const QuranQuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: _ActionTile(
              label: l10n.mushaf,
              icon: FluentIcons.book_open_24_filled,
              themeState: themeState,
              isDark: isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KfgqpcV4LayoutScreen(),
                  ),
                );
              },
            ),
          ),
          const Gap(10),
          Expanded(
            child: _ActionTile(
              label: l10n.jumpToAyah,
              icon: FluentIcons.arrow_turn_down_right_20_filled,
              themeState: themeState,
              isDark: isDark,
              onTap: () async {
                await popupJumpToAyah(context: context, isAudioPlayer: false);
              },
            ),
          ),
          const Gap(10),
          Expanded(
            child: _ActionTile(
              label: l10n.pinned,
              icon: FluentIcons.bookmark_multiple_24_filled,
              themeState: themeState,
              isDark: isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CollectionPage(
                      collectionType: CollectionType.pinned,
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(10),
          Expanded(
            child: _ActionTile(
              label: l10n.resources,
              icon: FluentIcons.arrow_download_24_filled,
              themeState: themeState,
              isDark: isDark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuranResourcesScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final ThemeState themeState;
  final bool isDark;
  final VoidCallback onTap;

  const _ActionTile({
    required this.label,
    required this.icon,
    required this.themeState,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.04)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 22,
                color: themeState.primary,
              ),
            ),
            const Gap(8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
