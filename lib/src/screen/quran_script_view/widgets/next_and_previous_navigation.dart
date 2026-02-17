import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/quran_script_view/quran_script_view.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/widget/surah_info_header/surah_info_header_builder.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class NextAndPreviousNavigation extends StatelessWidget {
  const NextAndPreviousNavigation({super.key, required this.widget});

  final QuranScriptView widget;

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    String? previousStartKey;
    String? previousEndKey;
    if (widget.previousStartKey != null && widget.previousEndKey != null) {
      previousStartKey = widget.previousStartKey;
      previousEndKey = widget.previousEndKey;
    } else {
      int currentSurahNumber =
          int.tryParse(widget.startKey.split(":").first) ?? 1;
      if (currentSurahNumber > 1) {
        previousStartKey = "${currentSurahNumber - 1}:1";
        previousEndKey = getEndAyahKeyFromSurahNumber(currentSurahNumber - 1);
      }
    }

    String? nextStartKey;
    String? nextEndKey;
    if (widget.nextStartKey != null && widget.nextEndKey != null) {
      nextStartKey = widget.nextStartKey;
      nextEndKey = widget.nextEndKey;
    } else {
      int currentSurahNumber =
          int.tryParse(widget.startKey.split(":").first) ?? 1;
      if (currentSurahNumber < 114) {
        nextStartKey = "${currentSurahNumber + 1}:1";
        nextEndKey = getEndAyahKeyFromSurahNumber(currentSurahNumber + 1);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeState.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: themeState.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _NavigationButton(
              isPrevious: true,
              themeState: themeState,
              startKey: previousStartKey,
              endKey: previousEndKey,
              label: getLabel(context, previousStartKey, "Previous"),
            ),
          ),
          const Gap(10),
          Expanded(
            child: _NavigationButton(
              isPrevious: false,
              themeState: themeState,
              startKey: nextStartKey,
              endKey: nextEndKey,
              label: getLabel(context, nextStartKey, "Next"),
            ),
          ),
        ],
      ),
    );
  }

  String getLabel(BuildContext context, String? key, String defaultLabel) {
    if (key != null && key.endsWith(":1")) {
      int? surahId = int.tryParse(key.split(":").first);
      if (surahId != null) {
        return getSurahName(context, surahId);
      }
    }
    return defaultLabel;
  }
}

class _NavigationButton extends StatelessWidget {
  final bool isPrevious;
  final ThemeState themeState;
  final String? startKey;
  final String? endKey;
  final String label;

  const _NavigationButton({
    required this.isPrevious,
    required this.themeState,
    required this.startKey,
    required this.endKey,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabled = startKey == null || endKey == null;

    return Opacity(
      opacity: isDisabled ? 0.4 : 1.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isDisabled
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuranScriptView(startKey: startKey!, endKey: endKey!),
                  ),
                );
              },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: themeState.primaryShade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: themeState.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: isPrevious
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              if (isPrevious) ...[
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 16,
                  color: themeState.primary,
                ),
                const Gap(8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: isPrevious
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      isPrevious ? "Previous" : "Next",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: themeState.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isPrevious) ...[
                const Gap(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: themeState.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
