import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:flutter/material.dart";

class PrayerTimeHelper {
  PrayerTimes prayerTimes;
  PrayerTimeHelper({required this.prayerTimes});

  String currentPrayerTimeString(BuildContext context, DateTime now) {
    return TimeOfDay.fromDateTime(
      currentPrayerTime(now).toLocal(),
    ).format(context);
  }

  String localizedPrayerName(BuildContext context, Prayer prayer) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    switch (prayer) {
      case Prayer.fajr:
        return localizations.fajr;
      case Prayer.sunrise:
        return localizations.sunrise;
      case Prayer.dhuhr:
        return localizations.dhuhr;
      case Prayer.asr:
        return localizations.asr;
      case Prayer.maghrib:
        return localizations.maghrib;
      case Prayer.isha:
        return localizations.isha;
      case Prayer.ishaBefore:
        return localizations.isha;
      case Prayer.fajrAfter:
        return localizations.fajr;
      case Prayer.noon:
        return localizations.noon;
    }
  }

  Prayer currentPrayer(DateTime now) {
    Prayer prayer = prayerTimes.currentPrayer(date: now);

    // check if now is between forbiddenSunrisePrayerTime
    DateTime sunrise = prayerTimes.sunrise;
    DateTime forbiddenSunrisePrayerTime = sunrise.add(
      const Duration(minutes: 15),
    );
    if (now.isAfter(sunrise) && now.isBefore(forbiddenSunrisePrayerTime)) {
      return Prayer.sunrise;
    }

    // check noon forbidden time
    DateTime middleOfDay = prayerTimes.dhuhr;
    DateTime forbiddenNoonPrayerTime = middleOfDay.subtract(
      const Duration(minutes: 8),
    );

    if (now.isAfter(forbiddenNoonPrayerTime) && now.isBefore(middleOfDay)) {
      return Prayer.noon;
    }

    // check if now is between forbiddenSunsetPrayerTime
    DateTime sunset = prayerTimes.maghrib;
    DateTime forbiddenSunsetPrayerTime = sunset.subtract(
      const Duration(minutes: 15),
    );

    if (now.isAfter(forbiddenSunsetPrayerTime) && now.isBefore(sunset)) {
      return Prayer.maghrib;
    }

    return prayer;
  }

  Prayer nextPrayer(DateTime now) {
    return prayerTimes.nextPrayer(date: now);
  }

  String currentPrayerName(BuildContext context, DateTime now) {
    final prayer = currentPrayer(now);
    return localizedPrayerName(context, prayer);
  }

  String nextPrayerName(BuildContext context, DateTime now) {
    final prayer = nextPrayer(now);
    return localizedPrayerName(context, prayer);
  }

  DateTime currentPrayerTime(DateTime now) {
    final prayer = currentPrayer(now);
    final time = prayerTimes.timeForPrayer(prayer);
    return time.toLocal();
  }

  String nextPrayerTimeString(BuildContext context, DateTime now) {
    return TimeOfDay.fromDateTime(
      nextPrayerTime(now).toLocal(),
    ).format(context);
  }

  DateTime nextPrayerTime(DateTime now) {
    final prayer = nextPrayer(now);
    final time = prayerTimes.timeForPrayer(prayer);
    return time.toLocal();
  }

  int timeLeftInPercentage(DateTime now) {
    Duration totalTime = nextPrayerTime(now).difference(currentPrayerTime(now));
    Duration left = nextPrayerTime(now).difference(now);
    return ((left.inMicroseconds / totalTime.inMicroseconds) * 100).toInt();
  }

  String leftTimeString(BuildContext context, DateTime now) {
    Duration left = nextPrayerTime(now).difference(now);
    return "${localizedNumber(context, left.inHours).padLeft(2, "0")}:${localizedNumber(context, left.inMinutes.remainder(60)).padLeft(2, "0")}:${localizedNumber(context, left.inSeconds.remainder(60)).padLeft(2, "0")}";
  }
}
