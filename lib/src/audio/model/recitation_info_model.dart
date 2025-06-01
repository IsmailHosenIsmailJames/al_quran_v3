import "dart:convert";

class ReciterInfoModel {
  String link;
  String name;
  bool? supportWordSegmentation;
  String? source;
  String? style;
  String? img;
  String? bio;

  ReciterInfoModel({
    required this.link,
    required this.name,
    this.supportWordSegmentation,
    this.source,
    this.style,
    this.img,
    this.bio,
  });

  ReciterInfoModel copyWith({
    String? link,
    String? name,
    bool? supportWordSegmentation,
    String? source,
    String? style,
    String? img,
    String? bio,
  }) => ReciterInfoModel(
    link: link ?? this.link,
    name: name ?? this.name,
    supportWordSegmentation:
        supportWordSegmentation ?? this.supportWordSegmentation,
    source: source ?? this.source,
    style: style ?? this.style,
    img: img ?? this.img,
    bio: bio ?? this.bio,
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
      style: json["style"],
      img: json["img"],
      bio: json["bio"],
    );
  }

  set expanded(bool expanded) {}

  Map<String, dynamic> toMap() => {
    "link": link,
    "name": name,
    "supportWordSegmentation": supportWordSegmentation,
    "source": source,
    "style": style,
    "img": img,
    "bio": bio,
  };
}
