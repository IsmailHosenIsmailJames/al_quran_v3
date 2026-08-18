import "package:al_quran_v3/src/features/setup/presentation/screens/setup_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_tafsir_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> resetTheApp(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  await Hive.deleteFromDisk();
  await Hive.openBox("user");
  await QuranTranslationFunction.init();
  await QuranTafsirFunction.init();
  await SegmentedResourcesManager.init();

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SetupScreen()),
    (route) {
      return false;
    },
  );
}
