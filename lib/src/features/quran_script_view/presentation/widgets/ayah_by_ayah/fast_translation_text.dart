import "package:flutter/material.dart";

/// A high-performance, zero-DOM text renderer for Quran translations and footnotes.
///
/// Parses inline formatting tags (`<b>`, `<i>`, `<u>`, `<sup>`, `<sub>`, `<foot_note>`) and
/// decodes HTML entities into native Flutter [TextSpan]s without the heavy
/// CPU/DOM overhead of full HTML parsers.
class FastTranslationText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final void Function(String footnoteId)? onFootnoteTap;

  const FastTranslationText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.onFootnoteTap,
  });

  @override
  Widget build(BuildContext context) {
    final spans = _parseStyledSpans(text, style, context);
    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }

  static String _decodeHtmlEntities(String input) {
    return input
        .replaceAll("&quot;", '"')
        .replaceAll("&amp;", "&")
        .replaceAll("&lt;", "<")
        .replaceAll("&gt;", ">")
        .replaceAll("&apos;", "'")
        .replaceAll("&#39;", "'")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&#8216;", "'")
        .replaceAll("&#8217;", "'")
        .replaceAll("&#8220;", '"')
        .replaceAll("&#8221;", '"')
        .replaceAll("&#8211;", "–")
        .replaceAll("&#8212;", "—");
  }

  static List<InlineSpan> _parseStyledSpans(
    String rawHtml,
    TextStyle baseStyle,
    BuildContext context,
  ) {
    if (rawHtml.isEmpty) return const [];

    final spans = <InlineSpan>[];
    final regex = RegExp(
      r"<(/?[a-zA-Z0-9_\-]+)(?:\s+[^>]*)?>|([^<]+)",
      multiLine: true,
    );

    bool isBold = false;
    bool isItalic = false;
    bool isUnderline = false;
    bool isSup = false;
    bool isSub = false;

    final matches = regex.allMatches(rawHtml);

    for (final match in matches) {
      final fullMatch = match.group(0) ?? "";

      if (fullMatch.startsWith("<")) {
        final tag = match.group(1)?.toLowerCase() ?? "";
        final isClosing = tag.startsWith("/");
        final tagName = isClosing ? tag.substring(1) : tag;

        switch (tagName) {
          case "b":
          case "strong":
            isBold = !isClosing;
            break;
          case "i":
          case "em":
            isItalic = !isClosing;
            break;
          case "u":
            isUnderline = !isClosing;
            break;
          case "sup":
          case "foot_note":
            isSup = !isClosing;
            break;
          case "sub":
            isSub = !isClosing;
            break;
        }
      } else {
        final text = _decodeHtmlEntities(fullMatch);
        if (text.isEmpty) continue;

        TextStyle currentStyle = baseStyle;

        if (isBold) {
          currentStyle = currentStyle.copyWith(fontWeight: FontWeight.bold);
        }
        if (isItalic) {
          currentStyle = currentStyle.copyWith(fontStyle: FontStyle.italic);
        }
        if (isUnderline) {
          currentStyle = currentStyle.copyWith(
            decoration: TextDecoration.underline,
          );
        }
        if (isSup) {
          currentStyle = currentStyle.copyWith(
            fontSize: (baseStyle.fontSize ?? 14) * 0.75,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          );
          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Transform.translate(
                offset: const Offset(0, -3),
                child: Text(text, style: currentStyle),
              ),
            ),
          );
          continue;
        }
        if (isSub) {
          currentStyle = currentStyle.copyWith(
            fontSize: (baseStyle.fontSize ?? 14) * 0.75,
          );
        }

        spans.add(TextSpan(text: text, style: currentStyle));
      }
    }

    if (spans.isEmpty) {
      spans.add(TextSpan(text: _decodeHtmlEntities(rawHtml), style: baseStyle));
    }

    return spans;
  }
}
