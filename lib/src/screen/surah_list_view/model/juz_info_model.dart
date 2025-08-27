import "dart:convert";

class JuzInfoModel {
  final int juzNumber;
  final int versesCount;
  final String firstVerseKey;
  final String lastVerseKey;
  final Map<String, String> verseMapping;

  JuzInfoModel({
    required this.juzNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });

  JuzInfoModel copyWith({
    int? juzNumber,
    int? versesCount,
    String? firstVerseKey,
    String? lastVerseKey,
    Map<String, String>? verseMapping,
  }) => JuzInfoModel(
    juzNumber: juzNumber ?? this.juzNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );

  factory JuzInfoModel.fromJson(String str) =>
      JuzInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JuzInfoModel.fromMap(Map<String, dynamic> json) => JuzInfoModel(
    juzNumber: json["jn"], // juz_number
    versesCount: json["vc"], // verses_count
    firstVerseKey: json["fvk"], // first_verse_key
    lastVerseKey: json["lvk"], // last_verse_key
    verseMapping: Map.from(
      json["vm"], // verse_mapping
    ).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    "jn": juzNumber,
    "vc": versesCount,
    "fvk": firstVerseKey,
    "lvk": lastVerseKey,
    "vm": Map.from(verseMapping).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
