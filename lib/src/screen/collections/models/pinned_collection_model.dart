import "dart:convert";

import "package:al_quran_v3/src/screen/collections/models/pinned_model.dart.dart";

class PinnedCollectionModel {
  String id;
  String name;
  String colorHex;
  List<PinnedModel> pinned;
  DateTime createdAt;
  DateTime updatedAt;

  PinnedCollectionModel({
    required this.id,
    required this.name,
    this.colorHex = "808080",
    required this.pinned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PinnedCollectionModel.fromJson(Map<String, dynamic> json) {
    return PinnedCollectionModel(
      id: json["id"] as String,
      name: json["name"] as String,
      colorHex: json["colorHex"] as String? ?? "808080",
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
      pinned:
          ((json["pinned"] ?? []) as List<dynamic>)
              .map(
                (noteJson) =>
                    PinnedModel.fromJson(Map<String, dynamic>.from(noteJson)),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "colorHex": colorHex,
      "pinned": pinned.map((note) => note.toJson()).toList(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());

  factory PinnedCollectionModel.fromJsonString(String jsonString) =>
      PinnedCollectionModel.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );

  PinnedCollectionModel copyWith({
    String? id,
    String? name,
    String? colorHex,
    List<PinnedModel>? pinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PinnedCollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      pinned: pinned ?? this.pinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
