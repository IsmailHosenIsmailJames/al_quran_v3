import "package:flutter/material.dart";

Color safeParseColor(String? hexColor, {Color defaultColor = Colors.grey}) {
  if (hexColor == null || hexColor.isEmpty) return defaultColor;
  try {
    return Color(int.parse("0xFF$hexColor"));
  } catch (e) {
    return defaultColor;
  }
}
