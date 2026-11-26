import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("StreakEntity Tests", () {
    test("initial streak entity has 0 streak and is not active today", () {
      const streak = StreakEntity(
        currentStreak: 0,
        bestStreak: 0,
        activeDates: [],
      );

      expect(streak.currentStreak, 0);
      expect(streak.bestStreak, 0);
      expect(streak.isActiveToday, isFalse);
    });

    test("isActiveToday is true when lastActiveDate matches today", () {
      final now = DateTime.now();
      final todayStr =
          "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      final streak = StreakEntity(
        currentStreak: 5,
        bestStreak: 10,
        lastActiveDate: todayStr,
        activeDates: [todayStr],
      );

      expect(streak.isActiveToday, isTrue);
      expect(streak.currentStreak, 5);
    });

    test("isActiveToday is false when lastActiveDate is yesterday", () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayStr =
          "${yesterday.year.toString().padLeft(4, '0')}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

      final streak = StreakEntity(
        currentStreak: 5,
        bestStreak: 10,
        lastActiveDate: yesterdayStr,
        activeDates: [yesterdayStr],
      );

      expect(streak.isActiveToday, isFalse);
      expect(streak.currentStreak, 5);
    });
  });

  group("DailyPlanEntity Tests", () {
    test("initial plan has 0 completed prayers and is not all completed", () {
      const plan = DailyPlanEntity(prayersCompleted: {});

      expect(plan.completedPrayersCount, 0);
      expect(plan.allPrayersCompleted, isFalse);
      expect(plan.isSunnahSurahCompleted, isFalse);
    });

    test("allPrayersCompleted is true when all 5 prayers are checked", () {
      const plan = DailyPlanEntity(
        prayersCompleted: {
          "fajr": true,
          "dhuhr": true,
          "asr": true,
          "maghrib": true,
          "isha": true,
        },
      );

      expect(plan.completedPrayersCount, 5);
      expect(plan.allPrayersCompleted, isTrue);
    });
  });
}
