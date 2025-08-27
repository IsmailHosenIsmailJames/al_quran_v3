import "dart:convert";

class RukuInfoModel {
  final int rukuNumber;
  final int surahRukuNumber;
  final int versesCount;
  final String firstVerseKey;
  final String lastVerseKey;
  final Map<String, String> verseMapping;

  RukuInfoModel({
    required this.rukuNumber,
    required this.surahRukuNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });

  RukuInfoModel copyWith({
    int? rukuNumber,
    int? surahRukuNumber,
    int? versesCount,
    String? firstVerseKey,
    String? lastVerseKey,
    Map<String, String>? verseMapping,
  }) => RukuInfoModel(
    rukuNumber: rukuNumber ?? this.rukuNumber,
    surahRukuNumber: surahRukuNumber ?? this.surahRukuNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );

  factory RukuInfoModel.fromJson(String str) =>
      RukuInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RukuInfoModel.fromMap(Map<String, dynamic> json) => RukuInfoModel(
    rukuNumber: json["rn"], // ruku_number
    surahRukuNumber: json["srn"], // surah_ruku_number
    versesCount: json["vc"], // verses_count
    firstVerseKey: json["fvk"], // first_verse_key
    lastVerseKey: json["lvk"], // last_verse_key
    verseMapping: Map.from(
      json["vm"], // verse_mapping
    ).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    "rn": rukuNumber,
    "srn": surahRukuNumber,
    "vc": versesCount,
    "fvk": firstVerseKey,
    "lvk": lastVerseKey,
    "vm": Map.from(verseMapping).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
