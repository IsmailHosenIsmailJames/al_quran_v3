import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:dartx/dartx_io.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

Widget getScriptSelectionSegmentedButtons(BuildContext context) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return BlocBuilder<QuranViewCubit, QuranViewState>(
        builder: (context, quranViewState) => FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SegmentedButton(
                selected: {quranViewState.quranScriptType},
                segments: List<ButtonSegment<QuranScriptType>>.generate(
                  QuranScriptType.values.length,
                  (index) {
                    return ButtonSegment<QuranScriptType>(
                      value: QuranScriptType.values.elementAt(index),

                      label: Text(
                        getLocalizedQuranScriptType(
                          context,
                          QuranScriptType.values.elementAt(index),
                        ).capitalize(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),

                selectedIcon: const Icon(Icons.done),

                onSelectionChanged: (value) async {
                  await Hive.box(
                    "user",
                  ).put("selected_script", value.first.name);
                  await QuranScriptFunction.loadScript(value.first);
                  context.read<QuranViewCubit>().changeQuranScriptType(
                    value.first,
                  );
                },
              ),
              const Gap(16),
              SizedBox(
                width: 150,
                child: Material(
                  color: Colors.transparent,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                      Set<WidgetState> states,
                    ) {
                      return Icon(
                        states.contains(WidgetState.selected)
                            ? Icons.done_rounded
                            : Icons.close_rounded,
                      );
                    }),
                    title: Text(AppLocalizations.of(context).quranScriptTajweed),
                    value:
                        quranViewState.quranScriptType == QuranScriptType.uthmani
                        ? quranViewState.useTajweedOnUthmani
                        : quranViewState.useTajweedOnIndopak,
                    onChanged: (value) async {
                      if (quranViewState.quranScriptType ==
                          QuranScriptType.uthmani) {
                        context.read<QuranViewCubit>().changeUseTajweedOnUthmani(
                          value,
                        );
                      } else {
                        if (value) {
                          final willApply = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context).warning),
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).warningMessageOnIndopakTajweedEnable,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).cancel,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).apply,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          if (willApply == true) {
                            if (context.mounted) {
                              context
                                  .read<QuranViewCubit>()
                                  .changeUseTajweedOnIndopak(value);
                            }
                          }
                        } else {
                          context
                              .read<QuranViewCubit>()
                              .changeUseTajweedOnIndopak(value);
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
