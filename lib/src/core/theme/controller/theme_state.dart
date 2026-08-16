import "package:flutter/material.dart";

class ThemeState {
  ThemeMode themeMode;
  Color primary;
  Color primaryShade100;
  Color primaryShade200;
  Color primaryShade300;
  Color secondary;
  Color mutedGray;

  ThemeState({
    required this.themeMode,
    required this.primary,
    required this.primaryShade100,
    required this.primaryShade200,
    required this.primaryShade300,
    required this.secondary,
    required this.mutedGray,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? primary,
    Color? primaryShade100,
    Color? primaryShade200,
    Color? primaryShade300,
    Color? secondary,
    Color? mutedGray,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      primary: primary ?? this.primary,
      primaryShade100: primaryShade100 ?? this.primaryShade100,
      primaryShade200: primaryShade200 ?? this.primaryShade200,
      primaryShade300: primaryShade300 ?? this.primaryShade300,
      secondary: secondary ?? this.secondary,
      mutedGray: mutedGray ?? this.mutedGray,
    );
  }
}
