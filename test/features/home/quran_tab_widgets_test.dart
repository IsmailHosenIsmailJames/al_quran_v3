import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/quran_tab/quran_index_badge.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
  });

  group("Quran Tab Widgets Tests", () {
    testWidgets("QuranIndexBadge renders properly", (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => LanguageCubit(usedAppLanguageMap.first)),
          ],
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: QuranIndexBadge(
              index: 114,
              size: 44,
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(QuranIndexBadge), findsOneWidget);
    });

    testWidgets("QuranIndexBadge adapts with custom colors", (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => LanguageCubit(usedAppLanguageMap.first)),
          ],
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: QuranIndexBadge(
              index: 1,
              size: 36,
              color: Colors.teal,
              textColor: Colors.black,
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(QuranIndexBadge), findsOneWidget);
    });
  });
}
