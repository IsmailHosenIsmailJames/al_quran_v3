class DailyPlanEntity {
  final Map<String, bool> prayersCompleted; // "fajr", "dhuhr", "asr", "maghrib", "isha"
  final bool isSunnahSurahCompleted;
  final bool isCollapsed;

  const DailyPlanEntity({
    required this.prayersCompleted,
    this.isSunnahSurahCompleted = false,
    this.isCollapsed = false,
  });

  static const List<String> prayerKeys = [
    "fajr",
    "dhuhr",
    "asr",
    "maghrib",
    "isha",
  ];

  int get completedPrayersCount =>
      prayersCompleted.values.where((v) => v).length;

  bool get allPrayersCompleted => completedPrayersCount == 5;

  DailyPlanEntity copyWith({
    Map<String, bool>? prayersCompleted,
    bool? isSunnahSurahCompleted,
    bool? isCollapsed,
  }) {
    return DailyPlanEntity(
      prayersCompleted: prayersCompleted ?? this.prayersCompleted,
      isSunnahSurahCompleted:
          isSunnahSurahCompleted ?? this.isSunnahSurahCompleted,
      isCollapsed: isCollapsed ?? this.isCollapsed,
    );
  }

  factory DailyPlanEntity.initial() {
    return const DailyPlanEntity(
      prayersCompleted: {
        "fajr": false,
        "dhuhr": false,
        "asr": false,
        "maghrib": false,
        "isha": false,
      },
      isSunnahSurahCompleted: false,
      isCollapsed: false,
    );
  }
}
