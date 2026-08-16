import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_rules.dart";
import "package:flutter/material.dart";
import "package:html/dom.dart" as dom;
import "package:html/parser.dart" show parseFragment;

/// A widget that parses Quran text formatted with Tajweed `<rule class="...">` tags
/// and renders text spans where ONLY the tagged letters receive the Tajweed color,
/// while non-tagged letters remain in standard text color.
class TajweedTaggedText extends StatelessWidget {
  final String taggedText;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextDirection textDirection;

  const TajweedTaggedText({
    super.key,
    required this.taggedText,
    this.style,
    this.textAlign = TextAlign.center,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bool isLight = brightness == Brightness.light;

    final Map<String, Color> themeColors = {
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
      HamWaslRule.key: isLight
          ? HamWaslRule.lightColor
          : HamWaslRule.darkColor,
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

    final defaultTextColor =
        style?.color ??
        Theme.of(context).textTheme.bodyLarge?.color ??
        (isLight ? Colors.black : Colors.white);

    final TextStyle baseStyle = (style ?? const TextStyle()).copyWith(
      fontFamily: style?.fontFamily ?? "QPC_Hafs",
      color: defaultTextColor,
    );

    List<TextSpan> spans = [];

    void extractNodes(dom.Node node, Color currentColor) {
      if (node.nodeType == dom.Node.TEXT_NODE) {
        if (node.text != null && node.text!.isNotEmpty) {
          spans.add(
            TextSpan(
              text: node.text,
              style: baseStyle.copyWith(color: currentColor),
            ),
          );
        }
      } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
        dom.Element element = node as dom.Element;
        Color nextColor = currentColor;

        if (element.localName == "rule") {
          String? ruleClass = element.attributes["class"];
          if (ruleClass != null && themeColors.containsKey(ruleClass)) {
            nextColor = themeColors[ruleClass]!;
          }
        }

        for (var childNode in element.nodes) {
          extractNodes(childNode, nextColor);
        }
      }
    }

    final fragment = parseFragment(taggedText);
    for (var node in fragment.nodes) {
      extractNodes(node, defaultTextColor);
    }

    return Text.rich(
      TextSpan(children: spans, style: baseStyle),
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
