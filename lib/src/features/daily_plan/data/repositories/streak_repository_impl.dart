import "package:al_quran_v3/src/features/daily_plan/data/datasources/streak_local_datasource.dart";
import "package:al_quran_v3/src/features/daily_plan/data/models/streak_model.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/repositories/i_streak_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: IStreakRepository)
class StreakRepositoryImpl implements IStreakRepository {
  final StreakLocalDataSource _localDataSource;

  StreakRepositoryImpl(this._localDataSource);

  @override
  Future<StreakEntity> getStreak() {
    return _localDataSource.getStreak();
  }

  @override
  Future<StreakEntity> recordDailyReading({
    required int surahNumber,
    required int ayahNumber,
    int? pageNumber,
  }) {
    return _localDataSource.recordDailyReading(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      pageNumber: pageNumber,
    );
  }

  @override
  Future<StreakEntity> useGraceDay() {
    return _localDataSource.useGraceDay();
  }

  @override
  Future<void> saveStreak(StreakEntity streak) {
    final model = StreakModel(
      currentStreak: streak.currentStreak,
      bestStreak: streak.bestStreak,
      lastActiveDate: streak.lastActiveDate,
      activeDates: streak.activeDates,
      graceDaysRemaining: streak.graceDaysRemaining,
      todayAyahsRead: streak.todayAyahsRead,
      todayPagesRead: streak.todayPagesRead,
    );
    return _localDataSource.saveStreak(model);
  }

  @override
  DailyPlanEntity getDailyPlan() {
    return DailyPlanEntity(
      prayersCompleted: _localDataSource.getPrayersToday(),
      isSunnahSurahCompleted: _localDataSource.getSunnahSurahCompletedToday(),
      isCollapsed: _localDataSource.getIsPlanCollapsed(),
    );
  }

  @override
  Future<DailyPlanEntity> togglePrayer(String prayerKey) async {
    final currentPrayers = _localDataSource.getPrayersToday();
    final currentVal = currentPrayers[prayerKey] == true;
    await _localDataSource.setPrayerCompleted(prayerKey, !currentVal);
    return getDailyPlan();
  }

  @override
  Future<DailyPlanEntity> toggleSunnahSurah() async {
    final current = _localDataSource.getSunnahSurahCompletedToday();
    await _localDataSource.setSunnahSurahCompleted(!current);
    return getDailyPlan();
  }

  @override
  Future<DailyPlanEntity> setPlanCollapsed(bool collapsed) async {
    await _localDataSource.setIsPlanCollapsed(collapsed);
    return getDailyPlan();
  }
}
