import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/app_languages/cubit/language_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppLanguages extends StatefulWidget {
  const AppLanguages({super.key});

  @override
  State<AppLanguages> createState() => _AppLanguagesState();
}

class _AppLanguagesState extends State<AppLanguages> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text("App Languages")),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return Scrollbar(
            controller: scrollController,
            interactive: true,
            thickness: 10,
            radius: Radius.circular(roundedRadius),
            child: ListView.builder(
              controller: scrollController,
              itemCount: usedAppLanguageMap.length,
              itemBuilder: (context, index) {
                Map current = usedAppLanguageMap[index];
                String englishName = current["English"];
                String nativeName = current["Native"];
                String languageCode = current["Code"];
                bool isSelected =
                    languageState.locale.languageCode == languageCode;

                return ListTile(
                  minTileHeight: 40,
                  leading:
                      isSelected
                          ? Icon(
                            Icons.check_circle_rounded,
                            color: themeState.primary,
                          )
                          : Icon(
                            Icons.radio_button_unchecked_rounded,
                            color: themeState.primary,
                          ),
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(languageCode);
                  },
                  title: Text(
                    nativeName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(englishName),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
