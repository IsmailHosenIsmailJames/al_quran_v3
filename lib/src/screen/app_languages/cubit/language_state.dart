import "dart:convert";

class AppLanguage {
  final String english;
  final String native;
  final String code;

  AppLanguage({
    required this.english,
    required this.native,
    required this.code,
  });

  AppLanguage copyWith({String? english, String? native, String? code}) =>
      AppLanguage(
        english: english ?? this.english,
        native: native ?? this.native,
        code: code ?? this.code,
      );

  factory AppLanguage.fromJson(String str) =>
      AppLanguage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppLanguage.fromMap(Map<String, dynamic> json) => AppLanguage(
    english: json["English"],
    native: json["Native"],
    code: json["Code"],
  );

  Map<String, dynamic> toMap() => {
    "English": english,
    "Native": native,
    "Code": code,
  };
}
