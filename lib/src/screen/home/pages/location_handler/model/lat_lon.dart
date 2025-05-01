import 'dart:convert';

class LatLon {
  double latitude;
  double longitude;

  LatLon({required this.latitude, required this.longitude});

  LatLon copyWith({double? latitude, double? longitude}) => LatLon(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
  );

  factory LatLon.fromJson(String str) => LatLon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LatLon.fromMap(Map<String, dynamic> json) => LatLon(
    latitude: json['latitude']?.toDouble(),
    longitude: json['longitude']?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}
