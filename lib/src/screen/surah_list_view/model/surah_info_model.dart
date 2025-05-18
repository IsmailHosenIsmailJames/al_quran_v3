import "dart:convert";

class SurahInfoModel {
  final int id;
  final String nameSimple;
  final String nameArabic;
  final int revelationOrder;
  final String revelationPlace;
  final int versesCount;
  final String pagesRange;

  SurahInfoModel({
    required this.id,
    required this.nameArabic,
    required this.nameSimple,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
    required this.pagesRange,
  });

  SurahInfoModel copyWith({
    int? id,
    int? name,
    String? nameSimple,
    String? nameArabic,
    int? revelationOrder,
    String? revelationPlace,
    int? versesCount,
    String? pagesRange,
  }) => SurahInfoModel(
    id: id ?? this.id,
    nameSimple: nameSimple ?? this.nameSimple,
    revelationOrder: revelationOrder ?? this.revelationOrder,
    revelationPlace: revelationPlace ?? this.revelationPlace,
    versesCount: versesCount ?? this.versesCount,
    pagesRange: pagesRange ?? this.pagesRange,
    nameArabic: nameArabic ?? this.nameArabic,
  );

  factory SurahInfoModel.fromJson(String str) =>
      SurahInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurahInfoModel.fromMap(Map<String, dynamic> json) => SurahInfoModel(
    id: json["id"],
    nameSimple: json["name_simple"],
    revelationOrder: json["revelation_order"],
    revelationPlace: json["revelation_place"],
    versesCount: json["verses_count"],
    pagesRange: json["pages_range"],
    nameArabic: json["name_arabic"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name_simple": nameSimple,
    "revelation_order": revelationOrder,
    "revelation_place": revelationPlace,
    "verses_count": versesCount,
    "pages_range": pagesRange,
    "name_arabic": nameArabic,
  };
}
