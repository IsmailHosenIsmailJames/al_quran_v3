import "package:flutter/material.dart";

const List<String> collectionPresetColors = [
  "4CAF50", // Emerald
  "2196F3", // Blue
  "9C27B0", // Purple
  "FF9800", // Orange
  "E91E63", // Pink
  "00BCD4", // Cyan
  "FF5722", // Deep Orange
  "607D8B", // Slate
];

Color safeParseColor(String? hexColor, {Color defaultColor = Colors.teal}) {
  if (hexColor == null || hexColor.isEmpty) return defaultColor;
  try {
    String cleanHex = hexColor.replaceAll("#", "");
    if (cleanHex.length == 6) {
      return Color(int.parse("0xFF$cleanHex"));
    } else if (cleanHex.length == 8) {
      return Color(int.parse("0x$cleanHex"));
    }
    return defaultColor;
  } catch (e) {
    return defaultColor;
  }
}

String formatRelativeDate(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    if (difference.inHours == 0) {
      if (difference.inMinutes == 0) {
        return "Just now";
      }
      return "${difference.inMinutes}m ago";
    }
    return "${difference.inHours}h ago";
  } else if (difference.inDays < 7) {
    return "${difference.inDays}d ago";
  } else {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

Map<String, dynamic> deepConvertMap(Map map) {
  return map.map((key, value) {
    final stringKey = key.toString();
    if (value is Map) {
      return MapEntry(stringKey, deepConvertMap(value));
    } else if (value is List) {
      return MapEntry(stringKey, _deepConvertList(value));
    }
    return MapEntry(stringKey, value);
  });
}

List _deepConvertList(List list) {
  return list.map((item) {
    if (item is Map) {
      return deepConvertMap(item);
    } else if (item is List) {
      return _deepConvertList(item);
    }
    return item;
  }).toList();
}
