import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:flutter/material.dart";

class PrayerTimeHelper {
  PrayerTimeHelper();

  static String? localizedPrayerName(BuildContext context, Prayer? prayer) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    switch (prayer) {
      case Prayer.fajr:
        return localizations.fajr;
      case Prayer.sunrise:
        return localizations.sunrise;
      case Prayer.dhuha:
        return localizations.dhuha;
      case Prayer.noon:
        return localizations.noon;
      case Prayer.dhuhr:
        return localizations.dhuhr;
      case Prayer.asr:
        return localizations.asr;
      case Prayer.sunset:
        return localizations.sunset;
      case Prayer.maghrib:
        return localizations.maghrib;
      case Prayer.isha:
        return localizations.isha;
      case Prayer.tahajjud:
        return localizations.tahajjud;
      default:
        return null;
    }
  }

  static String formatDuration(Duration? duration) {
    if (duration == null) {
      return "-";
    }
    return "${duration.inHours.toString().padLeft(2, "0")}:${(duration.inMinutes % 60).toString().padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
  }
}
