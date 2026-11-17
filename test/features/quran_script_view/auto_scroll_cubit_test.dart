import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/auto_scroll_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/auto_scroll_state.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("AutoScrollState & Adaptive Pacing Engine", () {
    test("initial state has sensible defaults", () {
      const state = AutoScrollState();
      expect(state.isActive, isFalse);
      expect(state.isPlaying, isFalse);
      expect(state.isPausedByTouch, isFalse);
      expect(state.speed, equals(1.0));
      expect(state.currentScrollIndex, equals(0));
      expect(state.currentAyahKey, isNull);
    });

    test("getAyahDuration respects floor minimum for short ayahs", () {
      const state = AutoScrollState(speed: 1.0);
      // Surah 2:1 is 2 words -> 2 * 650 = 1300ms, clamped to 2200ms minimum floor
      final duration = state.getAyahDuration("2:1");
      expect(duration.inMilliseconds, equals(2200));
    });

    test("getAyahDuration calculates dynamic duration for long Ayah 2:282", () {
      const state1x = AutoScrollState(speed: 1.0);
      // Surah 2:282 has 129 words -> 129 * 650 = 83,850 ms (~83.8 seconds)
      final duration1x = state1x.getAyahDuration("2:282");
      expect(duration1x.inMilliseconds, equals(83850));

      // At 2.0x speed, duration should be exactly halved -> ~41,925 ms
      const state2x = AutoScrollState(speed: 2.0);
      final duration2x = state2x.getAyahDuration("2:282");
      expect(duration2x.inMilliseconds, equals(41925));

      // At 0.5x speed, duration should be doubled -> 167,700 ms
      const stateHalfX = AutoScrollState(speed: 0.5);
      final durationHalfX = stateHalfX.getAyahDuration("2:282");
      expect(durationHalfX.inMilliseconds, equals(167700));
    });

    test("getPageDuration calculates composite duration for page ayahs", () {
      const state = AutoScrollState(speed: 1.0);
      // Surah Al-Fatihah (1:1 to 1:7)
      final pageAyahs = ["1:1", "1:2", "1:3", "1:4", "1:5", "1:6", "1:7"];
      final duration = state.getPageDuration(pageAyahs);
      expect(duration.inMilliseconds, greaterThan(8000));
    });

    test("copyWith updates fields correctly", () {
      const state = AutoScrollState();
      final updated = state.copyWith(
        isActive: true,
        isPlaying: true,
        speed: 1.5,
        currentAyahKey: "2:255",
        currentScrollIndex: 254,
      );
      expect(updated.isActive, isTrue);
      expect(updated.isPlaying, isTrue);
      expect(updated.speed, equals(1.5));
      expect(updated.currentAyahKey, equals("2:255"));
      expect(updated.currentScrollIndex, equals(254));
    });
  });

  group("AutoScrollCubit Lifecycle & Controls", () {
    late AutoScrollCubit cubit;

    setUp(() {
      cubit = AutoScrollCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test("activate enables auto-scroll and starts playing", () {
      cubit.activate(initialAyahKey: "2:1", initialIndex: 0);
      expect(cubit.state.isActive, isTrue);
      expect(cubit.state.isPlaying, isTrue);
      expect(cubit.state.isPausedByTouch, isFalse);
      expect(cubit.state.currentAyahKey, equals("2:1"));
      expect(cubit.state.currentScrollIndex, equals(0));
    });

    test("pause, play, and togglePlayPause behave predictably", () {
      cubit.activate(initialAyahKey: "2:1");
      expect(cubit.state.isPlaying, isTrue);

      cubit.pause();
      expect(cubit.state.isPlaying, isFalse);

      cubit.play();
      expect(cubit.state.isPlaying, isTrue);

      cubit.togglePlayPause();
      expect(cubit.state.isPlaying, isFalse);

      cubit.togglePlayPause();
      expect(cubit.state.isPlaying, isTrue);
    });

    test("touch interaction pauses and resumes cleanly", () {
      cubit.activate(initialAyahKey: "2:10");
      expect(cubit.state.isPlaying, isTrue);

      cubit.pauseByTouch();
      expect(cubit.state.isPlaying, isFalse);
      expect(cubit.state.isPausedByTouch, isTrue);

      cubit.resumeFromTouch();
      expect(cubit.state.isPlaying, isTrue);
      expect(cubit.state.isPausedByTouch, isFalse);
    });

    test("speed steppers increase and decrease within valid bounds", () {
      cubit.setSpeed(1.0);
      expect(cubit.state.speed, equals(1.0));

      cubit.increaseSpeed();
      expect(cubit.state.speed, equals(1.25));

      cubit.increaseSpeed();
      expect(cubit.state.speed, equals(1.5));

      cubit.decreaseSpeed();
      expect(cubit.state.speed, equals(1.25));

      // Test lower boundary
      cubit.setSpeed(0.5);
      cubit.decreaseSpeed();
      expect(cubit.state.speed, equals(0.5)); // Does not drop below 0.5

      // Test upper boundary
      cubit.setSpeed(3.0);
      cubit.increaseSpeed();
      expect(cubit.state.speed, equals(3.0)); // Does not exceed 3.0
    });

    test("deactivate completely resets active and playing status", () {
      cubit.activate(initialAyahKey: "2:50", initialIndex: 49);
      cubit.deactivate();

      expect(cubit.state.isActive, isFalse);
      expect(cubit.state.isPlaying, isFalse);
      expect(cubit.state.isPausedByTouch, isFalse);
    });
  });
}
