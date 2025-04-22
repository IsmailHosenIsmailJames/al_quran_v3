class AyahKeyManagement {
  String? start;
  String? end;
  String? current;
  List<String>? ayahList;
  AyahKeyManagement({this.start, this.end, this.current, this.ayahList});

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
