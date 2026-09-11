import "dart:io";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:dartx/dartx.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Set up mock asset bundle for test environment
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler("flutter/assets", (ByteData? message) async {
      final key = String.fromCharCodes(message!.buffer.asUint8List());
      final file = File(key);
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        return ByteData.view(bytes.buffer);
      }
      return null;
    });
  });

  group("QuranScriptFunction Independent Caching Tests", () {
    test("initAllScripts preloads both scripts and retains independent texts", () async {
      await QuranScriptFunction.initAllScripts(initialScript: QuranScriptType.indopak);

      // 1. Fetch 59:2 as IndoPak
      final indopakWords = QuranScriptFunction.getWordListOfAyah(
        QuranScriptType.indopak,
        "59",
        "2",
        circleJojom: false,
      );

      // In IndoPak, ayah has sukun on nun in "an" and shaddah on "yakhruju"
      // Word 13: "ظَنَنْتُمْ", Word 14: "اَنْ", Word 15: "يَّخْرُجُوا"
      final indopakAn = indopakWords[14];
      final indopakYakhruju = indopakWords[15];
      // \u06e1 is Jazm (1761) or \u0652 is Circle sukun (1618)
      expect(
        indopakAn.contains(1761.toChar()) || indopakAn.contains(1618.toChar()),
        isTrue,
        reason: "IndoPak text must have sukun/jazm on nun in 'an'",
      );
      expect(
        indopakYakhruju.contains("َّ"),
        isTrue,
        reason: "IndoPak text must have shaddah on 'yakhruju'",
      );

      // 2. Fetch 59:2 as Uthmani
      final uthmaniWords = QuranScriptFunction.getWordListOfAyah(
        QuranScriptType.uthmani,
        "59",
        "2",
        circleJojom: false,
      );

      final uthmaniAn = uthmaniWords[14];
      final uthmaniYakhruju = uthmaniWords[15];
      // In Uthmani idgham with ghunnah: nun is naked (no sukun) and ya has no shaddah
      expect(
        uthmaniAn.contains(1761.toChar()) || uthmaniAn.contains(1618.toChar()),
        isFalse,
        reason: "Uthmani text in idgham must have no sukun on nun",
      );
      expect(
        uthmaniYakhruju.contains("َّ"),
        isFalse,
        reason: "Uthmani text in idgham must have no shaddah on ya",
      );
    });

    test("Background Uthmani loading does NOT corrupt IndoPak reader text", () async {
      await QuranScriptFunction.initAllScripts(initialScript: QuranScriptType.indopak);

      // Simulate background AyahWidgetService or search loading Uthmani
      await QuranScriptFunction.loadScript(QuranScriptType.uthmani, setCurrent: false);

      // Request IndoPak text again (e.g. user opening Surah 59 Ayah 2)
      final indopakWords = QuranScriptFunction.getWordListOfAyah(
        QuranScriptType.indopak,
        "59",
        "2",
        circleJojom: false,
      );

      final indopakAn = indopakWords[14];
      expect(
        indopakAn.contains(1761.toChar()) || indopakAn.contains(1618.toChar()),
        isTrue,
        reason: "IndoPak must retain sukun even after Uthmani was loaded in background",
      );
    });

    test("Surah 7:2 (litunzira) retains proper sakins in IndoPak vs Uthmani", () async {
      await QuranScriptFunction.initAllScripts();

      // IndoPak 7:2
      final indopakWords = QuranScriptFunction.getWordListOfAyah(
        QuranScriptType.indopak,
        "7",
        "2",
        circleJojom: false,
      );
      // Word 9 in 7:2 is "litunzira"
      final indopakLitunzira = indopakWords[9];
      expect(
        indopakLitunzira.contains(1761.toChar()) || indopakLitunzira.contains(1618.toChar()),
        isTrue,
        reason: "IndoPak must have sukun on nun in litunzira",
      );

      // Uthmani 7:2
      final uthmaniWords = QuranScriptFunction.getWordListOfAyah(
        QuranScriptType.uthmani,
        "7",
        "2",
        circleJojom: false,
      );
      final uthmaniLitunzira = uthmaniWords[9];
      expect(
        uthmaniLitunzira.contains(1761.toChar()) || uthmaniLitunzira.contains(1618.toChar()),
        isFalse,
        reason: "Uthmani ikhfa must have unvoweled nun in litunzira",
      );
    });
  });
}
