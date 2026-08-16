import "dart:convert";

enum ResourceType { tafsir, simple, word_by_word, with_footnote }

class ResourcesModel {
  final String language;
  final String languageNative;
  final String languageCode;
  final String name;
  final String englishName;
  final String fileName;
  final String fullPath;
  final ResourceType type;
  final bool isTajweed;

  ResourcesModel({
    required this.language,
    required this.languageNative,
    required this.languageCode,
    required this.name,
    required this.englishName,
    required this.fileName,
    required this.fullPath,
    required this.type,
    this.isTajweed = false,
  });

  ResourcesModel copyWith({
    String? language,
    String? languageNative,
    String? languageCode,
    String? name,
    String? englishName,
    String? fileName,
    String? fullPath,
    ResourceType? type,
    bool? isTajweed,
  }) {
    return ResourcesModel(
      language: language ?? this.language,
      languageNative: languageNative ?? this.languageNative,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      fileName: fileName ?? this.fileName,
      fullPath: fullPath ?? this.fullPath,
      type: type ?? this.type,
      isTajweed: isTajweed ?? this.isTajweed,
    );
  }

  factory ResourcesModel.fromJson(String str) =>
      ResourcesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResourcesModel.fromMap(Map<String, dynamic> json) => ResourcesModel(
    language: json["language"] ?? "",
    languageNative: json["language_native"] ?? "",
    languageCode: json["language_code"] ?? "",
    name: json["name"] ?? "",
    englishName: json["english_name"] ?? "",
    fileName: json["file_name"] ?? "",
    fullPath: json["full_path"] ?? "",
    type: ResourceType.values.firstWhere(
      (e) => e.name == json["type"],
      orElse: () => ResourceType.simple,
    ),
    isTajweed: json["is_tajweed"] ?? false,
  );

  Map<String, dynamic> toMap() => {
    "language": language,
    "language_native": languageNative,
    "language_code": languageCode,
    "name": name,
    "english_name": englishName,
    "file_name": fileName,
    "full_path": fullPath,
    "type": type.name,
    "is_tajweed": isTajweed,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourcesModel &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          languageNative == other.languageNative &&
          languageCode == other.languageCode &&
          name == other.name &&
          englishName == other.englishName &&
          fileName == other.fileName &&
          fullPath == other.fullPath &&
          type == other.type &&
          isTajweed == other.isTajweed;

  @override
  int get hashCode =>
      language.hashCode ^
      languageNative.hashCode ^
      languageCode.hashCode ^
      name.hashCode ^
      englishName.hashCode ^
      fileName.hashCode ^
      fullPath.hashCode ^
      type.hashCode ^
      isTajweed.hashCode;
}
