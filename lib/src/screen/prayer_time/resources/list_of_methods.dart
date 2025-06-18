import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";

List<CalculationMethod> prayerTimeCalculationMethodModelList =
    prayerTimeCalculationMethodList
        .map((e) => CalculationMethod.fromMap(e))
        .toList();

List prayerTimeCalculationMethodList = [
  {
    "id": 0,
    "name": "Shia Ithna-Ashari, Leva Institute, Qum",
    "params": {
      "Fajr": "16 degree",
      "Isha": "14 degree",
      "Maghrib": "4 degree",
      "Midnight": "JAFARI",
    },
    "location": {"latitude": 34.6415764, "longitude": 50.8746035},
  },
  {
    "id": 1,
    "name": "University of Islamic Sciences, Karachi",
    "params": {"Fajr": "18 degree", "Isha": "18 degree"},
    "location": {"latitude": 24.8614622, "longitude": 67.0099388},
  },
  {
    "id": 2,
    "name": "Islamic Society of North America (ISNA)",
    "params": {"Fajr": "15 degree", "Isha": "15 degree"},
    "location": {
      "latitude": 39.70421229999999,
      "longitude": -86.39943869999999,
    },
  },
  {
    "id": 3,
    "name": "Muslim World League",
    "params": {"Fajr": "18 degree", "Isha": "17 degree"},
    "location": {"latitude": 51.5194682, "longitude": -0.1360365},
  },
  {
    "id": 4,
    "name": "Umm Al-Qura University, Makkah",
    "params": {"Fajr": "18.5 degree", "Isha": "9 0 min"},
    "location": {"latitude": 21.3890824, "longitude": 39.8579118},
  },
  {
    "id": 5,
    "name": "Egyptian General Authority of Survey",
    "params": {"Fajr": "19.5 degree", "Isha": "17.5 degree"},
    "location": {"latitude": 30.0444196, "longitude": 31.2357116},
  },

  {
    "id": 7,
    "name": "Institute of Geophysics, University of Tehran",
    "params": {
      "Fajr": "17.7 degree",
      "Isha": "14 degree",
      "Maghrib": "4.5 degree",
      "Midnight": "JAFARI",
    },
    "location": {"latitude": 35.6891975, "longitude": 51.3889736},
  },

  {
    "id": 8,
    "name": "Gulf Region",
    "params": {"Fajr": "19.5 degree", "Isha": "90 min"},
    "location": {"latitude": 24.1323638, "longitude": 53.3199527},
  },
  {
    "id": 9,
    "name": "Kuwait",
    "params": {"Fajr": "18 degree", "Isha": "17.5 degree"},
    "location": {"latitude": 29.375859, "longitude": 47.9774052},
  },
  {
    "id": 10,
    "name": "Qatar",
    "params": {"Fajr": "18 degree", "Isha": "90 min"},
    "location": {"latitude": 25.2854473, "longitude": 51.5310398},
  },
  {
    "id": 11,
    "name": "Majlis Ugama Islam Singapura, Singapore",
    "params": {"Fajr": "20 degree", "Isha": "18 degree"},
    "location": {"latitude": 1.352083, "longitude": 103.819836},
  },
  {
    "id": 12,
    "name": "Union Organization Islamic de France",
    "params": {"Fajr": "12 degree", "Isha": "12 degree"},
    "location": {"latitude": 48.856614, "longitude": 2.3522219},
  },
  {
    "id": 13,
    "name":
        "Diyanet \u0130\u015fleri Ba\u015fkanl\u0131\u011f\u0131, Turkey (experimental)",
    "params": {"Fajr": "18 degree", "Isha": "17 degree"},
    "location": {"latitude": 39.9333635, "longitude": 32.8597419},
  },
  {
    "id": 14,
    "name": "Spiritual Administration of Muslims of Russia",
    "params": {"Fajr": "16 degree", "Isha": "15 degree"},
    "location": {"latitude": 54.73479099999999, "longitude": 55.9578555},
  },
  {"id": 15, "name": "Moonsighting Committee Worldwide (Moonsighting.com)"},
  {
    "id": 16,
    "name": "Dubai (experimental)",
    "params": {"Fajr": "18.2 degree", "Isha": "18.2 degree"},
    "location": {"latitude": 25.0762677, "longitude": 55.087404},
  },
  {
    "id": 17,
    "name": "Jabatan Kemajuan Islam Malaysia (JAKIM)",
    "params": {"Fajr": "20 degree", "Isha": "18 degree"},
    "location": {"latitude": 3.139003, "longitude": 101.686855},
  },
  {
    "id": 18,
    "name": "Tunisia",
    "params": {"Fajr": "18 degree", "Isha": "18 degree"},
    "location": {"latitude": 36.8064948, "longitude": 10.1815316},
  },
  {
    "id": 19,
    "name": "Algeria",
    "params": {"Fajr": "18 degree", "Isha": "17 degree"},
    "location": {"latitude": 36.753768, "longitude": 3.0587561},
  },
  {
    "id": 20,
    "name": "Kementerian Agama Republik Indonesia",
    "params": {"Fajr": "20 degree", "Isha": "18 degree"},
    "location": {"latitude": -6.2087634, "longitude": 106.845599},
  },
  {
    "id": 21,
    "name": "Morocco",
    "params": {"Fajr": "19 degree", "Isha": "17 degree"},
    "location": {"latitude": 33.9715904, "longitude": -6.8498129},
  },
  {
    "id": 22,
    "name": "Comunidade Islamica de Lisboa",
    "params": {"Fajr": "18 degree", "Maghrib": "3 min", "Isha": "77 min"},
    "location": {"latitude": 38.7222524, "longitude": -9.1393366},
  },
  {
    "id": 23,
    "name": "Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan",
    "params": {"Fajr": "18 degree", "Maghrib": "5 min", "Isha": "18 degree"},
    "location": {"latitude": 31.9461222, "longitude": 35.923844},
  },
];
