class QuranHistoryState {
  List<HistoryElement> history;
  QuranHistoryState({required this.history});
}

class HistoryElement {
  final int surahNumber;
  final int ayahNumber;
  final int timestamp;

  HistoryElement({
    required this.surahNumber,
    required this.ayahNumber,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "surahNumber": surahNumber,
      "ayahNumber": ayahNumber,
      "timestamp": timestamp,
    };
  }

  factory HistoryElement.fromJson(Map<String, dynamic> json) {
    return HistoryElement(
      surahNumber: json["surahNumber"],
      ayahNumber: json["ayahNumber"],
      timestamp: json["timestamp"],
    );
  }
}
