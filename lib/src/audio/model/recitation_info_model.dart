import 'dart:convert';

class ReciterInfoModel {
  String link;
  String name;
  bool? supportWordSegmentation;

  ReciterInfoModel({
    required this.link,
    required this.name,
    this.supportWordSegmentation,
  });

  ReciterInfoModel copyWith({
    String? link,
    String? name,
    bool? supportWordSegmentation,
  }) => ReciterInfoModel(
    link: link ?? this.link,
    name: name ?? this.name,
    supportWordSegmentation:
        supportWordSegmentation ?? this.supportWordSegmentation,
  );

  factory ReciterInfoModel.fromJson(String str) =>
      ReciterInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReciterInfoModel.fromMap(Map<String, dynamic> json) {
    return ReciterInfoModel(
      link: json['link'],
      name: json['name'],
      supportWordSegmentation: json['supportWordSegmentation'],
    );
  }

  set expanded(bool expanded) {}

  Map<String, dynamic> toMap() => {
    'link': link,
    'name': name,
    'supportWordSegmentation': supportWordSegmentation,
  };
}
