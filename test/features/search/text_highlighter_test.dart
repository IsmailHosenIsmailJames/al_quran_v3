import "package:al_quran_v3/src/features/search/domain/utils/text_highlighter.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("TextHighlighter Unit Tests", () {
    test("returns standard single span when query is empty", () {
      final spans = TextHighlighter.highlight(
        text: "In the name of Allah",
        query: "",
        baseStyle: const TextStyle(color: Colors.black),
        highlightColor: Colors.amber,
      );

      expect(spans.length, 1);
      expect((spans.first as TextSpan).text, "In the name of Allah");
    });

    test("highlights matched English words properly", () {
      final spans = TextHighlighter.highlight(
        text: "Praise be to Allah, Lord of the worlds.",
        query: "Allah",
        baseStyle: const TextStyle(color: Colors.black),
        highlightColor: Colors.green,
      );

      expect(spans.length, 3);
      expect((spans[0] as TextSpan).text, "Praise be to ");
      expect((spans[1] as TextSpan).text, "Allah");
      expect((spans[1] as TextSpan).style?.color, Colors.green);
      expect((spans[2] as TextSpan).text, ", Lord of the worlds.");
    });

    test("highlights Arabic normalized word matches", () {
      final spans = TextHighlighter.highlight(
        text: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
        query: "الرحمن",
        baseStyle: const TextStyle(color: Colors.black),
        highlightColor: Colors.blue,
      );

      expect(spans.any((s) => (s as TextSpan).text?.contains("الرَّحْمَٰنِ") == true), isTrue);
    });
  });
}
