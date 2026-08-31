import "package:al_quran_v3/src/features/audio/presentation/cubit/sleep_timer_cubit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("SleepTimerCubit Unit Tests", () {
    late SleepTimerCubit cubit;

    setUp(() {
      cubit = SleepTimerCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test("Initial state is inactive", () {
      expect(cubit.state.isActive, isFalse);
      expect(cubit.state.remainingDuration, isNull);
      expect(cubit.state.selectedMinutes, isNull);
      expect(cubit.state.isEndOfSurah, isFalse);
    });

    test("Start countdown timer updates state", () {
      cubit.setTimerMinutes(15);

      expect(cubit.state.isActive, isTrue);
      expect(cubit.state.selectedMinutes, equals(15));
      expect(cubit.state.isEndOfSurah, isFalse);
      expect(cubit.state.remainingDuration, equals(const Duration(minutes: 15)));
    });

    test("Start end of surah timer updates state", () {
      cubit.setEndOfSurah();

      expect(cubit.state.isActive, isTrue);
      expect(cubit.state.isEndOfSurah, isTrue);
      expect(cubit.state.remainingDuration, isNull);
    });

    test("Cancel timer resets state", () {
      cubit.setTimerMinutes(30);
      expect(cubit.state.isActive, isTrue);

      cubit.cancelTimer();
      expect(cubit.state.isActive, isFalse);
      expect(cubit.state.remainingDuration, isNull);
    });
  });
}
