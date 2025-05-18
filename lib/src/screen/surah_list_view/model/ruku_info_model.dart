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
    rukuNumber: json["ruku_number"],
    surahRukuNumber: json["surah_ruku_number"],
    versesCount: json["verses_count"],
    firstVerseKey: json["first_verse_key"],
    lastVerseKey: json["last_verse_key"],
    verseMapping: Map.from(
      json["verse_mapping"],
    ).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    "ruku_number": rukuNumber,
    "surah_ruku_number": surahRukuNumber,
    "verses_count": versesCount,
    "first_verse_key": firstVerseKey,
    "last_verse_key": lastVerseKey,
    "verse_mapping": Map.from(
      verseMapping,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
