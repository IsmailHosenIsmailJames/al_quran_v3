class AyahKeyManagement {
  final String start;
  final String end;
  final String current;
  final List<String> ayahList;

  AyahKeyManagement({
    required this.start,
    required this.end,
    required this.current,
    required this.ayahList,
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
