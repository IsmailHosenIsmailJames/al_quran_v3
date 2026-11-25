import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/audio_session_coordinator.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/data/resources/recitations.dart";
import "package:al_quran_v3/src/features/audio/domain/utils/segment_highlight_helper.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/audio_controller_ui.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/words/show_popup_of_word.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory hiveDir;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    hiveDir = await Directory.systemTemp.createTemp("audio_fixes_test_");
    Hive.init(hiveDir.path);
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }

    QuranScriptFunction.currentScript = QuranScriptType.uthmani;
    QuranScriptFunction.quranScriptMap = {
      "1": {
        "1": ["بِسْمِ", "اللَّهِ", "الرَّحْمَٰنِ", "الرَّحِيمِ", "١"],
      },
      "2": {
        "255": ["اللَّهُ", "لَا", "إِلَٰهَ", "إِلَّا", "هُوَ", "٢٥٥"],
      },
    };
  });

  tearDownAll(() async {
    await Hive.close();
    if (await hiveDir.exists()) {
      await hiveDir.delete(recursive: true);
    }
  });

  group("AudioSessionCoordinator", () {
    test("enforces single active owner and releases prior owner on acquire", () async {
      final coordinator = AudioSessionCoordinator();
      final events = <String>[];

      await coordinator.acquire(
        "quran",
        onRelease: () async => events.add("released_quran"),
      );
      expect(coordinator.activeOwnerId, equals("quran"));

      await coordinator.acquire(
        "prayer_alarm",
        onRelease: () async => events.add("released_prayer_alarm"),
      );
      expect(events, equals(["released_quran"]));
      expect(coordinator.activeOwnerId, equals("prayer_alarm"));

      await coordinator.releaseCurrentOwner();
      expect(events, equals(["released_quran", "released_prayer_alarm"]));
      expect(coordinator.activeOwnerId, isNull);
    });
  });

  group("Recitations metadata & URL normalization", () {
    test("all reciters have style and generate valid non-double-slash MP3 URLs", () {
      expect(availableRecitations, isNotEmpty);
      for (final reciter in availableRecitations) {
        expect(
          reciter.style?.trim().isNotEmpty ?? false,
          isTrue,
          reason: "Reciter ${reciter.name} is missing style",
        );
        final url = AudioPlayerManager.getUrlOfAudioFromAyahKey("1:1", reciter);
        expect(
          url.contains("//001001.mp3"),
          isFalse,
          reason: "Reciter ${reciter.name} produces double-slash URL: $url",
        );
        expect(url.endsWith("/001001.mp3"), isTrue);
      }
    });
  });

  group("ReciterCubit alignment & segment safety", () {
    test("switching to non-segmented reciter clears active segments cleanly", () async {
      final nonSegmented = availableRecitations.firstWhere(
        (r) => !r.hasWordSegments,
      );
      final cubit = ReciterCubit();

      final result = await cubit.changeReciter(nonSegmented);
      expect(result, isTrue);
      expect(cubit.state.normalizedLink, equals(nonSegmented.normalizedLink));
      expect(cubit.state.hasWordSegments, isFalse);
      expect(cubit.getAyahSegments("1:1"), isNull);
      expect(SegmentedResourcesManager.getSelectedDataBoxName(), isNull);

      await cubit.close();
    });
  });

  group("findActiveWordKeyForSegments", () {
    test("matches inclusive start boundary, skips malformed tuples, and returns null outside range", () {
      final segments = <List>[
        [1, 0, 500],
        [2], // malformed
        [3, 500, 1200],
      ];

      expect(
        findActiveWordKeyForSegments(
          currentAyahKey: "1:1",
          segments: segments,
          position: Duration.zero,
        ),
        equals("1:1:1"),
      );
      expect(
        findActiveWordKeyForSegments(
          currentAyahKey: "1:1",
          segments: segments,
          position: const Duration(milliseconds: 500),
        ),
        equals("1:1:3"),
      );
      expect(
        findActiveWordKeyForSegments(
          currentAyahKey: "1:1",
          segments: segments,
          position: const Duration(milliseconds: 1200),
        ),
        isNull,
      );
      expect(
        findActiveWordKeyForSegments(
          currentAyahKey: "1:1",
          segments: null,
          position: const Duration(milliseconds: 100),
        ),
        isNull,
      );
    });
  });

  group("QuranScriptFunction.getAyahKeyFromWordId", () {
    test("guards out-of-range wordIds and allows word numbers ending in zero (e.g. 10)", () {
      // Invalid surah
      expect(
        QuranScriptFunction.getAyahKeyFromWordId(surah: 0, wordId: 1, page: 1),
        isNull,
      );
      // wordId below surah 2 start (36) previously caused "2:0" null-check crash
      expect(
        QuranScriptFunction.getAyahKeyFromWordId(surah: 2, wordId: 5, page: 2),
        isNull,
      );
      // First word of Surah 1 (start 0 -> word 1)
      expect(
        QuranScriptFunction.getAyahKeyFromWordId(surah: 1, wordId: 1, page: 1),
        equals("1:1:1"),
      );
      // 10th word in 2:2 ("2:2": 38, "2:3": 46 -> try 2:5 start 68, 2:6 start 77 -> word 10 in 2:14 where start=178, next=195)
      expect(
        QuranScriptFunction.getAyahKeyFromWordId(
          surah: 2,
          wordId: 188,
          page: 3,
        ),
        equals("2:14:10"),
      );
    });
  });

  group("AudioSleepTimerCubit", () {
    test("transitions through timed, end-of-ayah, and expiration callbacks", () async {
      final cubit = AudioSleepTimerCubit();
      bool expired = false;
      cubit.attachExpirationHandler(() async {
        expired = true;
      });

      cubit.setStopAfterCurrentAyah();
      expect(cubit.state.isActive, isTrue);
      expect(cubit.state.mode, equals(SleepTimerMode.endOfAyah));

      await cubit.triggerExpiration();
      expect(expired, isTrue);
      expect(cubit.state.isActive, isFalse);

      cubit.startTimed(const Duration(minutes: 15));
      expect(cubit.state.mode, equals(SleepTimerMode.timed));
      expect(cubit.state.remainingSeconds, equals(900));

      cubit.cancel();
      expect(cubit.state.isActive, isFalse);
      await cubit.close();
    });
  });

  group("Audio UI widget safety", () {
    Widget wrapWidget(Widget child, {AyahKeyCubit? ayahKeyCubit, AudioUiCubit? audioUiCubit}) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LanguageCubit(null)),
          BlocProvider(create: (_) => QuranViewCubit()),
          BlocProvider(create: (_) => ReciterCubit()),
          BlocProvider(create: (_) => AudioLoopCubit()),
          BlocProvider(create: (_) => AudioSleepTimerCubit()),
          BlocProvider(create: (_) => PlayerStateCubit()),
          BlocProvider(create: (_) => PlayerPositionCubit()),
          BlocProvider(create: (_) => WordPlayingStateCubit()),
          if (ayahKeyCubit != null)
            BlocProvider.value(value: ayahKeyCubit)
          else
            BlocProvider(create: (_) => AyahKeyCubit()),
          if (audioUiCubit != null)
            BlocProvider.value(value: audioUiCubit)
          else
            BlocProvider(create: (_) => AudioUiCubit()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale("en"),
          home: Scaffold(body: child),
        ),
      );
    }

    testWidgets("ShowPopupOfWord safely handles final word index & short wordByWord list", (tester) async {
      const surah = SurahInfoModel(
        id: 1,
        revelationPlace: "makkah",
        revelationOrder: 5,
        pagesRange: "1-1",
        versesCount: 7,
      );

      await tester.pumpWidget(
        wrapWidget(
          ShowPopupOfWord(
            wordKeys: const ["1:1:1", "1:1:2", "1:1:3", "1:1:4"],
            surahInfoModel: surah,
            initWordIndex: 3, // last word
            wordByWord: const ["In", "Allah"], // shorter than wordKeys
          ),
        ),
      );
      await tester.pump();

      expect(find.textContaining("1:1:4"), findsOneWidget);
    });

    testWidgets("AudioControllerUi renders cleanly for single-ayah playlist", (tester) async {
      final ayahKeyCubit = AyahKeyCubit();
      await tester.runAsync(() async {
        ayahKeyCubit.changeData(
          AyahKeyManagement(
            start: "2:255",
            end: "2:255",
            current: "2:255",
            ayahList: const ["2:255"],
          ),
        );
        await Hive.box("user").flush();
      });
      final audioUiCubit = AudioUiCubit()
        ..showUI(true)
        ..expand(true)
        ..changeIsInsideQuran(true);

      await tester.pumpWidget(
        wrapWidget(
          const AudioControllerUi(),
          ayahKeyCubit: ayahKeyCubit,
          audioUiCubit: audioUiCubit,
        ),
      );
      await tester.pump();

      expect(find.byIcon(Icons.skip_previous_rounded), findsOneWidget);
      expect(find.byIcon(Icons.skip_next_rounded), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pump();
      await ayahKeyCubit.close();
      await audioUiCubit.close();
    });
  });
}
