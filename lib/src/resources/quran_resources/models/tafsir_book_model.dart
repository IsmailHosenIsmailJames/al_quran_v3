import "dart:convert";

class TafsirBookModel {
  String language;
  String name;
  int totalAyahs;
  int hasTafsir;
  double score;
  String fullPath;

  TafsirBookModel({
    required this.language,
    required this.name,
    required this.totalAyahs,
    required this.hasTafsir,
    required this.score,
    required this.fullPath,
  });

  TafsirBookModel copyWith({
    String? language,
    String? name,
    int? totalAyahs,
    int? hasTafsir,
    double? score,
    String? fullPath,
  }) => TafsirBookModel(
    language: language ?? this.language,
    name: name ?? this.name,
    totalAyahs: totalAyahs ?? this.totalAyahs,
    hasTafsir: hasTafsir ?? this.hasTafsir,
    score: score ?? this.score,
    fullPath: fullPath ?? this.fullPath,
  );

  factory TafsirBookModel.fromJson(String str) =>
      TafsirBookModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TafsirBookModel.fromMap(Map<String, dynamic> json) => TafsirBookModel(
    language: json["language"],
    name: json["name"],
    totalAyahs: json["totalAyahs"],
    hasTafsir: json["hasTafsir"],
    score: json["score"].toDouble(),
    fullPath: json["full_path"],
  );

  Map<String, dynamic> toMap() => {
    "language": language,
    "name": name,
    "totalAyahs": totalAyahs,
    "hasTafsir": hasTafsir,
    "score": score,
    "full_path": fullPath,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TafsirBookModel &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          name == other.name &&
          totalAyahs == other.totalAyahs &&
          hasTafsir == other.hasTafsir &&
          score == other.score &&
          fullPath == other.fullPath;

  @override
  int get hashCode =>
      language.hashCode ^
      name.hashCode ^
      totalAyahs.hashCode ^
      hasTafsir.hashCode ^
      score.hashCode ^
      fullPath.hashCode;
}
