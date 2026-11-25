import "dart:io";

import "package:al_quran_v3/src/core/audio/audio_session_coordinator.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/helpers/audio_functions.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_tafsir_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:al_quran_v3/src/features/setup/presentation/screens/setup_screen.dart";
import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:path/path.dart";
import "package:shared_preferences/shared_preferences.dart";

Future<void> resetTheApp(BuildContext context) async {
  // 1. Stop and release any active audio playback & timers
  try {
    await AudioPlayerManager.stopPlayback(hideUi: true);
    if (getIt.isRegistered<AudioSessionCoordinator>()) {
      await getIt<AudioSessionCoordinator>().releaseCurrentOwner();
    }
    if (getIt.isRegistered<AudioSleepTimerCubit>()) {
      getIt<AudioSleepTimerCubit>().cancel();
    }
    if (getIt.isRegistered<AudioLoopCubit>()) {
      await getIt<AudioLoopCubit>().clearRange();
    }
  } catch (_) {}

  // 2. Delete cached/downloaded audio directories
  try {
    if (applicationDataPath != null) {
      final recitationsDir = Directory(join(applicationDataPath!, "recitations"));
      if (await recitationsDir.exists()) {
        await recitationsDir.delete(recursive: true);
      }
    }
    final cacheDir = await getJustAudioCacheDirectory();
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
  } catch (_) {}

  // 3. Clear preferences and Hive DB
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  await Hive.deleteFromDisk();
  await Hive.openBox("user");
  await QuranTranslationFunction.init();
  await QuranTafsirFunction.init();
  await SegmentedResourcesManager.init();
  if (getIt.isRegistered<ReciterCubit>()) {
    await getIt<ReciterCubit>().reset();
  }

  if (!context.mounted) return;
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SetupScreen()),
    (route) => false,
  );
}
