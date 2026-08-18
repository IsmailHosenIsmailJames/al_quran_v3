import "package:al_quran_v3/src/features/tajweed_guide/data/datasources/tajweed_guide_local_data_source.dart";
import "package:al_quran_v3/src/features/tajweed_guide/data/repositories/tajweed_guide_repository_impl.dart";
import "package:al_quran_v3/src/features/tajweed_guide/domain/usecases/get_tajweed_rules_usecase.dart";
import "package:al_quran_v3/src/features/tajweed_guide/presentation/widgets/tajweed_tagged_text.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_rules.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("TajweedGuide Feature Tests", () {
    test("GetTajweedRulesUseCase returns all 19 rules", () {
      final dataSource = TajweedGuideLocalDataSourceImpl();
      final repository = TajweedGuideRepositoryImpl(localDataSource: dataSource);
      final useCase = GetTajweedRulesUseCase(repository);

      final rules = useCase();
      expect(rules.length, equals(19));
      expect(rules.first.name, equals("Ghunnah"));
      expect(rules.first.examples.isNotEmpty, isTrue);
    });

    testWidgets("TajweedTaggedText renders tagged letters with custom colors", (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TajweedTaggedText(
              taggedText: "إِ<rule class=\"ghunnah\">نَّ</rule>",
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final RichText richText = tester.widget(richTextFinder);
      final TextSpan rootSpan = richText.text as TextSpan;
      final TextSpan contentSpan = rootSpan.children![0] as TextSpan;

      expect(contentSpan.children, isNotNull);
      expect(contentSpan.children!.length, equals(2));

      final TextSpan firstSpan = contentSpan.children![0] as TextSpan;
      final TextSpan secondSpan = contentSpan.children![1] as TextSpan;

      expect(firstSpan.text, equals("إِ"));
      expect(secondSpan.text, equals("نَّ"));
      expect(secondSpan.style?.color, equals(GhunnahRule.lightColor));
    });
  });
}
