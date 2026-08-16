import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class JumpToAyahActions extends StatelessWidget {
  final bool selectMultipleAndShare;
  final bool isAudioPlayer;
  final bool isSharing;
  final bool hasCustomOnSelectAyah;
  final bool canSubmitSingle;
  final bool canSubmitMulti;
  final ThemeState themeState;
  final VoidCallback onToTafsir;
  final VoidCallback onToAyah;
  final VoidCallback onPlaySelected;
  final VoidCallback onShareSelected;

  const JumpToAyahActions({
    super.key,
    required this.selectMultipleAndShare,
    required this.isAudioPlayer,
    required this.isSharing,
    required this.hasCustomOnSelectAyah,
    required this.canSubmitSingle,
    required this.canSubmitMulti,
    required this.themeState,
    required this.onToTafsir,
    required this.onToAyah,
    required this.onPlaySelected,
    required this.onShareSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.02)
            : Colors.black.withValues(alpha: 0.015),
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: _buildActionContent(context, l10n, isDark),
      ),
    );
  }

  Widget _buildActionContent(
    BuildContext context,
    AppLocalizations l10n,
    bool isDark,
  ) {
    // Mode 1: Multi-Select & Share
    if (selectMultipleAndShare) {
      return SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeState.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundedRadius),
            ),
            elevation: 0,
          ),
          onPressed: canSubmitMulti && !isSharing ? onShareSelected : null,
          icon: isSharing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(FluentIcons.share_20_regular, size: 20),
          label: Text(
            isSharing ? l10n.loading : l10n.asText,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      );
    }

    // Mode 2: Audio Player
    if (isAudioPlayer) {
      return SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeState.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundedRadius),
            ),
            elevation: 0,
          ),
          onPressed: canSubmitSingle ? onPlaySelected : null,
          icon: const Icon(Icons.play_circle_filled_rounded, size: 22),
          label: Text(
            l10n.playFromSelectedAyah,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      );
    }

    // Mode 3: Navigation / Quran View
    return Row(
      children: [
        if (!hasCustomOnSelectAyah) ...[
          Expanded(
            child: SizedBox(
              height: 44,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                  side: BorderSide(
                    color: themeState.primary.withValues(
                      alpha: isDark ? 0.3 : 0.4,
                    ),
                  ),
                ),
                onPressed: canSubmitSingle ? onToTafsir : null,
                icon: Icon(
                  FluentIcons.book_open_20_regular,
                  size: 18,
                  color: themeState.primary,
                ),
                label: Text(
                  l10n.toTafsir,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeState.primary,
                  ),
                ),
              ),
            ),
          ),
          const Gap(10),
        ],
        Expanded(
          child: SizedBox(
            height: 44,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeState.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                elevation: 0,
              ),
              onPressed: canSubmitSingle ? onToAyah : null,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text(
                hasCustomOnSelectAyah ? l10n.selectAyah : l10n.toAyah,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
