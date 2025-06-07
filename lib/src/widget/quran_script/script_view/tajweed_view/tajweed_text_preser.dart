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
    // Ensure the word is treated as a fragment of HTML
    // The .text property of the document fragment will concatenate all text nodes
    final documentFragment = parseFragment(wordWithTajweed);
    // documentFragment.text alone might not be sufficient if words are like "word1<tag>word2</tag>"
    // and we want "word1word2". The .text gives the text content of the node and its descendants.
    // Iterating through nodes and getting text content directly is more robust for fragments.
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
  // Join the plain words with spaces. If the last word is an ayah number,
  // it might be desirable to not add a space before it, but the example shows "رَّحِيمِ, ١"
  // so a simple join with space is fine.
  return plainWords.join(" ").trim();
}
