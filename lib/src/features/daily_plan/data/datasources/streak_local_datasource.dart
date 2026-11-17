import "package:al_quran_v3/src/features/daily_plan/data/models/khatam_plan_model.dart";
import "package:al_quran_v3/src/features/daily_plan/data/models/streak_model.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class StreakLocalDataSource {
  static const String _userBoxName = "user";
  static const String _streakKey = "user_daily_streak_data";
  static const String _todayDateKey = "user_daily_streak_today_date";
  static const String _todayAyahsKey = "user_daily_streak_today_ayahs";
  static const String _todayPagesKey = "user_daily_streak_today_pages";
  static const String _khatamPlanKey = "user_khatam_plan_data";

  Box get _box => Hive.box(_userBoxName);

  String _formatDate(DateTime dt) {
    return "${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }

  String get _todayStr => _formatDate(DateTime.now());

  Map<String, bool> getPrayersToday() {
    final raw = _box.get("user_daily_prayers_$_todayStr");
    if (raw != null && raw is Map) {
      final map = <String, bool>{};
      for (final key in DailyPlanEntity.prayerKeys) {
        map[key] = raw[key] == true;
      }
      return map;
    }
    return {
      "fajr": false,
      "dhuhr": false,
      "asr": false,
      "maghrib": false,
      "isha": false,
    };
  }

  Future<void> setPrayerCompleted(String prayerKey, bool completed) async {
    final current = getPrayersToday();
    current[prayerKey] = completed;
    await _box.put("user_daily_prayers_$_todayStr", current);
  }

  bool getSunnahSurahCompletedToday() {
    return _box.get("user_daily_sunnah_surah_$_todayStr", defaultValue: false)
        as bool;
  }

  Future<void> setSunnahSurahCompleted(bool completed) async {
    await _box.put("user_daily_sunnah_surah_$_todayStr", completed);
  }

  bool _isPlanCollapsed = true;

  bool getIsPlanCollapsed() {
    return _isPlanCollapsed;
  }

  Future<void> setIsPlanCollapsed(bool collapsed) async {
    _isPlanCollapsed = collapsed;
    await _box.put("user_daily_plan_collapsed", collapsed);
  }

  DateTime? _parseDate(String? str) {
    if (str == null || str.isEmpty) return null;
    try {
      final parts = str.split("-");
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
    } catch (_) {}
    return null;
  }

  Future<StreakModel> getStreak() async {
    final raw = _box.get(_streakKey);
    StreakModel model;
    if (raw != null && raw is Map) {
      model = StreakModel.fromMap(Map<String, dynamic>.from(raw));
    } else {
      model = StreakModel.initial();
    }

    final now = DateTime.now();
    final todayStr = _formatDate(now);
    final storedTodayDate = _box.get(_todayDateKey) as String?;

    // Reset daily reading counters if calendar day changed
    int todayAyahs = 0;
    int todayPages = 0;
    if (storedTodayDate == todayStr) {
      todayAyahs = (_box.get(_todayAyahsKey) as num?)?.toInt() ?? 0;
      final pagesList = (_box.get(_todayPagesKey) as List<dynamic>?) ?? [];
      todayPages = pagesList.length;
    } else {
      // Day changed - clear temporary daily counters
      await _box.put(_todayDateKey, todayStr);
      await _box.put(_todayAyahsKey, 0);
      await _box.put(_todayPagesKey, <int>[]);
    }

    // Check streak validity relative to today
    int activeStreak = model.currentStreak;
    if (model.lastActiveDate != null) {
      final lastActive = _parseDate(model.lastActiveDate);
      if (lastActive != null) {
        final todayMidnight = DateTime(now.year, now.month, now.day);
        final lastMidnight = DateTime(
          lastActive.year,
          lastActive.month,
          lastActive.day,
        );
        final diffDays = todayMidnight.difference(lastMidnight).inDays;

        if (diffDays == 0) {
          // Read today - streak intact
        } else if (diffDays == 1) {
          // Read yesterday - streak intact, waiting for today
        } else if (diffDays == 2 && model.graceDaysRemaining > 0) {
          // 1 day gap with grace days available - keep active
        } else if (diffDays > 1) {
          // Streak broken
          activeStreak = 0;
        }
      }
    }

    return StreakModel(
      currentStreak: activeStreak,
      bestStreak: model.bestStreak,
      lastActiveDate: model.lastActiveDate,
      activeDates: model.activeDates,
      graceDaysRemaining: model.graceDaysRemaining,
      todayAyahsRead: todayAyahs,
      todayPagesRead: todayPages,
    );
  }

  Future<StreakModel> recordDailyReading({
    required int surahNumber,
    required int ayahNumber,
    int? pageNumber,
  }) async {
    final now = DateTime.now();
    final todayStr = _formatDate(now);
    final storedTodayDate = _box.get(_todayDateKey) as String?;

    // Update daily reading counters
    int todayAyahs = 0;
    List<int> pagesRead = [];

    if (storedTodayDate == todayStr) {
      todayAyahs = ((_box.get(_todayAyahsKey) as num?)?.toInt() ?? 0) + 1;
      final rawPages = (_box.get(_todayPagesKey) as List<dynamic>?) ?? [];
      pagesRead = rawPages.map((e) => (e as num).toInt()).toList();
    } else {
      todayAyahs = 1;
      pagesRead = [];
      await _box.put(_todayDateKey, todayStr);
    }

    if (pageNumber != null && !pagesRead.contains(pageNumber)) {
      pagesRead.add(pageNumber);

      // Auto-advance active Khatam plan progress on new page read
      final activeKhatam = getKhatamPlan();
      if (activeKhatam != null &&
          activeKhatam.isActive &&
          !activeKhatam.isCompleted) {
        final updatedKhatam = KhatamPlanModel.fromEntity(
          activeKhatam.copyWith(
            completedPages:
                (activeKhatam.completedPages + 1).clamp(0, activeKhatam.totalPages),
          ),
        );
        await saveKhatamPlan(updatedKhatam);
      }
    }

    // Auto-detect Sunnah Surahs: Al-Mulk (67) or Friday Al-Kahf (18)
    if (surahNumber == 67 ||
        (now.weekday == DateTime.friday && surahNumber == 18)) {
      await setSunnahSurahCompleted(true);
    }

    await _box.put(_todayAyahsKey, todayAyahs);
    await _box.put(_todayPagesKey, pagesRead);

    // Calculate updated streak
    final raw = _box.get(_streakKey);
    StreakModel current;
    if (raw != null && raw is Map) {
      current = StreakModel.fromMap(Map<String, dynamic>.from(raw));
    } else {
      current = StreakModel.initial();
    }

    int newStreak = current.currentStreak;
    int bestStreak = current.bestStreak;
    int graceRemaining = current.graceDaysRemaining;
    final List<String> activeDates = List<String>.from(current.activeDates);

    if (current.lastActiveDate == todayStr) {
      // Already credited today, just refresh counts
    } else if (current.lastActiveDate == null) {
      // First ever reading
      newStreak = 1;
      if (!activeDates.contains(todayStr)) activeDates.add(todayStr);
    } else {
      final lastActive = _parseDate(current.lastActiveDate);
      if (lastActive != null) {
        final todayMidnight = DateTime(now.year, now.month, now.day);
        final lastMidnight = DateTime(
          lastActive.year,
          lastActive.month,
          lastActive.day,
        );
        final diffDays = todayMidnight.difference(lastMidnight).inDays;

        if (diffDays == 1) {
          // Consecutive day!
          newStreak += 1;
          if (!activeDates.contains(todayStr)) activeDates.add(todayStr);
        } else if (diffDays == 2 && graceRemaining > 0) {
          // Grace day auto-applied for yesterday
          graceRemaining -= 1;
          newStreak += 1;
          if (!activeDates.contains(todayStr)) activeDates.add(todayStr);
        } else {
          // Broken streak, restart at 1
          newStreak = 1;
          if (!activeDates.contains(todayStr)) activeDates.add(todayStr);
        }
      } else {
        newStreak = 1;
        if (!activeDates.contains(todayStr)) activeDates.add(todayStr);
      }
    }

    if (newStreak > bestStreak) {
      bestStreak = newStreak;
    }

    final updatedModel = StreakModel(
      currentStreak: newStreak,
      bestStreak: bestStreak,
      lastActiveDate: todayStr,
      activeDates: activeDates,
      graceDaysRemaining: graceRemaining,
      todayAyahsRead: todayAyahs,
      todayPagesRead: pagesRead.length,
    );

    await _box.put(_streakKey, updatedModel.toMap());
    return updatedModel;
  }

  Future<StreakModel> useGraceDay() async {
    final current = await getStreak();
    if (current.graceDaysRemaining > 0) {
      final updated = StreakModel(
        currentStreak: current.currentStreak,
        bestStreak: current.bestStreak,
        lastActiveDate: current.lastActiveDate,
        activeDates: current.activeDates,
        graceDaysRemaining: current.graceDaysRemaining - 1,
        todayAyahsRead: current.todayAyahsRead,
        todayPagesRead: current.todayPagesRead,
      );
      await _box.put(_streakKey, updated.toMap());
      return updated;
    }
    return current;
  }

  Future<void> saveStreak(StreakModel streak) async {
    await _box.put(_streakKey, streak.toMap());
  }

  KhatamPlanModel? getKhatamPlan() {
    final raw = _box.get(_khatamPlanKey);
    if (raw != null && raw is Map) {
      return KhatamPlanModel.fromMap(Map<String, dynamic>.from(raw));
    }
    return null;
  }

  Future<void> saveKhatamPlan(KhatamPlanModel plan) async {
    await _box.put(_khatamPlanKey, plan.toMap());
  }

  Future<void> deleteKhatamPlan() async {
    await _box.delete(_khatamPlanKey);
  }
}
