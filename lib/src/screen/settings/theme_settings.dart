import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

Color defaultPrimary = const Color(0xFF009688);

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  static List<Color> appColor = [
    defaultPrimary,
    Colors.blue,
    Colors.deepPurple,
    Colors.orange,
    Colors.blueGrey,

    // New Additions
    Colors.green, // A natural, calming green
    Colors.red, // A classic, bold red
    Colors.indigo, // A deep, professional blue
    Colors.brown, // An earthy, warm tone
    Colors.pink, // A vibrant, warm option
    Colors.amber, // A bright, golden color
    Colors.cyan, // A fresh, bright blue
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(appColor.length, (index) {
              Color current = appColor[index];
              bool isSelected =
                  themeState.primary.toARGB32() == current.toARGB32();
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    context.read<ThemeCubit>().changePrimaryColor(current);
                  },
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: current,
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    child: isSelected ? const Icon(Icons.done) : null,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
