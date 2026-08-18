import "package:al_quran_v3/src/features/search/domain/utils/arabic_text_normalizer.dart";
import "package:flutter/material.dart";

/// A high-performance text highlighter for search matches in Arabic, English,
/// Bengali, Urdu, and other languages.
class TextHighlighter {
  TextHighlighter._();

  /// Builds a [List<InlineSpan>] with highlighted match segments.
  static List<InlineSpan> highlight({
    required String text,
    required String query,
    required TextStyle baseStyle,
    required Color highlightColor,
    Color? highlightBgColor,
  }) {
    if (text.isEmpty || query.trim().isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final trimmedQuery = query.trim();
    final isArabic = ArabicTextNormalizer.containsArabic(trimmedQuery);

    if (isArabic) {
      return _highlightArabic(
        text: text,
        query: trimmedQuery,
        baseStyle: baseStyle,
        highlightColor: highlightColor,
        highlightBgColor: highlightBgColor,
      );
    } else {
      return _highlightStandard(
        text: text,
        query: trimmedQuery,
        baseStyle: baseStyle,
        highlightColor: highlightColor,
        highlightBgColor: highlightBgColor,
      );
    }
  }

  static List<InlineSpan> _highlightStandard({
    required String text,
    required String query,
    required TextStyle baseStyle,
    required Color highlightColor,
    Color? highlightBgColor,
  }) {
    final spans = <InlineSpan>[];
    final highlightStyle = baseStyle.copyWith(
      color: highlightColor,
      fontWeight: FontWeight.bold,
      backgroundColor: highlightBgColor,
    );

    // Escape special regex characters
    final escapedQuery = RegExp.escape(query);
    final regex = RegExp(escapedQuery, caseSensitive: false);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      // Try individual words if multi-word query
      final words = query
          .split(RegExp(r"\s+"))
          .where((w) => w.length > 1)
          .map(RegExp.escape)
          .join("|");

      if (words.isNotEmpty) {
        final wordRegex = RegExp(words, caseSensitive: false);
        final wordMatches = wordRegex.allMatches(text);
        if (wordMatches.isNotEmpty) {
          int lastIndex = 0;
          for (final match in wordMatches) {
            if (match.start > lastIndex) {
              spans.add(TextSpan(
                text: text.substring(lastIndex, match.start),
                style: baseStyle,
              ));
            }
            spans.add(TextSpan(
              text: text.substring(match.start, match.end),
              style: highlightStyle,
            ));
            lastIndex = match.end;
          }
          if (lastIndex < text.length) {
            spans.add(TextSpan(
              text: text.substring(lastIndex),
              style: baseStyle,
            ));
          }
          return spans;
        }
      }

      return [TextSpan(text: text, style: baseStyle)];
    }

    int lastIndex = 0;
    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: baseStyle,
        ));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: highlightStyle,
      ));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: baseStyle,
      ));
    }

    return spans;
  }

  static List<InlineSpan> _highlightArabic({
    required String text,
    required String query,
    required TextStyle baseStyle,
    required Color highlightColor,
    Color? highlightBgColor,
  }) {
    final spans = <InlineSpan>[];
    final highlightStyle = baseStyle.copyWith(
      color: highlightColor,
      fontWeight: FontWeight.bold,
      backgroundColor: highlightBgColor,
    );

    final normalizedQuery = ArabicTextNormalizer.normalize(query);
    if (normalizedQuery.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    // Split words in Arabic text and check normalized forms
    final rawWords = text.split(" ");
    for (int i = 0; i < rawWords.length; i++) {
      final word = rawWords[i];
      final normalizedWord = ArabicTextNormalizer.normalize(word);

      final isMatch = normalizedWord.contains(normalizedQuery);

      if (isMatch) {
        spans.add(TextSpan(text: word, style: highlightStyle));
      } else {
        spans.add(TextSpan(text: word, style: baseStyle));
      }

      if (i < rawWords.length - 1) {
        spans.add(TextSpan(text: " ", style: baseStyle));
      }
    }

    return spans;
  }
}
