import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

Widget getScriptSelectionSegmentedButtons(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return BlocBuilder<QuranViewCubit, QuranViewState>(
        builder: (context, quranViewState) {
          final isTajweedActive =
              quranViewState.quranScriptType == QuranScriptType.uthmani
                  ? quranViewState.useTajweedOnUthmani
                  : quranViewState.useTajweedOnIndopak;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Script Choice Segmented Buttons
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<QuranScriptType>(
                  showSelectedIcon: true,
                  selected: {quranViewState.quranScriptType},
                  style: SegmentedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.white,
                    selectedBackgroundColor: themeState.primary,
                    selectedForegroundColor: Colors.white,
                    foregroundColor:
                        isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                    side: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  segments: QuranScriptType.values.map((type) {
                    return ButtonSegment<QuranScriptType>(
                      value: type,
                      label: Text(
                        getLocalizedQuranScriptType(context, type).capitalize(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }).toList(),
                  onSelectionChanged: (value) async {
                    await Hive.box(
                      "user",
                    ).put("selected_script", value.first.name);
                    await QuranScriptFunction.loadScript(value.first);
                    if (context.mounted) {
                      context.read<QuranViewCubit>().changeQuranScriptType(
                            value.first,
                          );
                    }
                  },
                ),
              ),

              const Gap(10),

              // 2. Tajweed Rules Pill Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isTajweedActive
                      ? themeState.primary.withValues(
                          alpha: isDark ? 0.12 : 0.05,
                        )
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.grey.shade50),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isTajweedActive
                        ? themeState.primary.withValues(alpha: 0.3)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FluentIcons.color_24_regular,
                      size: 18,
                      color: isTajweedActive
                          ? themeState.primary
                          : (isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        l10n.quranScriptTajweed,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: isTajweedActive
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: isTajweedActive,
                      activeTrackColor: themeState.primary,
                      onChanged: (value) async {
                        if (quranViewState.quranScriptType ==
                            QuranScriptType.uthmani) {
                          context
                              .read<QuranViewCubit>()
                              .changeUseTajweedOnUthmani(value);
                        } else {
                          if (value) {
                            final willApply = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(l10n.warning),
                                  content: Text(
                                    l10n.warningMessageOnIndopakTajweedEnable,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text(l10n.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text(l10n.apply),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (willApply == true && context.mounted) {
                              context
                                  .read<QuranViewCubit>()
                                  .changeUseTajweedOnIndopak(value);
                            }
                          } else {
                            context
                                .read<QuranViewCubit>()
                                .changeUseTajweedOnIndopak(value);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
