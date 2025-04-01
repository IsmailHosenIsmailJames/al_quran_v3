import 'package:al_quran_v3/main.dart';
import 'package:al_quran_v3/src/widget/quran_script/model/script_info.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:html/dom.dart' as dom;

class TajweedView extends StatelessWidget {
  final ScriptInfo scriptInfo;
  const TajweedView({super.key, required this.scriptInfo});

  @override
  Widget build(BuildContext context) {
    List words =
        tajweedScript[scriptInfo.surahNumber.toString()][scriptInfo.ayahNumber
            .toString()];
    return Text.rich(
      style: TextStyle(fontSize: 24, fontFamily: 'QPC_Hafs'),
      TextSpan(
        children: List.generate(words.length, (index) {
          return parseTajweedWord(
            words[index],
            TextStyle(fontSize: 24, fontFamily: 'QPC_Hafs'),
          );
        }),
      ),
    );
  }
}

// Define your Tajweed colors (adjust these to standard Tajweed colors)
const Color maddaNormalColor = Colors.blueAccent; // Example
const Color hamWaslColor = Colors.grey; // Example
const Color idghamWoGhunnahColor = Colors.orange; // Example
const Color maddaPermissibleColor = Colors.lightBlue; // Example
const Color defaultTextColor = Colors.black; // Or your default text color
const Color alefMaksoraColor =
    Colors.purple; // Example for custom rules if needed

final Map<String, Color> tajweedRuleColors = {
  'madda_normal': maddaNormalColor,
  'ham_wasl': hamWaslColor, // Often not colored, but depends on convention
  'idgham_wo_ghunnah': idghamWoGhunnahColor,
  'madda_permissible': maddaPermissibleColor,
  'custom-alef-maksora': alefMaksoraColor, // Handling the nested example
  // Add ALL other rule classes used in your JSON data here
  // 'ikhfa': Colors.green,
  // 'idgham_ghunnah': Colors.purple,
  // 'iqlab': Colors.red,
  // 'madda_obligatory': Colors.redAccent,
  // ... etc
};

// --- Include the tajweedRuleColors map from step 2 here ---

TextSpan parseTajweedWord(String wordHtml, TextStyle baseStyle) {
  List<TextSpan> spans = [];
  // Parse the HTML-like string into a DOM fragment
  dom.DocumentFragment fragment = parseFragment(wordHtml);

  // Recursive function to traverse the DOM nodes
  void processNode(dom.Node node, Color currentColor) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      // If it's plain text, add a TextSpan with the current color
      spans.add(
        TextSpan(
          text: node.text,
          style: baseStyle.copyWith(color: currentColor),
        ),
      );
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      dom.Element element = node as dom.Element;
      Color nextColor = currentColor; // Inherit color by default

      // Check if it's our <rule> tag
      if (element.localName == 'rule') {
        String? ruleClass = element.attributes['class'];
        if (ruleClass != null && tajweedRuleColors.containsKey(ruleClass)) {
          // If a rule class exists and we have a color for it, use that color
          nextColor = tajweedRuleColors[ruleClass]!;
        } else {
          // Optional: Handle unknown rule classes (e.g., log warning, use default)
          print(
            "Warning: Unknown Tajweed rule class '$ruleClass' in word: $wordHtml",
          );
        }
      }

      // Recursively process child nodes with the determined color
      if (element.nodes.isNotEmpty) {
        for (var childNode in element.nodes) {
          processNode(childNode, nextColor);
        }
      }
    }
  }

  // Start processing from the fragment's children with the default text color
  for (var node in fragment.nodes) {
    processNode(node, baseStyle.color ?? defaultTextColor);
  }

  // Return a single TextSpan containing all the generated child spans
  // This is necessary because RichText expects a single root TextSpan
  return TextSpan(children: spans, style: baseStyle);
}

// Inside your widget's build method where you display the words

// Assume 'words' is your list from the JSON, e.g.,
// List<String> words = ["ذ<rule...>...", "<rule...>ٱلۡكِتَـٰبُ", ...];

// Define your base text style (MUST include the correct font family)
final TextStyle baseQuranTextStyle = TextStyle(
  fontFamily:
      'QPC_Hafs', // Make sure this matches your pubspec.yaml font family
  fontSize: 24,
  height: 2.0,
  color: defaultTextColor, // Base color if no rule applies
);

// Example using a Wrap widget
Widget build(BuildContext context) {
  List<String> words = [
    // Example data from ayah 2:2
    "ذ<rule class=madda_normal><rule class=custom-alef-maksora>ٰ</rule></rule>لِكَ",
    "<rule class=ham_wasl>ٱ</rule>لۡكِتَ<rule class=madda_normal>ـٰ</rule>بُ",
    "لَا",
    "رَيۡبَ‌ۛ",
    "فِيهِ‌ۛ",
    "هُ<rule class=idgham_wo_ghunnah>دًى</rule>",
    "<rule class=idgham_wo_ghunnah>ل</rule>ِّلۡمُتَّق<rule class=madda_permissible>ِي</rule>نَ",
    "٢", // Ayah number - handle separately if needed
  ];

  // Filter out the ayah number if it's part of the list
  List<String> quranWords =
      words.where((word) => !word.contains(RegExp(r'^[٠-٩]+$'))).toList();
  String ayahEndSymbol = words.firstWhere(
    (word) => word.contains(RegExp(r'^[٠-٩]+$')),
    orElse: () => "",
  );

  return Directionality(
    textDirection: TextDirection.rtl,
    child: Wrap(
      alignment: WrapAlignment.start,
      textDirection: TextDirection.rtl,
      runSpacing: 8.0, // Spacing between lines
      spacing: 4.0, // Spacing between words
      children: [
        ...quranWords.map((word) {
          return RichText(
            textDirection: TextDirection.rtl,
            text: parseTajweedWord(word, baseQuranTextStyle),
          );
        }).toList(),
        // Optionally, display the ayah number separately
        if (ayahEndSymbol.isNotEmpty)
          Text(
            ayahEndSymbol,
            textDirection: TextDirection.rtl,
            style: baseQuranTextStyle.copyWith(
              color: Colors.redAccent,
            ), // Style ayah number differently
          ),
      ],
    ),
  );
}
