class AyahKeyManagement {
  final String start;
  final String end;
  final String current;
  final List<String> ayahList;

  AyahKeyManagement({
    this.start = "1:1",
    this.end = "1:7",
    this.current = "1:1",
    this.ayahList = const ["1:1", "1:2", "1:3", "1:4", "1:5", "1:6", "1:7"],
  });

  AyahKeyManagement copyWith({
    String? start,
    String? end,
    String? current,
    List<String>? ayahList,
  }) {
    return AyahKeyManagement(
      start: start ?? this.start,
      end: end ?? this.end,
      current: current ?? this.current,
      ayahList: ayahList ?? this.ayahList,
    );
  }
}
