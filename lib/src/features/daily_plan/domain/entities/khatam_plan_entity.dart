import "dart:math";

class KhatamPlanEntity {
  final String id;
  final String title;
  final int totalPages;
  final int startPage;
  final int completedPages;
  final DateTime startDate;
  final DateTime targetDate;
  final bool isActive;

  const KhatamPlanEntity({
    required this.id,
    required this.title,
    this.totalPages = 604,
    this.startPage = 1,
    this.completedPages = 0,
    required this.startDate,
    required this.targetDate,
    this.isActive = true,
  });

  /// Total number of pages left to finish the Khatam.
  int get pagesRemaining => (totalPages - completedPages).clamp(0, totalPages);

  /// Total days allocated for the plan.
  int get totalDays => max(1, targetDate.difference(startDate).inDays + 1);

  /// Days elapsed since the start of the plan.
  int get daysPassed {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    return today.difference(start).inDays.clamp(0, totalDays);
  }

  /// Days remaining until the target date.
  int get daysRemaining {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final diff = target.difference(today).inDays + 1;
    return max(1, diff);
  }

  /// Progress fraction from 0.0 to 1.0.
  double get progressFraction =>
      totalPages > 0 ? (completedPages / totalPages).clamp(0.0, 1.0) : 0.0;

  /// Progress in percentage (0 - 100).
  double get progressPercent => progressFraction * 100;

  /// Dynamic daily quota: recalculates dynamically based on remaining pages and days.
  double get dynamicDailyPagesQuota {
    if (pagesRemaining <= 0) return 0.0;
    return pagesRemaining / daysRemaining;
  }

  /// Rounded daily pages quota (ceil so the user finishes on or before the target date).
  int get roundedDailyPagesQuota => dynamicDailyPagesQuota.ceil();

  /// Whether the entire Khatam has been completed.
  bool get isCompleted => completedPages >= totalPages;

  /// Projected completion date based on actual user pace.
  DateTime? get projectedCompletionDate {
    if (completedPages <= 0 || daysPassed <= 0) return null;
    final pace = completedPages / daysPassed; // pages per day
    if (pace <= 0) return null;
    final remainingDaysAtPace = (pagesRemaining / pace).ceil();
    return DateTime.now().add(Duration(days: remainingDaysAtPace));
  }

  KhatamPlanEntity copyWith({
    String? id,
    String? title,
    int? totalPages,
    int? startPage,
    int? completedPages,
    DateTime? startDate,
    DateTime? targetDate,
    bool? isActive,
  }) {
    return KhatamPlanEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      totalPages: totalPages ?? this.totalPages,
      startPage: startPage ?? this.startPage,
      completedPages: completedPages ?? this.completedPages,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Factory helper for a standard 30-day Khatam (e.g. Ramadan).
  factory KhatamPlanEntity.thirtyDays({
    String title = "30-Day Khatam",
    int totalPages = 604,
  }) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return KhatamPlanEntity(
      id: "khatam_30_${start.millisecondsSinceEpoch}",
      title: title,
      totalPages: totalPages,
      startDate: start,
      targetDate: start.add(const Duration(days: 30)),
    );
  }

  /// Factory helper for a 60-day Khatam (2 months).
  factory KhatamPlanEntity.sixtyDays({
    String title = "60-Day Khatam",
    int totalPages = 604,
  }) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return KhatamPlanEntity(
      id: "khatam_60_${start.millisecondsSinceEpoch}",
      title: title,
      totalPages: totalPages,
      startDate: start,
      targetDate: start.add(const Duration(days: 60)),
    );
  }

  /// Factory helper for a custom duration Khatam.
  factory KhatamPlanEntity.custom({
    required String title,
    required int days,
    int totalPages = 604,
    int startPage = 1,
    int initialCompletedPages = 0,
  }) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return KhatamPlanEntity(
      id: "khatam_custom_${start.millisecondsSinceEpoch}",
      title: title,
      totalPages: totalPages,
      startPage: startPage,
      completedPages: initialCompletedPages,
      startDate: start,
      targetDate: start.add(Duration(days: max(1, days))),
    );
  }
}
