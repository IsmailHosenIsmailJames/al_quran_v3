class HistoryElementEntity {
  final int surahNumber;
  final int? ayahNumber;
  final int? pageNumber;
  final int timestamp;

  const HistoryElementEntity({
    required this.surahNumber,
    this.ayahNumber,
    this.pageNumber,
    required this.timestamp,
  });
}
