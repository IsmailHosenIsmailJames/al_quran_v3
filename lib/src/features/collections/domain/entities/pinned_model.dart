import "dart:convert";

class PinnedModel {
  String id;
  String ayahKey;
  DateTime createdAt;
  DateTime updatedAt;

  PinnedModel({
    required this.id,
    required this.ayahKey,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PinnedModel.fromJson(Map<String, dynamic> json) {
    return PinnedModel(
      id: json["id"] as String,
      ayahKey: json["ayahKey"],
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ayahKey": ayahKey,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());

  factory PinnedModel.fromJsonString(String jsonString) =>
      PinnedModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  PinnedModel copyWith({
    String? id,
    String? ayahKey,
    List<String>? collectionIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PinnedModel(
      id: id ?? this.id,
      ayahKey: ayahKey ?? this.ayahKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
