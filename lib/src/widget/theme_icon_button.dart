import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Widget themeIconButton(BuildContext context) =>
    BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryShade100,
          ),
          color: AppColors.primary,
          tooltip: "Change Theme",
          onPressed: () {
            final themeController = context.read<ThemeCubit>();
            if (state == ThemeMode.dark) {
              themeController.setTheme(ThemeMode.light);
            } else if (state == ThemeMode.light) {
              themeController.setTheme(ThemeMode.system);
            } else {
              themeController.setTheme(ThemeMode.dark);
            }
          },
          icon:
              state == ThemeMode.dark
                  ? const Icon(Icons.dark_mode)
                  : state == ThemeMode.light
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.brightness_4),
        );
      },
    );
