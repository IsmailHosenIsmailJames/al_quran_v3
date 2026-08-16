import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";

class HistoryElementModel extends HistoryElementEntity {
  const HistoryElementModel({
    required super.surahNumber,
    super.ayahNumber,
    super.pageNumber,
    required super.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "surahNumber": surahNumber,
      "ayahNumber": ayahNumber,
      "pageNumber": pageNumber,
      "timestamp": timestamp,
    };
  }

  factory HistoryElementModel.fromJson(Map<String, dynamic> json) {
    return HistoryElementModel(
      surahNumber: json["surahNumber"],
      ayahNumber: json["ayahNumber"],
      pageNumber: json["pageNumber"],
      timestamp: json["timestamp"],
    );
  }

  factory HistoryElementModel.fromEntity(HistoryElementEntity entity) {
    return HistoryElementModel(
      surahNumber: entity.surahNumber,
      ayahNumber: entity.ayahNumber,
      pageNumber: entity.pageNumber,
      timestamp: entity.timestamp,
    );
  }
}
