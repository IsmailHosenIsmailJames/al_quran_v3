import "package:al_quran_v3/src/features/daily_plan/domain/entities/streak_entity.dart";

class StreakModel extends StreakEntity {
  const StreakModel({
    required super.currentStreak,
    required super.bestStreak,
    super.lastActiveDate,
    required super.activeDates,
    super.graceDaysRemaining,
    super.todayAyahsRead,
    super.todayPagesRead,
  });

  factory StreakModel.fromMap(Map<String, dynamic> map) {
    return StreakModel(
      currentStreak: (map["currentStreak"] as num?)?.toInt() ?? 0,
      bestStreak: (map["bestStreak"] as num?)?.toInt() ?? 0,
      lastActiveDate: map["lastActiveDate"] as String?,
      activeDates: (map["activeDates"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      graceDaysRemaining: (map["graceDaysRemaining"] as num?)?.toInt() ?? 2,
      todayAyahsRead: (map["todayAyahsRead"] as num?)?.toInt() ?? 0,
      todayPagesRead: (map["todayPagesRead"] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "currentStreak": currentStreak,
      "bestStreak": bestStreak,
      "lastActiveDate": lastActiveDate,
      "activeDates": activeDates,
      "graceDaysRemaining": graceDaysRemaining,
      "todayAyahsRead": todayAyahsRead,
      "todayPagesRead": todayPagesRead,
    };
  }

  factory StreakModel.initial() {
    return const StreakModel(
      currentStreak: 0,
      bestStreak: 0,
      lastActiveDate: null,
      activeDates: [],
      graceDaysRemaining: 2,
      todayAyahsRead: 0,
      todayPagesRead: 0,
    );
  }
}
