import "dart:convert";

class ReciterInfoModel {
  String link;
  String name;
  bool? supportWordSegmentation;
  String? source;

  ReciterInfoModel({
    required this.link,
    required this.name,
    this.supportWordSegmentation,
    this.source,
  });

  ReciterInfoModel copyWith({
    String? link,
    String? name,
    bool? supportWordSegmentation,
    String? source,
  }) => ReciterInfoModel(
    link: link ?? this.link,
    name: name ?? this.name,
    supportWordSegmentation:
        supportWordSegmentation ?? this.supportWordSegmentation,
    source: source ?? this.source,
  );

  factory ReciterInfoModel.fromJson(String str) =>
      ReciterInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReciterInfoModel.fromMap(Map<String, dynamic> json) {
    return ReciterInfoModel(
      link: json["link"],
      name: json["name"],
      supportWordSegmentation: json["supportWordSegmentation"],
      source: json["source"],
    );
  }

  set expanded(bool expanded) {}

  Map<String, dynamic> toMap() => {
    "link": link,
    "name": name,
    "supportWordSegmentation": supportWordSegmentation,
    "source": source,
  };
}
