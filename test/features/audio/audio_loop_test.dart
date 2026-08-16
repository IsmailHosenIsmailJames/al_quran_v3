import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:flutter_test/flutter_test.dart";
import "package:just_audio/just_audio.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("AudioLoopCubit Unit Tests", () {
    late AudioLoopCubit cubit;

    setUp(() {
      cubit = AudioLoopCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test("Initial state is not looping and no range active", () {
      expect(cubit.state.loopMode, equals(LoopMode.off));
      expect(cubit.state.isRangeActive, isFalse);
      expect(cubit.state.isInfinite, isTrue);
      expect(cubit.state.currentRangeCycle, equals(1));
    });

    test("setRange activates range with target repetition count", () async {
      await cubit.setRange(
        startSurah: 36,
        startAyah: 1,
        endSurah: 36,
        endAyah: 15,
        repeatTargetCount: 3,
      );

      expect(cubit.state.isRangeActive, isTrue);
      expect(cubit.state.startSurah, equals(36));
      expect(cubit.state.startAyah, equals(1));
      expect(cubit.state.endSurah, equals(36));
      expect(cubit.state.endAyah, equals(15));
      expect(cubit.state.repeatTargetCount, equals(3));
      expect(cubit.state.isInfinite, isFalse);
      expect(cubit.state.currentRangeCycle, equals(1));
    });

    test("onPlaylistCycleFinished increments cycle and stops when target reached", () async {
      await cubit.setRange(
        startSurah: 36,
        startAyah: 1,
        endSurah: 36,
        endAyah: 15,
        repeatTargetCount: 3,
      );

      // Cycle 1 finished -> advances to cycle 2
      bool shouldContinue = cubit.onPlaylistCycleFinished();
      expect(shouldContinue, isTrue);
      expect(cubit.state.currentRangeCycle, equals(2));

      // Cycle 2 finished -> advances to cycle 3
      shouldContinue = cubit.onPlaylistCycleFinished();
      expect(shouldContinue, isTrue);
      expect(cubit.state.currentRangeCycle, equals(3));

      // Cycle 3 finished -> target reached, stops!
      shouldContinue = cubit.onPlaylistCycleFinished();
      expect(shouldContinue, isFalse);
      expect(cubit.state.isRangeActive, isFalse);
    });

    test("Infinite repeat continues indefinitely", () async {
      await cubit.setRange(
        startSurah: 36,
        startAyah: 1,
        endSurah: 36,
        endAyah: 15,
        repeatTargetCount: -1, // Infinite
      );

      expect(cubit.state.isInfinite, isTrue);

      for (int i = 1; i <= 20; i++) {
        final shouldContinue = cubit.onPlaylistCycleFinished();
        expect(shouldContinue, isTrue);
        expect(cubit.state.currentRangeCycle, equals(i + 1));
      }
      expect(cubit.state.isRangeActive, isTrue);
    });

    test("clearRange resets range state", () async {
      await cubit.setRange(
        startSurah: 36,
        startAyah: 1,
        endSurah: 36,
        endAyah: 15,
        repeatTargetCount: 5,
      );
      expect(cubit.state.isRangeActive, isTrue);

      await cubit.clearRange();
      expect(cubit.state.isRangeActive, isFalse);
      expect(cubit.state.loopMode, equals(LoopMode.off));
      expect(cubit.state.currentRangeCycle, equals(1));
    });
  });
}
