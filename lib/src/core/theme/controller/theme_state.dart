import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'theme_state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({
    required ThemeMode themeMode,
    required Color primary,
    required Color primaryShade100,
    required Color primaryShade200,
    required Color primaryShade300,
    required Color secondary,
    required Color mutedGray,
  }) = _ThemeState;
}
