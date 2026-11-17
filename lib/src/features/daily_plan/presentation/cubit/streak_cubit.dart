import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/khatam_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/repositories/i_streak_repository.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_state.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_cubit.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class StreakCubit extends Cubit<StreakState> {
  final IStreakRepository _repository;

  StreakCubit(this._repository)
      : super(
          StreakInitial(
            const StreakEntity(
              currentStreak: 0,
              bestStreak: 0,
              activeDates: [],
            ),
            DailyPlanEntity.initial(),
          ),
        );

  Future<void> loadStreak() async {
    final streak = await _repository.getStreak();
    final plan = _repository.getDailyPlan();
    final khatam = _repository.getKhatamPlan();
    emit(StreakLoaded(streak, plan, khatamPlan: khatam));
  }

  Future<void> recordReading({
    required int surahNumber,
    required int ayahNumber,
    int? pageNumber,
  }) async {
    final previousStreak = state.streak.currentStreak;
    final updatedStreak = await _repository.recordDailyReading(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      pageNumber: pageNumber,
    );

    final didIncrement = updatedStreak.currentStreak > previousStreak;
    final updatedPlan = _repository.getDailyPlan();
    final updatedKhatam = _repository.getKhatamPlan();
    emit(
      StreakUpdated(
        updatedStreak,
        updatedPlan,
        khatamPlan: updatedKhatam,
        didIncrementToday: didIncrement,
      ),
    );

    // Silently trigger cloud auto-sync if available
    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }

  Future<void> togglePrayer(String prayerKey) async {
    final updatedPlan = await _repository.togglePrayer(prayerKey);
    emit(StreakLoaded(state.streak, updatedPlan, khatamPlan: state.khatamPlan));

    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }

  Future<void> toggleSunnahSurah() async {
    final updatedPlan = await _repository.toggleSunnahSurah();
    emit(StreakLoaded(state.streak, updatedPlan, khatamPlan: state.khatamPlan));

    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }

  Future<void> togglePlanCollapsed() async {
    final updatedPlan =
        await _repository.setPlanCollapsed(!state.plan.isCollapsed);
    emit(StreakLoaded(state.streak, updatedPlan, khatamPlan: state.khatamPlan));
  }

  Future<void> useGraceDay() async {
    final updated = await _repository.useGraceDay();
    emit(StreakLoaded(updated, state.plan, khatamPlan: state.khatamPlan));
  }

  Future<void> saveKhatamPlan(KhatamPlanEntity plan) async {
    await _repository.saveKhatamPlan(plan);
    emit(StreakLoaded(state.streak, state.plan, khatamPlan: plan));
    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }

  Future<void> updateKhatamPages(int completedPages) async {
    final updated = await _repository.updateKhatamPages(completedPages);
    emit(StreakLoaded(state.streak, state.plan, khatamPlan: updated));
    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }

  Future<void> deleteKhatamPlan() async {
    await _repository.deleteKhatamPlan();
    emit(StreakLoaded(state.streak, state.plan, khatamPlan: null));
    try {
      getIt<SyncCubit>().triggerAutoSync();
    } catch (_) {}
  }
}
