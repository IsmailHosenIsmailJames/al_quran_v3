import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

Widget getScriptSelectionSegmentedButtons(BuildContext context) {
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return BlocBuilder<QuranViewCubit, QuranViewState>(
        builder:
            (context, quranViewState) => Row(
              spacing: 5,
              children: List.generate(QuranScriptType.values.length, (index) {
                QuranScriptType currentQuranScriptType =
                    QuranScriptType.values[index];
                return Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          quranViewState.quranScriptType ==
                                  currentQuranScriptType
                              ? themeState.primary
                              : Colors.transparent,
                      foregroundColor:
                          quranViewState.quranScriptType ==
                                  currentQuranScriptType
                              ? Colors.white
                              : themeState.primary,
                      side: BorderSide(color: themeState.primary),
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            0 == index ? roundedRadius : 0,
                          ),
                          bottomLeft: Radius.circular(
                            0 == index ? roundedRadius : 0,
                          ),
                          topRight: Radius.circular(
                            2 == index ? roundedRadius : 0,
                          ),
                          bottomRight: Radius.circular(
                            2 == index ? roundedRadius : 0,
                          ),
                        ),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () async {
                      await Hive.box(
                        "user",
                      ).put("selected_script", currentQuranScriptType.name);

                      context.read<QuranViewCubit>().changeQuranScriptType(
                        currentQuranScriptType,
                      );
                      await loadQuranScript();
                    },
                    label: Text(
                      getLocalizedQuranScriptType(
                        context,
                        currentQuranScriptType,
                      ).capitalize(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    icon:
                        quranViewState.quranScriptType == currentQuranScriptType
                            ? const Icon(Icons.done_rounded)
                            : null,
                  ),
                );
              }),
            ),
      );
    },
  );
}
