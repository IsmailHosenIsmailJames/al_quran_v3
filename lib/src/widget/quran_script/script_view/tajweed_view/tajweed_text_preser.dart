import "dart:developer";

import "package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_rules.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:html/parser.dart" show parseFragment;
import "package:html/dom.dart" as dom;

TextSpan parseTajweedWord({
  required TextStyle baseStyle,
  required BuildContext context,
  required List<String> words,
  required int surahNumber,
  required int ayahNumber,
  required bool skipWordTap,
  required wordIndex,
}) {
  List<TextSpan> spans = [];
  final brightness = Theme.of(context).brightness;
  final bool isLight = brightness == Brightness.light;

  final Map<String, Color> currentThemeColors = {
    GhunnahRule.key: isLight ? GhunnahRule.lightColor : GhunnahRule.darkColor,
    IdghamShafawiRule.key:
        isLight ? IdghamShafawiRule.lightColor : IdghamShafawiRule.darkColor,
    IqlabRule.key: isLight ? IqlabRule.lightColor : IqlabRule.darkColor,
    IkhafaShafawiRule.key:
        isLight ? IkhafaShafawiRule.lightColor : IkhafaShafawiRule.darkColor,
    QalqalahRule.key: isLight ? QalqalahRule.lightColor : QalqalahRule.darkColor,
    IdghamGhunnahRule.key:
        isLight ? IdghamGhunnahRule.lightColor : IdghamGhunnahRule.darkColor,
    IdghamWoGhunnahRule.key:
        isLight ? IdghamWoGhunnahRule.lightColor : IdghamWoGhunnahRule.darkColor,
    IkhafaRule.key: isLight ? IkhafaRule.lightColor : IkhafaRule.darkColor,
    MaddTabiiRule.key:
        isLight ? MaddTabiiRule.lightColor : MaddTabiiRule.darkColor,
    MaddLazimRule.key:
        isLight ? MaddLazimRule.lightColor : MaddLazimRule.darkColor,
    MaddLeenRule.key: isLight ? MaddLeenRule.lightColor : MaddLeenRule.darkColor,
    MaddWajibMuttasilRule.key: isLight
        ? MaddWajibMuttasilRule.lightColor
        : MaddWajibMuttasilRule.darkColor,
    MaddJaizMunfasilRule.key: isLight
        ? MaddJaizMunfasilRule.lightColor
        : MaddJaizMunfasilRule.darkColor,
    HamWaslRule.key: isLight ? HamWaslRule.lightColor : HamWaslRule.darkColor,
    LaamShamsiyahRule.key:
        isLight ? LaamShamsiyahRule.lightColor : LaamShamsiyahRule.darkColor,
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
      (brightness == Brightness.light ? Colors.black : Colors.white);

  final TextStyle processingStyle = baseStyle.copyWith(color: defaultColor);

  void processNode(dom.Node node, Color currentColor) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      spans.add(
        TextSpan(
          text: node.text,
          style: processingStyle.copyWith(color: currentColor),
          recognizer: skipWordTap == true
              ? null
              : (TapGestureRecognizer()
                ..onTap = () {
                  List<String> wordKeys = List.generate(
                    words.length,
                    (index) => "$surahNumber:$ayahNumber:${index + 1}",
                  );
                  showPopupWordFunction(
                    context: context,
                    wordKeys: wordKeys,
                    initWordIndex: wordIndex,
                  );
                }),
        ),
      );
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      dom.Element element = node as dom.Element;
      Color nextColor = currentColor;

      if (element.localName == "rule") {
        String? ruleClass = element.attributes["class"];
        if (ruleClass != null && currentThemeColors.containsKey(ruleClass)) {
          nextColor = currentThemeColors[ruleClass]!;
        } else if (ruleClass != null) {
          log(
            "Warning: Unknown/unmapped Tajweed rule class '$ruleClass' in word: ${words[wordIndex]} ",
          );
        }
      }

      if (element.nodes.isNotEmpty) {
        for (var childNode in element.nodes) {
          processNode(childNode, nextColor);
        }
      }
    }
  }

  for (var node in parseFragment("${words[wordIndex]} ").nodes) {
    processNode(node, defaultColor);
  }

  return TextSpan(children: spans, style: processingStyle);
}

String getPlainTextAyahFromTajweedWords(List<String> tajweedWords) {
  List<String> plainWords = [];
  for (String wordWithTajweed in tajweedWords) {
    final documentFragment = parseFragment(wordWithTajweed);

    String textContent = "";
    void extractText(dom.Node node) {
      if (node.nodeType == dom.Node.TEXT_NODE) {
        textContent += node.text ?? "";
      } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
        for (var childNode in node.nodes) {
          extractText(childNode);
        }
      }
    }

    for (var node in documentFragment.nodes) {
      extractText(node);
    }
    plainWords.add(textContent);
  }

  return plainWords.join(" ").trim();
}