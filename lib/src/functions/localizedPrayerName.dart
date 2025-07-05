import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:flutter/cupertino.dart";

String localizedPrayerName(BuildContext context, PrayerModelTimesType type) {
  AppLocalizations l10n = AppLocalizations.of(context);
  switch (type) {
    case PrayerModelTimesType.fajr:
      return l10n.fajr;
    case PrayerModelTimesType.sunrise:
      return l10n.sunrise;
    case PrayerModelTimesType.dhuhr:
      return l10n.dhuhr;
    case PrayerModelTimesType.asr:
      return l10n.asr;
    case PrayerModelTimesType.maghrib:
      return l10n.maghrib;
    case PrayerModelTimesType.isha:
      return l10n.isha;
    case PrayerModelTimesType.midnight:
      return l10n.midnight;
  }
}
