import "dart:convert";

class CalculationMethod {
  int id;
  String name;
  Params? params;
  Location? location;

  CalculationMethod({
    required this.id,
    required this.name,
    this.params,
    this.location,
  });

  CalculationMethod copyWith({
    int? id,
    String? name,
    Params? params,
    Location? location,
  }) => CalculationMethod(
    id: id ?? this.id,
    name: name ?? this.name,
    params: params ?? this.params,
    location: location ?? this.location,
  );

  factory CalculationMethod.fromJson(String str) =>
      CalculationMethod.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CalculationMethod.fromMap(Map<String, dynamic> json) =>
      CalculationMethod(
        id: json["id"],
        name: json["name"],
        params: json["params"] == null ? null : Params.fromMap(json["params"]),
        location:
            json["location"] == null
                ? null
                : Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "params": params?.toMap(),
    "location": location?.toMap(),
  };
}

class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});

  Location copyWith({double? latitude, double? longitude}) => Location(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
  );

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Params {
  String? fajr;
  String? isha;
  String? midnight;
  String? maghrib;

  Params({required this.fajr, required this.isha, this.midnight, this.maghrib});

  Params copyWith({
    String? fajr,
    String? isha,
    String? midnight,
    String? maghrib,
  }) => Params(
    fajr: fajr ?? this.fajr,
    isha: isha ?? this.isha,
    midnight: midnight ?? this.midnight,
    maghrib: maghrib ?? this.maghrib,
  );

  factory Params.fromJson(String str) => Params.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Params.fromMap(Map<String, dynamic> json) => Params(
    fajr: json["Fajr"],
    isha: json["Isha"],
    midnight: json["Midnight"],
    maghrib: json["Maghrib"],
  );

  Map<String, dynamic> toMap() => {
    "Fajr": fajr,
    "Isha": isha,
    "Midnight": midnight,
    "Maghrib": maghrib,
  };
}
