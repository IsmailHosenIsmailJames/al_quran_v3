import "dart:convert";

class PageInfoModel {
  final int start;
  final int end;
  final int surahNumber;
  final int pageNumber;

  PageInfoModel({
    required this.start,
    required this.end,
    required this.surahNumber,
    required this.pageNumber,
  });

  PageInfoModel copyWith({
    int? start,
    int? end,
    int? surahNumber,
    int? pageNumber,
  }) => PageInfoModel(
    start: start ?? this.start,
    end: end ?? this.end,
    surahNumber: surahNumber ?? this.surahNumber,
    pageNumber: pageNumber ?? this.pageNumber,
  );

  factory PageInfoModel.fromJson(String str) =>
      PageInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PageInfoModel.fromMap(Map<String, dynamic> json) => PageInfoModel(
    start: json["s"],
    end: json["e"],
    surahNumber: json["sn"],
    pageNumber: json["i"],
  );

  Map<String, dynamic> toMap() => {
    "s": start,
    "e": end,
    "sn": surahNumber,
    "i": pageNumber,
  };
}
