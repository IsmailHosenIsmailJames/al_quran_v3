import 'dart:convert';

class HizbModel {
  final int hizbNumber;
  final int versesCount;
  final String firstVerseKey;
  final String lastVerseKey;
  final Map<String, String> verseMapping;

  HizbModel({
    required this.hizbNumber,
    required this.versesCount,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.verseMapping,
  });

  HizbModel copyWith({
    int? hizbNumber,
    int? versesCount,
    String? firstVerseKey,
    String? lastVerseKey,
    Map<String, String>? verseMapping,
  }) => HizbModel(
    hizbNumber: hizbNumber ?? this.hizbNumber,
    versesCount: versesCount ?? this.versesCount,
    firstVerseKey: firstVerseKey ?? this.firstVerseKey,
    lastVerseKey: lastVerseKey ?? this.lastVerseKey,
    verseMapping: verseMapping ?? this.verseMapping,
  );

  factory HizbModel.fromJson(String str) => HizbModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HizbModel.fromMap(Map<String, dynamic> json) => HizbModel(
    hizbNumber: json['hizb_number'],
    versesCount: json['verses_count'],
    firstVerseKey: json['first_verse_key'],
    lastVerseKey: json['last_verse_key'],
    verseMapping: Map.from(
      json['verse_mapping'],
    ).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    'hizb_number': hizbNumber,
    'verses_count': versesCount,
    'first_verse_key': firstVerseKey,
    'last_verse_key': lastVerseKey,
    'verse_mapping': Map.from(
      verseMapping,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
