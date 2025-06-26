import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/meta_data/simple_translation.dart";
import "package:al_quran_v3/src/resources/quran_resources/language_code.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TranslationResources extends StatefulWidget {
  const TranslationResources({super.key});

  @override
  State<TranslationResources> createState() => _TranslationResourcesState();
}

class _TranslationResourcesState extends State<TranslationResources> {
  List<String> expandedLanguageKey = [];
  List<Map> downloadedTranslation =
      QuranTranslationFunction.getDownloadedTranslationBooks();
  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: List.generate(simpleTranslation.length, (index) {
          String key = simpleTranslation.keys.elementAt(index);
          List<Map<String, dynamic>> value = simpleTranslation[key]!;

          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(roundedRadius),
                onTap: () {
                  setState(() {
                    if (expandedLanguageKey.contains(key)) {
                      expandedLanguageKey.remove(key);
                    } else {
                      expandedLanguageKey.add(key);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageNativeNames[key] ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        expandedLanguageKey.contains(key)
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),

              if (expandedLanguageKey.contains(key))
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: themeState.primaryShade100),
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: List.generate(value.length, (index) {
                      Map<String, dynamic> data = value[index];
                      return InkWell(
                        onTap: () {},

                        borderRadius: BorderRadius.circular(roundedRadius),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text(data["name"] ?? "")),
                              downloadedTranslation.firstOrNullWhere(
                                        (element) =>
                                            element["name"] ==
                                            data["full_path"],
                                      ) ==
                                      null
                                  ? const SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: Center(
                                      child: Icon(
                                        FluentIcons.arrow_download_24_filled,
                                      ),
                                    ),
                                  )
                                  : SizedBox(
                                    height: 30,
                                    width: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        "Use",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
