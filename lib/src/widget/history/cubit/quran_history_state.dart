class QuranHistoryState {
  List<HistoryElement> history;
  QuranHistoryState({required this.history});
}

class HistoryElement {
  final int surahNumber;
  final int? ayahNumber;
  final int? pageNumber;
  final int timestamp;

  HistoryElement({
    required this.surahNumber,
    this.ayahNumber,
    this.pageNumber,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "surahNumber": surahNumber,
      "ayahNumber": ayahNumber,
      "pageNumber": pageNumber,
      "timestamp": timestamp,
    };
  }

  factory HistoryElement.fromJson(Map<String, dynamic> json) {
    return HistoryElement(
      surahNumber: json["surahNumber"],
      ayahNumber: json["ayahNumber"],
      pageNumber: json["pageNumber"],
      timestamp: json["timestamp"],
    );
  }
}
