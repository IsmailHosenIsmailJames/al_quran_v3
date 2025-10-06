import "dart:convert";

class ReciterInfoModel {
  String link;
  String name;
  bool? supportWordSegmentation;
  String? source;
  String? style;
  String? img;
  String? bio;
  String? segmentsUrl;
  bool isDownloading;
  String? showAyahHilight;

  ReciterInfoModel({
    required this.link,
    required this.name,
    this.supportWordSegmentation,
    this.source,
    this.style,
    this.img,
    this.bio,
    this.segmentsUrl,
    this.isDownloading = false,
    this.showAyahHilight,
  });

  ReciterInfoModel copyWith({
    String? link,
    String? name,
    bool? supportWordSegmentation,
    String? source,
    String? style,
    String? img,
    String? bio,
    String? segmentsUrl,
    bool? isDownloading,
    String? showAyahHilight,
  }) => ReciterInfoModel(
    link: link ?? this.link,
    name: name ?? this.name,
    supportWordSegmentation:
        supportWordSegmentation ?? this.supportWordSegmentation,
    source: source ?? this.source,
    style: style ?? this.style,
    img: img ?? this.img,
    bio: bio ?? this.bio,
    segmentsUrl: segmentsUrl ?? this.segmentsUrl,
    isDownloading: isDownloading ?? this.isDownloading,
    showAyahHilight: showAyahHilight,
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
      segmentsUrl: json["segments_url"],
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
    "segments_url": segmentsUrl,
  };
}
