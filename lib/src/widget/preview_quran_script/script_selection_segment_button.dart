import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_script_function.dart";
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
            (context, quranViewState) => SizedBox(
              width: 600,
              child: SegmentedButton(
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
                  await QuranScriptFunction.initQuranScript(value.first);
                  context.read<QuranViewCubit>().changeQuranScriptType(
                    value.first,
                  );
                },
              ),
            ),
      );
    },
  );
}
