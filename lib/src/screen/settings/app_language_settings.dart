import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppLanguageSettings extends StatefulWidget {
  const AppLanguageSettings({super.key});

  @override
  State<AppLanguageSettings> createState() => _AppLanguageSettingsState();
}

class _AppLanguageSettingsState extends State<AppLanguageSettings> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.languageSettings)),
      body: BlocBuilder<LanguageCubit, MyAppLocalization>(
        builder: (context, languageState) {
          return Scrollbar(
            controller: scrollController,
            thickness: 10,
            radius: Radius.circular(roundedRadius),
            interactive: true,
            child: ListView.builder(
              controller: scrollController,
              itemCount: usedAppLanguageMap.length,
              itemBuilder: (context, index) {
                MyAppLocalization current = usedAppLanguageMap[index];
                return Container(
                  color:
                      index % 2 == 1
                          ? themeState.primaryShade100.withValues(alpha: 0.05)
                          : null,
                  child: ListTile(
                    minTileHeight: 40,
                    title: Text(current.native),
                    subtitle: Text(current.english),
                    leading: Icon(
                      languageState.locale.languageCode ==
                              current.locale.countryCode
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      color: themeState.primary,
                    ),
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage(current);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
