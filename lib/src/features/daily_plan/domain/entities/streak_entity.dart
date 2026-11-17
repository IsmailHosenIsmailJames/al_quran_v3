class StreakEntity {
  final int currentStreak;
  final int bestStreak;
  final String? lastActiveDate; // "YYYY-MM-DD"
  final List<String> activeDates;
  final int graceDaysRemaining;
  final int todayAyahsRead;
  final int todayPagesRead;

  const StreakEntity({
    required this.currentStreak,
    required this.bestStreak,
    this.lastActiveDate,
    required this.activeDates,
    this.graceDaysRemaining = 2,
    this.todayAyahsRead = 0,
    this.todayPagesRead = 0,
  });

  bool get isActiveToday {
    if (lastActiveDate == null) return false;
    final now = DateTime.now();
    final todayStr =
        "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    return lastActiveDate == todayStr;
  }

  StreakEntity copyWith({
    int? currentStreak,
    int? bestStreak,
    String? lastActiveDate,
    List<String>? activeDates,
    int? graceDaysRemaining,
    int? todayAyahsRead,
    int? todayPagesRead,
  }) {
    return StreakEntity(
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      activeDates: activeDates ?? this.activeDates,
      graceDaysRemaining: graceDaysRemaining ?? this.graceDaysRemaining,
      todayAyahsRead: todayAyahsRead ?? this.todayAyahsRead,
      todayPagesRead: todayPagesRead ?? this.todayPagesRead,
    );
  }
}
