import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/ayah_by_ayah/fast_translation_text.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("FastTranslationText Widget Tests", () {
    testWidgets("renders plain translation text correctly", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FastTranslationText(
              text: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );

      expect(
        find.text(
          "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
          findRichText: true,
        ),
        findsOneWidget,
      );
    });

    testWidgets("decodes HTML entities and handles inline tags without error", (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FastTranslationText(
              text: "They said, &quot;<b>Glory</b> be to <i>You</i>!&quot;",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );

      expect(find.byType(FastTranslationText), findsOneWidget);
    });

    testWidgets("renders superscript footnote tags cleanly", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FastTranslationText(
              text: "This is a verse with a footnote<sup foot_note=1>1</sup> attached.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );

      expect(find.byType(FastTranslationText), findsOneWidget);
    });
  });
}
