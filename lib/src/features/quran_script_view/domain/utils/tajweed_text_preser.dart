import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_rules.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:html/parser.dart" show parseFragment;
import "package:html/dom.dart" as dom;

class _WordToken {
  final String text;
  final String? ruleClass;
  const _WordToken(this.text, [this.ruleClass]);
}

// In-memory cache for parsed HTML tokens of tajweed words to avoid repeated DOM parsing
final Map<String, List<_WordToken>> _tokenCache = {};
final Map<String, String> _plainTextWordCache = {};

List<_WordToken> _tokenizeTajweedWord(String rawWord) {
  final cached = _tokenCache[rawWord];
  if (cached != null) return cached;

  final List<_WordToken> tokens = [];
  final fragment = parseFragment("$rawWord ");

  void walk(dom.Node node, String? currentRule) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      if (node.text != null && node.text!.isNotEmpty) {
        tokens.add(_WordToken(node.text!, currentRule));
      }
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      final el = node as dom.Element;
      final rule = el.localName == "rule" ? el.attributes["class"] : currentRule;
      for (final child in el.nodes) {
        walk(child, rule);
      }
    }
  }

  for (final rootNode in fragment.nodes) {
    walk(rootNode, null);
  }

  _tokenCache[rawWord] = tokens;
  return tokens;
}

TextSpan parseTajweedWord({
  required TextStyle baseStyle,
  required BuildContext context,
  required List<String> words,
  required int surahNumber,
  required int ayahNumber,
  required bool skipWordTap,
  required bool tajweedColorEnable,
  required dynamic wordIndex,
}) {
  final brightness = Theme.brightnessOf(context);
  final bool isLight = brightness == Brightness.light;

  final Map<String, Color> currentThemeColors = {
    GhunnahRule.key: isLight ? GhunnahRule.lightColor : GhunnahRule.darkColor,
    IdghamShafawiRule.key: isLight
        ? IdghamShafawiRule.lightColor
        : IdghamShafawiRule.darkColor,
    IqlabRule.key: isLight ? IqlabRule.lightColor : IqlabRule.darkColor,
    IkhafaShafawiRule.key: isLight
        ? IkhafaShafawiRule.lightColor
        : IkhafaShafawiRule.darkColor,
    QalqalahRule.key: isLight
        ? QalqalahRule.lightColor
        : QalqalahRule.darkColor,
    IdghamGhunnahRule.key: isLight
        ? IdghamGhunnahRule.lightColor
        : IdghamGhunnahRule.darkColor,
    IdghamWoGhunnahRule.key: isLight
        ? IdghamWoGhunnahRule.lightColor
        : IdghamWoGhunnahRule.darkColor,
    IkhafaRule.key: isLight ? IkhafaRule.lightColor : IkhafaRule.darkColor,
    MaddTabiiRule.key: isLight
        ? MaddTabiiRule.lightColor
        : MaddTabiiRule.darkColor,
    MaddLazimRule.key: isLight
        ? MaddLazimRule.lightColor
        : MaddLazimRule.darkColor,
    MaddLeenRule.key: isLight
        ? MaddLeenRule.lightColor
        : MaddLeenRule.darkColor,
    MaddWajibMuttasilRule.key: isLight
        ? MaddWajibMuttasilRule.lightColor
        : MaddWajibMuttasilRule.darkColor,
    MaddJaizMunfasilRule.key: isLight
        ? MaddJaizMunfasilRule.lightColor
        : MaddJaizMunfasilRule.darkColor,
    HamWaslRule.key: isLight ? HamWaslRule.lightColor : HamWaslRule.darkColor,
    LaamShamsiyahRule.key: isLight
        ? LaamShamsiyahRule.lightColor
        : LaamShamsiyahRule.darkColor,
    SlntRule.key: isLight ? SlntRule.lightColor : SlntRule.darkColor,
    IdghamMutajanisaynRule.key: isLight
        ? IdghamMutajanisaynRule.lightColor
        : IdghamMutajanisaynRule.darkColor,
    IdghamMutaqaribaynRule.key: isLight
        ? IdghamMutaqaribaynRule.lightColor
        : IdghamMutaqaribaynRule.darkColor,
    CustomAlefMaksoraRule.key: isLight
        ? CustomAlefMaksoraRule.lightColor
        : CustomAlefMaksoraRule.darkColor,
  };

  final defaultColor =
      baseStyle.color ??
      Theme.of(context).textTheme.bodyMedium?.color ??
      (isLight ? Colors.black : Colors.white);

  final TextStyle processingStyle = baseStyle.copyWith(color: defaultColor);
  final int wIndex = wordIndex is int ? wordIndex : (int.tryParse(wordIndex.toString()) ?? 0);
  final bool isLastWord = wIndex == words.length - 1;
  final String rawWord = words[wIndex];

  GestureRecognizer? recognizer;

  if (!tajweedColorEnable) {
    return TextSpan(
      text: "${getPlainTextAyahFromTajweedWords([rawWord])} ",
      style: processingStyle.copyWith(
        fontFamily: isLastWord ? "QPC_Hafs" : null,
      ),
      recognizer: recognizer,
    );
  }

  final tokens = _tokenizeTajweedWord(rawWord);
  final List<TextSpan> spans = tokens.map((token) {
    Color color = defaultColor;
    if (token.ruleClass != null && currentThemeColors.containsKey(token.ruleClass)) {
      color = currentThemeColors[token.ruleClass]!;
    }
    return TextSpan(
      text: token.text,
      style: processingStyle.copyWith(
        color: color,
        fontFamily: isLastWord ? "QPC_Hafs" : null,
      ),
      recognizer: recognizer,
    );
  }).toList();

  return TextSpan(children: spans, style: processingStyle);
}

String getPlainTextAyahFromTajweedWords(List<String> tajweedWords) {
  List<String> plainWords = [];
  for (String wordWithTajweed in tajweedWords) {
    final cached = _plainTextWordCache[wordWithTajweed];
    if (cached != null) {
      plainWords.add(cached);
      continue;
    }

    final tokens = _tokenizeTajweedWord(wordWithTajweed);
    final text = tokens.map((t) => t.text).join("").trim();
    _plainTextWordCache[wordWithTajweed] = text;
    plainWords.add(text);
  }

  return plainWords.join(" ").trim();
}
