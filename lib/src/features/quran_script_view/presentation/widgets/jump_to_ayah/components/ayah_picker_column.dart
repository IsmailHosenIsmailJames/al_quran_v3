import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class AyahPickerColumn extends StatefulWidget {
  final int surahNumber;
  final int totalVerses;
  final int? selectedAyahNumber;
  final bool selectMultipleAndShare;
  final List<String> selectedAyahKeys;
  final ThemeState themeState;
  final Function(int ayahNumber) onSelectAyah;
  final Function(String ayahKey) onToggleAyahSelection;

  const AyahPickerColumn({
    super.key,
    required this.surahNumber,
    required this.totalVerses,
    required this.selectedAyahNumber,
    required this.selectMultipleAndShare,
    required this.selectedAyahKeys,
    required this.themeState,
    required this.onSelectAyah,
    required this.onToggleAyahSelection,
  });

  @override
  State<AyahPickerColumn> createState() => _AyahPickerColumnState();
}

class _AyahPickerColumnState extends State<AyahPickerColumn> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedAyah();
    });
  }

  @override
  void didUpdateWidget(covariant AyahPickerColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surahNumber != widget.surahNumber) {
      _scrollController.jumpTo(0.0);
    } else if (oldWidget.selectedAyahNumber != widget.selectedAyahNumber) {
      _scrollToSelectedAyah();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedAyah() {
    if (!_scrollController.hasClients || widget.selectedAyahNumber == null) {
      return;
    }
    final index = widget.selectedAyahNumber! - 1;
    if (index >= 0 && index < widget.totalVerses) {
      final targetOffset = (index * 42.0).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Column Header
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
          child: Text(
            l10n.ayahCount(widget.totalVerses),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

        // Ayahs List
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.totalVerses,
            padding: const EdgeInsets.fromLTRB(6, 0, 12, 12),
            itemBuilder: (context, index) {
              final ayahNumber = index + 1;
              final ayahKey = "${widget.surahNumber}:$ayahNumber";
              final isSelectedInSingleMode =
                  !widget.selectMultipleAndShare &&
                  widget.selectedAyahNumber == ayahNumber;
              final isCheckedInMultiMode =
                  widget.selectMultipleAndShare &&
                  widget.selectedAyahKeys.contains(ayahKey);

              final isHighlighted =
                  isSelectedInSingleMode || isCheckedInMultiMode;

              return Container(
                height: 38,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? widget.themeState.primary.withValues(
                          alpha: isDark ? 0.25 : 0.14,
                        )
                      : isDark
                          ? Colors.white.withValues(alpha: 0.02)
                          : Colors.black.withValues(alpha: 0.015),
                  borderRadius: BorderRadius.circular(roundedRadius),
                  border: Border.all(
                    color: isHighlighted
                        ? widget.themeState.primary
                        : isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.04),
                    width: isHighlighted ? 1.5 : 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(roundedRadius),
                    onTap: () {
                      if (widget.selectMultipleAndShare) {
                        widget.onToggleAyahSelection(ayahKey);
                      } else {
                        widget.onSelectAyah(ayahNumber);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.selectMultipleAndShare) ...[
                            Icon(
                              isCheckedInMultiMode
                                  ? FluentIcons.checkbox_checked_16_filled
                                  : FluentIcons.checkbox_unchecked_16_regular,
                              size: 16,
                              color: isCheckedInMultiMode
                                  ? widget.themeState.primary
                                  : (isDark
                                      ? Colors.white54
                                      : Colors.black45),
                            ),
                            const Gap(6),
                          ],
                          Text(
                            localizedNumber(context, ayahNumber),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isHighlighted
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isHighlighted
                                  ? widget.themeState.primary
                                  : null,
                            ),
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
