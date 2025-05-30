import "dart:developer";

import "package:al_quran_v3/src/functions/quran_word/show_popup_word_function.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:html/parser.dart" show parseFragment;
import "package:html/dom.dart" as dom;

import "color/tajweed_dark.dart";
import "color/tajweed_light.dart";

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
  final currentThemeColors =
      brightness == Brightness.light
          ? lightThemeTajweedColors
          : darkThemeTajweedColors;

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
          recognizer:
              skipWordTap == true
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
                        words: List<String>.from(words),
                        scriptCategory: QuranScriptType.tajweed,
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
            "Warning: Unknown/unmapped Tajweed rule class '$ruleClass' in word: ${'${words[wordIndex]} '}",
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
