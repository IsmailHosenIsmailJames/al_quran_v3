import 'package:adhan_dart/adhan_dart.dart';
import 'package:adhan_dart/src/Astronomical.dart';
import 'package:adhan_dart/src/DateUtils.dart';
import 'package:adhan_dart/src/SolarTime.dart';
import 'package:adhan_dart/src/TimeComponents.dart';

/// Prayer times calculation for a given date, location, and calculation method.
///
/// Contains all five daily prayer times plus sunrise, and additional times for
/// previous day's Isha and next day's Fajr for convenience.
class PrayerTimes {
  DateTime date = DateTime.now();
  Coordinates coordinates = const Coordinates(0, 0);
  CalculationParameters calculationParameters =
      CalculationMethodParameters.muslimWorldLeague();

  /// Fajr prayer time
  late DateTime fajr;

  /// Sunrise time
  late DateTime sunrise;

  /// Dhuha time
  late DateTime dhuha;

  /// Noon Time // forbidden time for prayer
  late DateTime noon;

  /// Dhuhr prayer time
  late DateTime dhuhr;

  /// Asr prayer time
  late DateTime asr;

  /// Sunset Start time // forbidden time for prayer
  late DateTime sunset;

  /// Maghrib prayer time
  late DateTime maghrib;

  /// Isha prayer time
  late DateTime isha;

  /// Tahajjud time (tonight into tomorrow morning)
  late DateTime tahajjud;

  /// Previous day's Isha prayer time
  late DateTime ishaBefore;

  /// Previous day's Tahajjud time (early morning today before Fajr)
  late DateTime tahajjudBefore;

  /// Next day's Fajr prayer time
  late DateTime fajrAfter;

