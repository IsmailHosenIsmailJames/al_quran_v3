import "dart:convert";

class PageInfoModel {
  final int start;
  final int end;
  final int surahNumber;

  PageInfoModel({
    required this.start,
    required this.end,
    required this.surahNumber,
  });

  PageInfoModel copyWith({int? start, int? end, int? surahNumber}) =>
      PageInfoModel(
        start: start ?? this.start,
        end: end ?? this.end,
        surahNumber: surahNumber ?? this.surahNumber,
      );

  factory PageInfoModel.fromJson(String str) =>
      PageInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PageInfoModel.fromMap(Map<String, dynamic> json) =>
      PageInfoModel(start: json["s"], end: json["e"], surahNumber: json["sn"]);

  Map<String, dynamic> toMap() => {"s": start, "e": end, "sn": surahNumber};
}
