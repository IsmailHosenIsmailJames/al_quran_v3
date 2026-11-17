import "package:al_quran_v3/src/features/daily_plan/domain/entities/khatam_plan_entity.dart";

class KhatamPlanModel extends KhatamPlanEntity {
  const KhatamPlanModel({
    required super.id,
    required super.title,
    super.totalPages = 604,
    super.startPage = 1,
    super.completedPages = 0,
    required super.startDate,
    required super.targetDate,
    super.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "totalPages": totalPages,
      "startPage": startPage,
      "completedPages": completedPages,
      "startDate": startDate.toIso8601String(),
      "targetDate": targetDate.toIso8601String(),
      "isActive": isActive,
    };
  }

  factory KhatamPlanModel.fromMap(Map<String, dynamic> map) {
    return KhatamPlanModel(
      id: map["id"] as String? ?? "khatam_default",
      title: map["title"] as String? ?? "Khatam Plan",
      totalPages: (map["totalPages"] as num?)?.toInt() ?? 604,
      startPage: (map["startPage"] as num?)?.toInt() ?? 1,
      completedPages: (map["completedPages"] as num?)?.toInt() ?? 0,
      startDate: map["startDate"] != null
          ? DateTime.tryParse(map["startDate"] as String) ?? DateTime.now()
          : DateTime.now(),
      targetDate: map["targetDate"] != null
          ? DateTime.tryParse(map["targetDate"] as String) ??
              DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
      isActive: map["isActive"] as bool? ?? true,
    );
  }

  factory KhatamPlanModel.fromEntity(KhatamPlanEntity entity) {
    return KhatamPlanModel(
      id: entity.id,
      title: entity.title,
      totalPages: entity.totalPages,
      startPage: entity.startPage,
      completedPages: entity.completedPages,
      startDate: entity.startDate,
      targetDate: entity.targetDate,
      isActive: entity.isActive,
    );
  }
}