  /// Creates prayer times for the given date, coordinates, and calculation parameters.
  ///
  /// [date] - Date for which to calculate prayer times
  /// [coordinates] - Geographic coordinates (latitude, longitude)
  /// [calculationParameters] - Calculation method and adjustments
  /// [precision] - If true, returns times with second precision; if false, rounds to nearest minute
  PrayerTimes({
    required DateTime date,
    required Coordinates coordinates,
    required CalculationParameters calculationParameters,
    bool precision = false,
  }) {
    this.date = date;
    this.coordinates = coordinates;
    this.calculationParameters = calculationParameters;

    DateTime dateBefore = date.subtract(const Duration(days: 1));
    DateTime dateAfter = date.add(const Duration(days: 1));
    SolarTime solarTime = SolarTime(date, coordinates);
    SolarTime solarTimeBefore = SolarTime(dateBefore, coordinates);
    SolarTime solarTimeAfter = SolarTime(dateAfter, coordinates);

    DateTime fajrTime;
    DateTime asrTime;
    DateTime maghribTime;
    DateTime ishaTime;
    DateTime ishabeforeTime;
    DateTime fajrafterTime;

    double? nightFraction;

    DateTime dhuhrTime = TimeComponents(solarTime.transit)
        .utcDate(date.year, date.month, date.day);
    DateTime sunriseTime = TimeComponents(solarTime.sunrise)
        .utcDate(date.year, date.month, date.day);
    DateTime sunsetTime = TimeComponents(solarTime.sunset)
        .utcDate(date.year, date.month, date.day);

    DateTime sunriseafterTime = TimeComponents(solarTimeAfter.sunrise)
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);
    DateTime sunsetbeforeTime = TimeComponents(solarTimeBefore.sunset)
        .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);

    asrTime = TimeComponents(solarTime.afternoon(
            shadowLength(calculationParameters.madhab ?? Madhab.shafi)
                .toDouble()))
        .utcDate(date.year, date.month, date.day);

    DateTime tomorrow = dateByAddingDays(date, 1);
    var tomorrowSolarTime = SolarTime(tomorrow, coordinates);
    DateTime tomorrowSunrise = TimeComponents(tomorrowSolarTime.sunrise)
        .utcDate(tomorrow.year, tomorrow.month, tomorrow.day);
    int night = (tomorrowSunrise.difference(sunsetTime)).inSeconds;

    fajrTime = TimeComponents(
            solarTime.hourAngle(-1 * calculationParameters.fajrAngle, false))
        .utcDate(date.year, date.month, date.day);

    fajrafterTime = TimeComponents(solarTimeAfter.hourAngle(
            -1 * calculationParameters.fajrAngle, false))
        .utcDate(dateAfter.year, dateAfter.month, dateAfter.day);

    // special case for moonsighting committee above latitude 55
    if (calculationParameters.method ==
            CalculationMethodEnum.moonsightingCommittee &&
        coordinates.latitude >= 55) {
      nightFraction = night / 7;
      fajrTime = dateByAddingSeconds(sunriseTime, -nightFraction.round());
      fajrafterTime =
          dateByAddingSeconds(sunriseafterTime, -nightFraction.round());
    }

    DateTime safeFajr() {
      if (calculationParameters.method ==
          CalculationMethodEnum.moonsightingCommittee) {
        return Astronomical.seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear(date), date.year, sunriseTime);
      } else {
        var portion = calculationParameters.nightPortions()[Prayer.fajr]!;
        nightFraction = portion * night;
        return dateByAddingSeconds(sunriseTime, -nightFraction!.round());
      }
    }

    if (fajrTime.millisecondsSinceEpoch.isNaN || safeFajr().isAfter(fajrTime)) {
      fajrTime = safeFajr();
    }

    if (fajrafterTime.millisecondsSinceEpoch.isNaN ||
        safeFajr().isAfter(fajrafterTime)) {
      fajrafterTime = safeFajr();
    }

    if (calculationParameters.ishaInterval != null &&
        calculationParameters.ishaInterval! > 0) {
      ishaTime =
          dateByAddingMinutes(sunsetTime, calculationParameters.ishaInterval!);
      ishabeforeTime = dateByAddingMinutes(
          sunsetbeforeTime, calculationParameters.ishaInterval!);
    } else {
      ishaTime = TimeComponents(
              solarTime.hourAngle(-1 * calculationParameters.ishaAngle, true))
          .utcDate(date.year, date.month, date.day);
      ishabeforeTime = TimeComponents(solarTimeBefore.hourAngle(
              -1 * calculationParameters.ishaAngle, true))
          .utcDate(dateBefore.year, dateBefore.month, dateBefore.day);
      // special case for moonsighting committee above latitude 55
      if (calculationParameters.method ==
              CalculationMethodEnum.moonsightingCommittee &&
          coordinates.latitude >= 55) {
        nightFraction = night / 7;
        ishaTime = dateByAddingSeconds(sunsetTime, nightFraction!.round());
        ishabeforeTime =
            dateByAddingSeconds(sunsetbeforeTime, nightFraction!.round());
      }

      DateTime safeIsha() {
        if (calculationParameters.method ==
            CalculationMethodEnum.moonsightingCommittee) {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          double portion = calculationParameters.nightPortions()[Prayer.isha]!;
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      DateTime safeIshaBefore() {
        if (calculationParameters.method ==
            CalculationMethodEnum.moonsightingCommittee) {
          return Astronomical.seasonAdjustedEveningTwilight(
              coordinates.latitude, dayOfYear(date), date.year, sunsetTime);
        } else {
          var portion = calculationParameters.nightPortions()[Prayer.isha]!;
          nightFraction = portion * night;
          return dateByAddingSeconds(sunsetTime, nightFraction!.round());
        }
      }

      if (ishaTime.millisecondsSinceEpoch.isNaN ||
          safeIsha().isBefore(ishaTime)) {
        ishaTime = safeIsha();
      }

      if (ishabeforeTime.millisecondsSinceEpoch.isNaN ||
          safeIshaBefore().isBefore(ishabeforeTime)) {
        ishabeforeTime = safeIshaBefore();
      }
    }

    maghribTime = sunsetTime;
    if (calculationParameters.maghribAngle != null) {
      DateTime angleBasedMaghrib = TimeComponents(solarTime.hourAngle(
              -1 * calculationParameters.maghribAngle!, true))
          .utcDate(date.year, date.month, date.day);
      if (sunsetTime.isBefore(angleBasedMaghrib) &&
          ishaTime.isAfter(angleBasedMaghrib)) {
        maghribTime = angleBasedMaghrib;
      }
    }

    int fajrAdjustment = (calculationParameters.adjustments[Prayer.fajr] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.fajr] ?? 0);
    int sunriseAdjustment =
        (calculationParameters.adjustments[Prayer.sunrise] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.sunrise] ?? 0);
    int dhuhrAdjustment =
        (calculationParameters.adjustments[Prayer.dhuhr] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.dhuhr] ?? 0);
    int asrAdjustment = (calculationParameters.adjustments[Prayer.asr] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.asr] ?? 0);
    int maghribAdjustment =
        (calculationParameters.adjustments[Prayer.maghrib] ?? 0) +
            (calculationParameters.methodAdjustments[Prayer.maghrib] ?? 0);
    int ishaAdjustment = (calculationParameters.adjustments[Prayer.isha] ?? 0) +
        (calculationParameters.methodAdjustments[Prayer.isha] ?? 0);

    fajr = roundedMinute(dateByAddingMinutes(fajrTime, fajrAdjustment),
        precision: precision);
    sunrise = roundedMinute(dateByAddingMinutes(sunriseTime, sunriseAdjustment),
        precision: precision);
    dhuha =
        roundedMinute(sunrise.add(Duration(minutes: 15)), precision: precision);
    dhuhr = roundedMinute(dateByAddingMinutes(dhuhrTime, dhuhrAdjustment),
        precision: precision);
    asr = roundedMinute(dateByAddingMinutes(asrTime, asrAdjustment),
        precision: precision);
    maghrib = roundedMinute(dateByAddingMinutes(maghribTime, maghribAdjustment),
        precision: precision);
    sunset = maghrib.subtract(Duration(minutes: 15));
    isha = roundedMinute(dateByAddingMinutes(ishaTime, ishaAdjustment),
        precision: precision);

    fajrAfter = roundedMinute(
        dateByAddingMinutes(fajrafterTime, fajrAdjustment),
        precision: precision);
    ishaBefore = roundedMinute(
        dateByAddingMinutes(ishabeforeTime, ishaAdjustment),
        precision: precision);

    noon = dhuhr.subtract(Duration(minutes: 8));

    // Calculate Tahajjud for tonight into tomorrow morning (last third of the night)
    Duration nightTimeDuration = fajrAfter.difference(maghrib);
    tahajjud = roundedMinute(
      dateByAddingSeconds(
        maghrib,
        (nightTimeDuration.inSeconds * (2 / 3)).floor(),
      ),
      precision: precision,
    );

    // Calculate Tahajjud for last night into early morning today (before Fajr)
    DateTime maghribBefore = sunsetbeforeTime;
    Duration nightTimeBefore = fajr.difference(maghribBefore);
    tahajjudBefore = roundedMinute(
      dateByAddingSeconds(
        maghribBefore,
        (nightTimeBefore.inSeconds * (2 / 3)).floor(),
      ),
      precision: precision,
    );
  }

  /// Returns the current prayer for the given date/time.
  ///
  /// [date] - Date/time to check against prayer times
  Prayer? currentPrayer({required DateTime date}) {
    Prayer? prayer = isInsideForbiddenTime(date);
    if (prayer != null) {
      return prayer;
    }

    // 1. Early morning (Midnight to Fajr)
    if (date.isBefore(tahajjudBefore)) {
      return Prayer.isha;
    } else if (date.isBefore(fajr)) {
      return Prayer.tahajjud;
    }

    // 2. Daytime
    else if (date.isBefore(noon)) {
      return date.isBefore(sunrise) ? Prayer.fajr : Prayer.dhuha;
    } else if (date.isBefore(dhuhr)) {
      return Prayer.noon;
    } else if (date.isBefore(asr)) {
      return Prayer.dhuhr;
    } else if (date.isBefore(sunset)) {
      return Prayer.asr;
    } else if (date.isBefore(maghrib)) {
      return Prayer.sunset;
    } else if (date.isBefore(isha)) {
      return Prayer.maghrib;
    }

    // 3. Late Night (after Isha into tomorrow morning)
    else if (date.isBefore(tahajjud)) {
      return Prayer.isha;
    } else if (date.isBefore(fajrAfter)) {
      return Prayer.tahajjud;
    } else {
      return Prayer.fajr;
    }
  }

  Prayer? isInsideForbiddenTime(DateTime date) {
    // sunrise forbidden time (Sunrise until +15 minutes)
    DateTime sunriseForbiddenStart = sunrise;
    DateTime sunriseForbiddenEnd = sunrise.add(Duration(minutes: 15));
    if (date.isAfter(sunriseForbiddenStart) &&
        date.isBefore(sunriseForbiddenEnd)) {
      return Prayer.sunrise;
    }

    // noon forbidden time (Zawal / Midday: Dhuhr - 8 minutes until Dhuhr)
    DateTime noonForbiddenStart = noon;
    DateTime noonForbiddenEnd = dhuhr;
    if (date.isAfter(noonForbiddenStart) && date.isBefore(noonForbiddenEnd)) {
      return Prayer.noon;
    }

    // sunset forbidden time (Maghrib - 15 minutes until Maghrib)
    DateTime sunsetForbiddenStart = sunset;
    DateTime sunsetForbiddenEnd = maghrib;
    if (date.isAfter(sunsetForbiddenStart) &&
        date.isBefore(sunsetForbiddenEnd)) {
      return Prayer.sunset;
    }
    return null;
  }

  /// Returns the Duration until the next upcoming prayer.
  Duration? timeUntilNextPrayer({required DateTime now}) {
    Prayer? next = nextPrayer(date: now);
    if (next == null) return null;
    DateTime? nextTime = timeForPrayer(next, date: now);
    if (nextTime == null) return null;
    Duration difference = nextTime.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }

  /// Returns the percentage of time elapsed / left in the current prayer window.
  double? percentageOfTimeLeftUntilNextPrayer({required DateTime now}) {
    Prayer? current = currentPrayer(date: now);
    Prayer? next = nextPrayer(date: now);
    if (current == null || next == null) return null;

    DateTime? currentPrayerTime = timeForPrayer(current, date: now);
    DateTime? nextPrayerTime = timeForPrayer(next, date: now);
    if (currentPrayerTime == null || nextPrayerTime == null) return null;

    Duration totalTimeInBetween = nextPrayerTime.difference(currentPrayerTime);
    Duration timeLeft = nextPrayerTime.difference(now);
    if (totalTimeInBetween.inMilliseconds <= 0) return 0.0;
    return (timeLeft.inMilliseconds / totalTimeInBetween.inMilliseconds)
        .clamp(0.0, 1.0);
  }

  /// Returns the next upcoming prayer.
  ///
  /// [date] - Optional date/time to check against. Defaults to DateTime.now()
  Prayer? nextPrayer({DateTime? date}) {
    date ??= DateTime.now();

    if (date.isBefore(tahajjudBefore)) {
      return Prayer.tahajjud;
    } else if (date.isBefore(fajr)) {
      return Prayer.fajr;
    } else if (date.isBefore(sunrise)) {
      return Prayer.sunrise;
    } else if (date.isBefore(noon)) {
      return Prayer.noon;
    } else if (date.isBefore(dhuhr)) {
      return Prayer.dhuhr;
    } else if (date.isBefore(asr)) {
      return Prayer.asr;
    } else if (date.isBefore(sunset)) {
      return Prayer.sunset;
    } else if (date.isBefore(maghrib)) {
      return Prayer.maghrib;
    } else if (date.isBefore(isha)) {
      return Prayer.isha;
    } else if (date.isBefore(tahajjud)) {
      return Prayer.tahajjud;
    } else if (date.isBefore(fajrAfter)) {
      return Prayer.fajr;
    } else {
      return Prayer.sunrise;
    }
  }

  /// Returns the DateTime for the specified prayer.
  /// If [date] is supplied, calculates accurately for early morning or late night.
  DateTime? timeForPrayer(Prayer prayer, {DateTime? date}) {
    final effectiveDate = date ?? this.date;
    final bool isEarlyMorning = effectiveDate.isBefore(fajr);
    final bool isAfterIsha = effectiveDate.isAfter(isha);

    switch (prayer) {
      case Prayer.fajr:
        return isAfterIsha ? fajrAfter : fajr;
      case Prayer.sunrise:
        return sunrise;
      case Prayer.dhuha:
        return dhuha;
      case Prayer.noon:
        return noon;
      case Prayer.dhuhr:
        return dhuhr;
      case Prayer.asr:
        return asr;
      case Prayer.sunset:
        return sunset;
      case Prayer.maghrib:
        return maghrib;
      case Prayer.isha:
        return isEarlyMorning ? ishaBefore : isha;
      case Prayer.tahajjud:
        return isEarlyMorning ? tahajjudBefore : tahajjud;
    }
  }
}
