import "dart:io";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/quran_resources/data/curated_ayahs.dart";
import "package:al_quran_v3/src/features/quran_resources/data/services/ayah_widget_service.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp("hive_ayah_test_");
    Hive.init(tempDir.path);
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel("home_widget"), (call) async => true);
  });

  tearDown(() async {
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group("AyahWidgetService Unit Tests", () {
    test("curatedAyahsList has valid Surahs and Ayahs", () {
      expect(curatedAyahsList.isNotEmpty, isTrue);

      for (final item in curatedAyahsList) {
        expect(item.surah >= 1 && item.surah <= 114, isTrue);
        final maxVerses = metaDataSurah["${item.surah}"]?["vc"] ?? 0;
        expect(item.ayah >= 1 && item.ayah <= maxVerses, isTrue,
            reason: "Surah ${item.surah} Ayah ${item.ayah} exceeds verse count $maxVerses");
      }
    });

    test("AyahWidgetService executes updateWidgets cleanly", () async {
      await AyahWidgetService.updateWidgets(
        currentTime: DateTime(2026, 8, 21, 12, 0),
        customSurah: 2,
        customAyah: 255,
      );
    });
  });
}
