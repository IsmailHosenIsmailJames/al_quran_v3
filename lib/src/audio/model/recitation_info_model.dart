import 'dart:convert';

class ReciterInfoModel {
  String link;
  String name;

  ReciterInfoModel({required this.link, required this.name});

  ReciterInfoModel copyWith({
    String? link,
    String? name,
    String? bitrate,
    String? style,
  }) => ReciterInfoModel(link: link ?? this.link, name: name ?? this.name);

  factory ReciterInfoModel.fromJson(String str) =>
      ReciterInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReciterInfoModel.fromMap(Map<String, dynamic> json) =>
      ReciterInfoModel(link: json['link'], name: json['name']);

  set expanded(bool expanded) {}

  Map<String, dynamic> toMap() => {'link': link, 'name': name};
}
