import 'package:adhan_dart/adhan_dart.dart';

/// Enum holding all the available methods
enum CalculationMethodEnum {
  muslimWorldLeague,
  northAmerica,
  egyptian,
  karachi,
  ummAlQura,
  moonsightingCommittee,
  dubai,
  turkiye,
  qatar,
  kuwait,
  singapore,
  indonesia,
  malaysia,
  tehran,
  shia,
  gulf,
  france,
  russia,
  tunisia,
  algeria,
  morocco,
  portugal,
  jordan,
  other,
}

/// Class holding the calculation parameters for each method
class CalculationMethodParameters {
  static CalculationParameters fromEnum(CalculationMethodEnum method) {
    switch (method) {
      case CalculationMethodEnum.muslimWorldLeague:
        return CalculationMethodParameters.muslimWorldLeague();
      case CalculationMethodEnum.northAmerica:
        return CalculationMethodParameters.northAmerica();
      case CalculationMethodEnum.egyptian:
        return CalculationMethodParameters.egyptian();
      case CalculationMethodEnum.karachi:
        return CalculationMethodParameters.karachi();
      case CalculationMethodEnum.ummAlQura:
        return CalculationMethodParameters.ummAlQura();
      case CalculationMethodEnum.moonsightingCommittee:
        return CalculationMethodParameters.moonsightingCommittee();
      case CalculationMethodEnum.dubai:
        return CalculationMethodParameters.dubai();
      case CalculationMethodEnum.turkiye:
        return CalculationMethodParameters.turkiye();
      case CalculationMethodEnum.qatar:
        return CalculationMethodParameters.qatar();
      case CalculationMethodEnum.kuwait:
        return CalculationMethodParameters.kuwait();
      case CalculationMethodEnum.singapore:
        return CalculationMethodParameters.singapore();
      case CalculationMethodEnum.indonesia:
        return CalculationMethodParameters.indonesia();
      case CalculationMethodEnum.malaysia:
        return CalculationMethodParameters.malaysia();
      case CalculationMethodEnum.tehran:
        return CalculationMethodParameters.tehran();
      case CalculationMethodEnum.shia:
        return CalculationMethodParameters.shia();
      case CalculationMethodEnum.gulf:
        return CalculationMethodParameters.gulf();
      case CalculationMethodEnum.france:
        return CalculationMethodParameters.france();
      case CalculationMethodEnum.russia:
        return CalculationMethodParameters.russia();
      case CalculationMethodEnum.tunisia:
        return CalculationMethodParameters.tunisia();
      case CalculationMethodEnum.algeria:
        return CalculationMethodParameters.algeria();
      case CalculationMethodEnum.morocco:
        return CalculationMethodParameters.morocco();
      case CalculationMethodEnum.portugal:
        return CalculationMethodParameters.portugal();
      case CalculationMethodEnum.jordan:
        return CalculationMethodParameters.jordan();
      case CalculationMethodEnum.other:
        return CalculationMethodParameters.other();
    }
  }

