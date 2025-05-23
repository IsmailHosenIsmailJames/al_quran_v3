import "dart:convert";
import "package:dartx/dartx_io.dart";

class CalculationMethod {
  int id;
  String name;
  Params params;
  Location location;

  CalculationMethod({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
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
        params: Params.fromMap(json["params"]),
        location: Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "params": params.toMap(),
    "location": location.toMap(),
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
  double fajr;
  double isha;

  Params({required this.fajr, required this.isha});

  Params copyWith({double? fajr, double? isha}) =>
      Params(fajr: fajr ?? this.fajr, isha: isha ?? this.isha);

  factory Params.fromJson(String str) => Params.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Params.fromMap(Map<String, dynamic> json) =>
      Params(fajr: json["Fajr"].toDouble(), isha: json["Isha"].toDouble());

  Map<String, dynamic> toMap() => {"Fajr": fajr, "Isha": isha};
}

int defaultIndex = 3;
CalculationMethod defaultCalculationMethod = CalculationMethod.fromMap(
  prayerTimeCalculationMethodList.firstOrNullWhere(
        (element) => element["id"] == defaultIndex,
      ) ??
      prayerTimeCalculationMethodList[3],
);
List prayerTimeCalculationMethodList = [
  {
    "id": 0,
    "name": "Shia Ithna-Ashari, Leva Institute, Qum",
    "params": {"Fajr": 16, "Isha": 14, "Maghrib": 4, "Midnight": "JAFARI"},
    "location": {"latitude": 34.6415764, "longitude": 50.8746035},
  },
  {
    "id": 1,
    "name": "University of Islamic Sciences, Karachi",
    "params": {"Fajr": 18, "Isha": 18},
    "location": {"latitude": 24.8614622, "longitude": 67.0099388},
  },
  {
    "id": 2,
    "name": "Islamic Society of North America (ISNA)",
    "params": {"Fajr": 15, "Isha": 15},
    "location": {
      "latitude": 39.70421229999999,
      "longitude": -86.39943869999999,
    },
  },
  {
    "id": 3,
    "name": "Muslim World League",
    "params": {"Fajr": 18, "Isha": 17},
    "location": {"latitude": 51.5194682, "longitude": -0.1360365},
  },
  {
    "id": 4,
    "name": "Umm Al-Qura University, Makkah",
    "params": {"Fajr": 18.5, "Isha": "90 min"},
    "location": {"latitude": 21.3890824, "longitude": 39.8579118},
  },
  {
    "id": 5,
    "name": "Egyptian General Authority of Survey",
    "params": {"Fajr": 19.5, "Isha": 17.5},
    "location": {"latitude": 30.0444196, "longitude": 31.2357116},
  },

  {
    "id": 7,
    "name": "Institute of Geophysics, University of Tehran",
    "params": {"Fajr": 17.7, "Isha": 14, "Maghrib": 4.5, "Midnight": "JAFARI"},
    "location": {"latitude": 35.6891975, "longitude": 51.3889736},
  },

  {
    "id": 8,
    "name": "Gulf Region",
    "params": {"Fajr": 19.5, "Isha": "90 min"},
    "location": {"latitude": 24.1323638, "longitude": 53.3199527},
  },
  {
    "id": 9,
    "name": "Kuwait",
    "params": {"Fajr": 18, "Isha": 17.5},
    "location": {"latitude": 29.375859, "longitude": 47.9774052},
  },
  {
    "id": 10,
    "name": "Qatar",
    "params": {"Fajr": 18, "Isha": "90 min"},
    "location": {"latitude": 25.2854473, "longitude": 51.5310398},
  },
  {
    "id": 11,
    "name": "Majlis Ugama Islam Singapura, Singapore",
    "params": {"Fajr": 20, "Isha": 18},
    "location": {"latitude": 1.352083, "longitude": 103.819836},
  },
  {
    "id": 12,
    "name": "Union Organization Islamic de France",
    "params": {"Fajr": 12, "Isha": 12},
    "location": {"latitude": 48.856614, "longitude": 2.3522219},
  },
  {
    "id": 13,
    "name":
        "Diyanet \u0130\u015fleri Ba\u015fkanl\u0131\u011f\u0131, Turkey (experimental)",
    "params": {"Fajr": 18, "Isha": 17},
    "location": {"latitude": 39.9333635, "longitude": 32.8597419},
  },
  {
    "id": 14,
    "name": "Spiritual Administration of Muslims of Russia",
    "params": {"Fajr": 16, "Isha": 15},
    "location": {"latitude": 54.73479099999999, "longitude": 55.9578555},
  },
  {
    "id": 15,
    "name": "Moonsighting Committee Worldwide (Moonsighting.com)",
    "params": {"shafaq": "general"},
  },
  {
    "id": 16,
    "name": "Dubai (experimental)",
    "params": {"Fajr": 18.2, "Isha": 18.2},
    "location": {"latitude": 25.0762677, "longitude": 55.087404},
  },
  {
    "id": 17,
    "name": "Jabatan Kemajuan Islam Malaysia (JAKIM)",
    "params": {"Fajr": 20, "Isha": 18},
    "location": {"latitude": 3.139003, "longitude": 101.686855},
  },
  {
    "id": 18,
    "name": "Tunisia",
    "params": {"Fajr": 18, "Isha": 18},
    "location": {"latitude": 36.8064948, "longitude": 10.1815316},
  },
  {
    "id": 19,
    "name": "Algeria",
    "params": {"Fajr": 18, "Isha": 17},
    "location": {"latitude": 36.753768, "longitude": 3.0587561},
  },
  {
    "id": 20,
    "name": "Kementerian Agama Republik Indonesia",
    "params": {"Fajr": 20, "Isha": 18},
    "location": {"latitude": -6.2087634, "longitude": 106.845599},
  },
  {
    "id": 21,
    "name": "Morocco",
    "params": {"Fajr": 19, "Isha": 17},
    "location": {"latitude": 33.9715904, "longitude": -6.8498129},
  },
  {
    "id": 22,
    "name": "Comunidade Islamica de Lisboa",
    "params": {"Fajr": 18, "Maghrib": "3 min", "Isha": "77 min"},
    "location": {"latitude": 38.7222524, "longitude": -9.1393366},
  },
  {
    "id": 23,
    "name": "Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan",
    "params": {"Fajr": 18, "Maghrib": "5 min", "Isha": 18},
    "location": {"latitude": 31.9461222, "longitude": 35.923844},
  },
];
