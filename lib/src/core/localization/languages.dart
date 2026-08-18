import "dart:ui";

List<MyAppLocalization> usedAppLanguageMap = [
  MyAppLocalization(
    english: "English",
    native: "English",
    locale: const Locale("en", "US"),
  ),

  MyAppLocalization(
    english: "Arabic",
    native: "العربية",
    locale: const Locale("ar"),
  ),

  MyAppLocalization(
    english: "Urdu",
    native: "اُردُو",
    locale: const Locale("ur", "PK"),
  ),

  MyAppLocalization(
    english: "Bengali",
    native: "বাংলা",
    locale: const Locale("bn", "BD"),
  ),

  MyAppLocalization(
    english: "Indonesian",
    native: "Bahasa Indonesia",
    locale: const Locale("id"),
  ),

  MyAppLocalization(
    english: "Turkish",
    native: "Türkçe",
    locale: const Locale("tr"),
  ),

  MyAppLocalization(
    english: "Persian",
    native: "فارسی",
    locale: const Locale("fa", "IR"),
  ),

  MyAppLocalization(
    english: "Punjabi",
    native: "ਪੰਜਾਬੀ",
    locale: const Locale("pa", "IN"),
  ),

  MyAppLocalization(
    english: "Pashto",
    native: "پښتو",
    locale: const Locale("ps", "AF"),
  ),

  MyAppLocalization(
    english: "Malay",
    native: "Bahasa Melayu",
    locale: const Locale("ms", "MY"),
  ),

  MyAppLocalization(
    english: "French",
    native: "Français",
    locale: const Locale("fr", "FR"),
  ),

  MyAppLocalization(
    english: "Russian",
    native: "Русский",
    locale: const Locale("ru", "RU"),
  ),

  MyAppLocalization(
    english: "Swahili",
    native: "Kiswahili",
    locale: const Locale("sw", "KE"),
  ),

  MyAppLocalization(
    english: "Azerbaijani",
    native: "Azərbaycanca",
    locale: const Locale("az", "AZ"),
  ),

  MyAppLocalization(
    english: "Kazakh",
    native: "Қазақ тілі",
    locale: const Locale("kk", "KZ"),
  ),

  MyAppLocalization(
    english: "Hindi",
    native: "हिन्दी",
    locale: const Locale("hi", "IN"),
  ),

  MyAppLocalization(
    english: "Spanish",
    native: "Español",
    locale: const Locale("es", "ES"),
  ),

  MyAppLocalization(
    english: "Portuguese",
    native: "Português",
    locale: const Locale("pt", "PT"),
  ),

  MyAppLocalization(
    english: "Chinese",
    native: "中文",
    locale: const Locale("zh", "CN"),
  ),

  MyAppLocalization(
    english: "Japanese",
    native: "日本語",
    locale: const Locale("ja"),
  ),

  MyAppLocalization(
    english: "German",
    native: "Deutsch",
    locale: const Locale("de"),
  ),

  MyAppLocalization(
    english: "Korean",
    native: "한국어",
    locale: const Locale("ko"),
  ),

  MyAppLocalization(
    english: "Vietnamese",
    native: "Tiếng Việt",
    locale: const Locale("vi", "VN"),
  ),

  MyAppLocalization(
    english: "Tamil",
    native: "தமிழ்",
    locale: const Locale("ta", "IN"),
  ),

  MyAppLocalization(
    english: "Italian",
    native: "Italiano",
    locale: const Locale("it"),
  ),
];

class MyAppLocalization {
  String english;
  String native;
  Locale locale;

  MyAppLocalization({
    required this.english,
    required this.native,
    required this.locale,
  });

  Map<String, dynamic> toJson() {
    return {
      "english": english,
      "native": native,
      "locale": {
        "languageCode": locale.languageCode,
        "countryCode": locale.countryCode,
      },
    };
  }

  factory MyAppLocalization.fromJson(Map<String, dynamic> json) {
    return MyAppLocalization(
      english: json["english"] as String,
      native: json["native"] as String,
      locale: Locale(
        json["locale"]["languageCode"] as String,
        json["locale"]["countryCode"] as String?,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyAppLocalization &&
        other.english == english &&
        other.native == native &&
        other.locale == locale;
  }

  @override
  int get hashCode => english.hashCode ^ native.hashCode ^ locale.hashCode;
}
