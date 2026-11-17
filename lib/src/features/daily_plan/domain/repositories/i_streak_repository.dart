import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";

abstract class IStreakRepository {
  Future<StreakEntity> getStreak();
  Future<StreakEntity> recordDailyReading({
    required int surahNumber,
    required int ayahNumber,
    int? pageNumber,
  });
  Future<StreakEntity> useGraceDay();
  Future<void> saveStreak(StreakEntity streak);

  DailyPlanEntity getDailyPlan();
  Future<DailyPlanEntity> togglePrayer(String prayerKey);
  Future<DailyPlanEntity> toggleSunnahSurah();
  Future<DailyPlanEntity> setPlanCollapsed(bool collapsed);
}
