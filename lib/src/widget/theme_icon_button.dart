import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

Widget themeIconButton(BuildContext context) =>
    BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.withValues(alpha: 0.1),
          ),
          color: Colors.green.shade600,
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
