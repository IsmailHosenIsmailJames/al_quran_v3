import "dart:convert";

class TranslationBookModel {
  String language;
  String name;
  String fileName;
  double score;
  TranslationResourcesType type;
  String fullPath;

  TranslationBookModel({
    required this.language,
    required this.name,
    required this.fileName,
    required this.score,
    required this.type,
    required this.fullPath,
  });

  TranslationBookModel copyWith({
    String? language,
    String? name,
    String? fileName,
    double? score,
    TranslationResourcesType? type,
    String? fullPath,
  }) => TranslationBookModel(
    language: language ?? this.language,
    name: name ?? this.name,
    fileName: fileName ?? this.fileName,
    score: score ?? this.score,
    type: type ?? this.type,
    fullPath: fullPath ?? this.fullPath,
  );

  factory TranslationBookModel.fromJson(String str) =>
      TranslationBookModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TranslationBookModel.fromMap(Map<String, dynamic> json) =>
      TranslationBookModel(
        language: json["language"],
        name: json["name"],
        fileName: json["file_name"],
        score: json["score"],
        type: TranslationResourcesType.values.firstWhere(
          (element) => element.name == json["type"],
        ),
        fullPath: json["full_path"],
      );

  Map<String, dynamic> toMap() => {
    "language": language,
    "name": name,
    "file_name": fileName,
    "score": score,
    "type": type.name,
    "full_path": fullPath,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationBookModel &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          name == other.name &&
          fileName == other.fileName &&
          score == other.score &&
          type == other.type &&
          fullPath == other.fullPath;

  @override
  int get hashCode =>
      language.hashCode ^
      name.hashCode ^
      fileName.hashCode ^
      score.hashCode ^
      type.hashCode ^
      fullPath.hashCode;
}

enum TranslationResourcesType { simple, withFootnoteTags, wordByWord }
