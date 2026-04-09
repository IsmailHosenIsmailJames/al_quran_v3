import "dart:convert";

class MushafScriptPageModel {
  final int pageNumber;
  final List<MushafLine> lines;

  MushafScriptPageModel({required this.pageNumber, required this.lines});

  MushafScriptPageModel copyWith({int? pageNumber, List<MushafLine>? lines}) =>
      MushafScriptPageModel(
        pageNumber: pageNumber ?? this.pageNumber,
        lines: lines ?? this.lines,
      );

  factory MushafScriptPageModel.fromJson(String str) =>
      MushafScriptPageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MushafScriptPageModel.fromMap(Map<String, dynamic> json) =>
      MushafScriptPageModel(
        pageNumber: json["page_number"],
        lines: List<MushafLine>.from(
          json["lines"].map((x) => MushafLine.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "page_number": pageNumber,
    "lines": List<dynamic>.from(lines.map((x) => x.toMap())),
  };
}

class MushafLine {
  final int lineNumber;
  final LineType lineType;
  final bool isCentered;
  final dynamic surahNumber;
  final String content;
  final int? firstWordId;
  final int? lastWordId;

  MushafLine({
    required this.lineNumber,
    required this.lineType,
    required this.isCentered,
    required this.surahNumber,
    required this.content,
    this.firstWordId,
    this.lastWordId,
  });

  MushafLine copyWith({
    int? lineNumber,
    LineType? lineType,
    bool? isCentered,
    dynamic surahNumber,
    String? content,
    int? firstWordId,
    int? lastWordId,
  }) => MushafLine(
    lineNumber: lineNumber ?? this.lineNumber,
    lineType: lineType ?? this.lineType,
    isCentered: isCentered ?? this.isCentered,
    surahNumber: surahNumber ?? this.surahNumber,
    content: content ?? this.content,
    firstWordId: firstWordId ?? this.firstWordId,
    lastWordId: lastWordId ?? this.lastWordId,
  );

  factory MushafLine.fromJson(String str) =>
      MushafLine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MushafLine.fromMap(Map<String, dynamic> json) => MushafLine(
    lineNumber: json["line_number"],
    lineType: lineTypeValues.map[json["line_type"]]!,
    isCentered: json["is_centered"],
    surahNumber: json["surah_number"],
    content: json["content"],
    firstWordId: json["first_word_id"] as int?,
    lastWordId: json["last_word_id"] as int?,
  );

  Map<String, dynamic> toMap() => {
    "line_number": lineNumber,
    "line_type": lineTypeValues.reverse[lineType],
    "is_centered": isCentered,
    "surah_number": surahNumber,
    "content": content,
    "first_word_id": firstWordId,
    "last_word_id": lastWordId,
  };
}

enum LineType { AYAH, BASMALLAH, SURAH_NAME }

final lineTypeValues = EnumValues({
  "ayah": LineType.AYAH,
  "basmallah": LineType.BASMALLAH,
  "surah_name": LineType.SURAH_NAME,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
