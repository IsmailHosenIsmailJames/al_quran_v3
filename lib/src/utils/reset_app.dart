import "package:al_quran_v3/src/screen/collections/collection_page.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/segmented_resources_manager.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> resetTheApp(BuildContext context) async {
  context.read<ResourcesProcceessCubit>().changeTafsirBook(null);
  context.read<ResourcesProcceessCubit>().changeTranslationBook(null);

  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  await Hive.deleteFromDisk();
  await Hive.openBox("user");

  await QuranTranslationFunction.init();
  await QuranTafsirFunction.init();
  await SegmentedResourcesManager.init();
  WordByWordFunction.init();
  Hive.openBox(CollectionType.notes.name);
  Hive.openBox(CollectionType.pinned.name);
  Hive.openBox(CollectionType.bookmark.name);
  SegmentedResourcesManager.init();

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const AppSetupPage()),
    (route) {
      return false;
    },
  );
}
