class AyahKeyManagement {
  final String start;
  final String end;
  final String current;
  final List<String> ayahList;
  final int? lastScrolledPageNumber;

  AyahKeyManagement({
    required this.start,
    required this.end,
    required this.current,
    required this.ayahList,
    this.lastScrolledPageNumber,
  });

  AyahKeyManagement copyWith({
    String? start,
    String? end,
    String? current,
    List<String>? ayahList,
    int? lastScrolledPageNumber,
  }) {
    return AyahKeyManagement(
      start: start ?? this.start,
      end: end ?? this.end,
      current: current ?? this.current,
      ayahList: ayahList ?? this.ayahList,
      lastScrolledPageNumber:
          lastScrolledPageNumber ?? this.lastScrolledPageNumber,
    );
  }
}
