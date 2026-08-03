import "dart:convert";

class LocationCoordinates {
  final double latitude;
  final double longitude;
  final String? cityName;
  final String? countryName;

  const LocationCoordinates({
    required this.latitude,
    required this.longitude,
    this.cityName,
    this.countryName,
  });

  LocationCoordinates copyWith({
    double? latitude,
    double? longitude,
    String? cityName,
    String? countryName,
  }) {
    return LocationCoordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
      countryName: countryName ?? this.countryName,
    );
  }

  factory LocationCoordinates.fromJson(String str) =>
      LocationCoordinates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationCoordinates.fromMap(Map<String, dynamic> json) =>
      LocationCoordinates(
        latitude: (json["latitude"] as num).toDouble(),
        longitude: (json["longitude"] as num).toDouble(),
        cityName: json["cityName"] as String?,
        countryName: json["countryName"] as String?,
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        if (cityName != null) "cityName": cityName,
        if (countryName != null) "countryName": countryName,
      };
}