  /// Dubai
  ///
  /// Settings:
  /// - Fajr Angle: 18.2°
  /// - Isha Angle: 18.2°
  /// - Method Adjustments: Sunrise -3min, Dhuhr +3min, Asr +3min, Maghrib +3min
  static CalculationParameters dubai() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.dubai,
        fajrAngle: 18.2,
        ishaAngle: 18.2,
        fullName: 'Dubai (experimental)',
        location: const Coordinates(25.0762677, 55.087404));
    params.methodAdjustments = {
      Prayer.sunrise: -3,
      Prayer.dhuhr: 3,
      Prayer.asr: 3,
      Prayer.maghrib: 3
    };
    return params;
  }

  /// Egyptian General Authority of Survey
  ///
  /// Settings:
  /// - Fajr Angle: 19.5°
  /// - Isha Angle: 17.5°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters egyptian() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.egyptian,
        fajrAngle: 19.5,
        ishaAngle: 17.5,
        fullName: 'Egyptian General Authority of Survey',
        location: const Coordinates(30.0444196, 31.2357116));
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// University of Islamic Sciences, Karachi
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters karachi() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.karachi,
        fajrAngle: 18,
        ishaAngle: 18,
        fullName: 'University of Islamic Sciences, Karachi',
        location: const Coordinates(24.8614622, 67.0099388));
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Kuwait
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17.5°
  static CalculationParameters kuwait() {
    return CalculationParameters(
        method: CalculationMethodEnum.kuwait,
        fajrAngle: 18,
        ishaAngle: 17.5,
        fullName: 'Kuwait',
        location: const Coordinates(29.375859, 47.9774052));
  }

  /// Moonsighting Committee
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +5min, Maghrib +3min
  static CalculationParameters moonsightingCommittee() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.moonsightingCommittee,
        fajrAngle: 18,
        ishaAngle: 18,
        fullName: 'Moonsighting Committee Worldwide (Moonsighting.com)');
    params.methodAdjustments = {Prayer.dhuhr: 5, Prayer.maghrib: 3};
    return params;
  }

  /// Morocco
  ///
  /// Settings:
  /// - Fajr Angle: 19°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Sunrise -3min, Dhuhr +5min, Maghrib +5min
  static CalculationParameters morocco() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.morocco,
        fajrAngle: 19,
        ishaAngle: 17,
        fullName: 'Morocco',
        location: const Coordinates(33.9715904, -6.8498129));
    params.methodAdjustments = {
      Prayer.sunrise: -3,
      Prayer.dhuhr: 5,
      Prayer.maghrib: 5
    };
    return params;
  }

  /// Muslim World League
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters muslimWorldLeague() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.muslimWorldLeague,
        fajrAngle: 18,
        ishaAngle: 17,
        fullName: 'Muslim World League',
        location: const Coordinates(51.5194682, -0.1360365));
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// North America (ISNA)
  ///
  /// Settings:
  /// - Fajr Angle: 15°
  /// - Isha Angle: 15°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters northAmerica() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.northAmerica,
        fajrAngle: 15,
        ishaAngle: 15,
        fullName: 'Islamic Society of North America (ISNA)',
        location: const Coordinates(39.70421229999999, -86.39943869999999));
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Other (Custom)
  ///
  /// Settings:
  /// - Fajr Angle: 0°
  /// - Isha Angle: 0°
  static CalculationParameters other() {
    return CalculationParameters(
        method: CalculationMethodEnum.other,
        fajrAngle: 0,
        ishaAngle: 0,
        fullName: 'Other');
  }

  /// Qatar
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Interval: 90 minutes after Maghrib
  static CalculationParameters qatar() {
    return CalculationParameters(
        method: CalculationMethodEnum.qatar,
        fajrAngle: 18,
        ishaAngle: 0,
        ishaInterval: 90,
        fullName: 'Qatar',
        location: const Coordinates(25.2854473, 51.5310398));
  }

  /// Singapore
  ///
  /// Settings:
  /// - Fajr Angle: 20°
  /// - Isha Angle: 18°
  /// - Method Adjustments: Dhuhr +1min
  static CalculationParameters singapore() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.singapore,
        fajrAngle: 20,
        ishaAngle: 18,
        fullName: 'Majlis Ugama Islam Singapura, Singapore',
        location: const Coordinates(1.352083, 103.819836));
    params.methodAdjustments = {Prayer.dhuhr: 1};
    return params;
  }

  /// Tehran
  ///
  /// Settings:
  /// - Fajr Angle: 17.7°
  /// - Isha Angle: 14°
  /// - Maghrib Angle: 4.5°
  /// - Isha Interval: 0 (not used)
  static CalculationParameters tehran() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.tehran,
        fajrAngle: 17.7,
        ishaAngle: 14,
        ishaInterval: 0,
        maghribAngle: 4.5,
        fullName: 'Institute of Geophysics, University of Tehran',
        location: const Coordinates(35.6891975, 51.3889736));
    return params;
  }

  /// Turkey (Diyanet)
  ///
  /// Settings:
  /// - Fajr Angle: 18°
  /// - Isha Angle: 17°
  /// - Method Adjustments: Sunrise -7min, Dhuhr +5min, Asr +4min, Maghrib +7min
  static CalculationParameters turkiye() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.turkiye,
        fajrAngle: 18,
        ishaAngle: 17,
        fullName: 'Diyanet İşleri Başkanlığı, Turkey (experimental)',
        location: const Coordinates(39.9333635, 32.8597419));
    params.methodAdjustments = {
      Prayer.sunrise: -7,
      Prayer.dhuhr: 5,
      Prayer.asr: 4,
      Prayer.maghrib: 7
    };
    return params;
  }

  /// Umm al-Qura University, Makkah
  ///
  /// Settings:
  /// - Fajr Angle: 18.5°
  /// - Isha Interval: 90 minutes after Maghrib
  ///
  /// Note: Add +30 minute custom adjustment for Isha during Ramadan
  static CalculationParameters ummAlQura() {
    return CalculationParameters(
        method: CalculationMethodEnum.ummAlQura,
        fajrAngle: 18.5,
        ishaAngle: 0,
        ishaInterval: 90,
        fullName: 'Umm Al-Qura University, Makkah',
        location: const Coordinates(21.3890824, 39.8579118));
  }

  /// Shia Ithna-Ashari, Leva Institute, Qum
  static CalculationParameters shia() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.shia,
        fajrAngle: 16,
        ishaAngle: 14,
        maghribAngle: 4,
        fullName: 'Shia Ithna-Ashari, Leva Institute, Qum',
        location: const Coordinates(34.6415764, 50.8746035));
    // Midnight: JAFARI - need to see how to implement this if necessary
    return params;
  }

  /// Gulf Region
  static CalculationParameters gulf() {
    return CalculationParameters(
        method: CalculationMethodEnum.gulf,
        fajrAngle: 19.5,
        ishaAngle: 0,
        ishaInterval: 90,
        fullName: 'Gulf Region',
        location: const Coordinates(24.1323638, 53.3199527));
  }

  /// Union Organization Islamic de France
  static CalculationParameters france() {
    return CalculationParameters(
        method: CalculationMethodEnum.france,
        fajrAngle: 12,
        ishaAngle: 12,
        fullName: 'Union Organization Islamic de France',
        location: const Coordinates(48.856614, 2.3522219));
  }

  /// Spiritual Administration of Muslims of Russia
  static CalculationParameters russia() {
    return CalculationParameters(
        method: CalculationMethodEnum.russia,
        fajrAngle: 16,
        ishaAngle: 15,
        fullName: 'Spiritual Administration of Muslims of Russia',
        location: const Coordinates(54.73479099999999, 55.9578555));
  }

  /// Jabatan Kemajuan Islam Malaysia (JAKIM)
  static CalculationParameters malaysia() {
    return CalculationParameters(
        method: CalculationMethodEnum.malaysia,
        fajrAngle: 20,
        ishaAngle: 18,
        fullName: 'Jabatan Kemajuan Islam Malaysia (JAKIM)',
        location: const Coordinates(3.139003, 101.686855));
  }

  /// Tunisia
  static CalculationParameters tunisia() {
    return CalculationParameters(
        method: CalculationMethodEnum.tunisia,
        fajrAngle: 18,
        ishaAngle: 18,
        fullName: 'Tunisia',
        location: const Coordinates(36.8064948, 10.1815316));
  }

  /// Algeria
  static CalculationParameters algeria() {
    return CalculationParameters(
        method: CalculationMethodEnum.algeria,
        fajrAngle: 18,
        ishaAngle: 17,
        fullName: 'Algeria',
        location: const Coordinates(36.753768, 3.0587561));
  }

  /// Kementerian Agama Republik Indonesia
  static CalculationParameters indonesia() {
    return CalculationParameters(
        method: CalculationMethodEnum.indonesia,
        fajrAngle: 20,
        ishaAngle: 18,
        fullName: 'Kementerian Agama Republik Indonesia',
        location: const Coordinates(-6.2087634, 106.845599));
  }

  /// Comunidade Islamica de Lisboa
  static CalculationParameters portugal() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.portugal,
        fajrAngle: 18,
        ishaAngle: 0,
        ishaInterval: 77,
        fullName: 'Comunidade Islamica de Lisboa',
        location: const Coordinates(38.7222524, -9.1393366));
    params.methodAdjustments = {Prayer.maghrib: 3};
    return params;
  }

  /// Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan
  static CalculationParameters jordan() {
    CalculationParameters params = CalculationParameters(
        method: CalculationMethodEnum.jordan,
        fajrAngle: 18,
        ishaAngle: 18,
        fullName: 'Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan',
        location: const Coordinates(31.9461222, 35.923844));
    params.methodAdjustments = {Prayer.maghrib: 5};
    return params;
  }
}
