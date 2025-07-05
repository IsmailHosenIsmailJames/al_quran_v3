import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Widget themeIconButton(BuildContext context) =>
    BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          style: IconButton.styleFrom(backgroundColor: state.primaryShade100),
          color: state.primary,
          tooltip: AppLocalizations.of(context).changeTheme,
          onPressed: () {
            final themeController = context.read<ThemeCubit>();
            if (state.themeMode == ThemeMode.dark) {
              themeController.setTheme(ThemeMode.light);
            } else if (state.themeMode == ThemeMode.light) {
              themeController.setTheme(ThemeMode.system);
            } else {
              themeController.setTheme(ThemeMode.dark);
            }
          },
          icon:
              state.themeMode == ThemeMode.dark
                  ? const Icon(Icons.dark_mode)
                  : state.themeMode == ThemeMode.light
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.brightness_4),
        );
      },
    );
