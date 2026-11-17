import "package:al_quran_v3/src/features/daily_plan/data/models/khatam_plan_model.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/khatam_plan_entity.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("KhatamPlanEntity Tests", () {
    test("30-day plan sets 604 pages and ~20 pages per day dynamic quota", () {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final target = start.add(const Duration(days: 30));

      final plan = KhatamPlanEntity(
        id: "test_30",
        title: "30-Day Ramadan Khatam",
        totalPages: 604,
        completedPages: 0,
        startDate: start,
        targetDate: target,
      );

      expect(plan.totalPages, 604);
      expect(plan.completedPages, 0);
      expect(plan.pagesRemaining, 604);
      expect(plan.progressPercent, 0.0);
      expect(plan.isCompleted, isFalse);
      expect(plan.roundedDailyPagesQuota, 20); // 604 / 31 = 19.48 -> ceil = 20
    });

    test("dynamic quota recalculates downwards when user reads ahead", () {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final target = start.add(const Duration(days: 30));

      // User reads 150 pages ahead of schedule
      final plan = KhatamPlanEntity(
        id: "test_ahead",
        title: "Active Plan",
        totalPages: 604,
        completedPages: 150,
        startDate: start,
        targetDate: target,
      );

      expect(plan.pagesRemaining, 454);
      expect(plan.progressPercent, closeTo(24.83, 0.1));
      expect(plan.dynamicDailyPagesQuota, lessThan(16.0));
      expect(plan.roundedDailyPagesQuota, 15); // 454 / 31 = 14.65 -> ceil = 15
    });

    test("dynamic quota recalculates gently when behind schedule", () {
      final start = DateTime.now().subtract(const Duration(days: 10));
      final target = DateTime.now().add(const Duration(days: 10));

      // 10 days remaining, only 104 pages read (500 pages left)
      final plan = KhatamPlanEntity(
        id: "test_behind",
        title: "Behind Schedule Plan",
        totalPages: 604,
        completedPages: 104,
        startDate: start,
        targetDate: target,
      );

      expect(plan.pagesRemaining, 500);
      expect(plan.daysRemaining, 11);
      expect(plan.roundedDailyPagesQuota, 46); // 500 / 11 = 45.45 -> ceil = 46
    });

    test("isCompleted is true when completedPages equals or exceeds totalPages", () {
      final now = DateTime.now();
      final plan = KhatamPlanEntity(
        id: "test_done",
        title: "Completed Khatam",
        totalPages: 604,
        completedPages: 604,
        startDate: now.subtract(const Duration(days: 29)),
        targetDate: now,
      );

      expect(plan.isCompleted, isTrue);
      expect(plan.pagesRemaining, 0);
      expect(plan.progressFraction, 1.0);
      expect(plan.progressPercent, 100.0);
      expect(plan.dynamicDailyPagesQuota, 0.0);
      expect(plan.roundedDailyPagesQuota, 0);
    });

    test("KhatamPlanModel serialization and deserialization roundtrip", () {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day);
      final target = start.add(const Duration(days: 60));

      final model = KhatamPlanModel(
        id: "model_test",
        title: "60-Day Khatam",
        totalPages: 604,
        completedPages: 42,
        startDate: start,
        targetDate: target,
        isActive: true,
      );

      final map = model.toMap();
      final restored = KhatamPlanModel.fromMap(map);

      expect(restored.id, model.id);
      expect(restored.title, model.title);
      expect(restored.totalPages, 604);
      expect(restored.completedPages, 42);
      expect(restored.isActive, isTrue);
      expect(restored.pagesRemaining, 562);
    });
  });
}
