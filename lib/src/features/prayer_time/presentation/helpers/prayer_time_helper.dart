import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";

class ForbiddenTimeInfo {
  final bool isForbiddenNow;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final Prayer prayer;

  ForbiddenTimeInfo({
    required this.isForbiddenNow,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.prayer,
  });
}

/// Represents the continuous prayer timeline across day/night boundaries.
class PrayerTimeline {
  final Prayer currentPrayer;
  final Prayer nextPrayer;
  final DateTime currentPrayerTime;
  final DateTime nextPrayerTime;
  final Duration durationUntilNext;
  final double progressElapsed;

  const PrayerTimeline({
    required this.currentPrayer,
    required this.nextPrayer,
    required this.currentPrayerTime,
    required this.nextPrayerTime,
    required this.durationUntilNext,
    required this.progressElapsed,
  });

  /// Calculates a continuous, gapless prayer timeline across midnight and day boundaries.
  /// Accurately computes Tahajjud, Fajr, and Isha transitions regardless of timezone or time of day.
  static PrayerTimeline calculate({
    required Coordinates coordinates,
    required CalculationParameters calculationParameters,
    required DateTime now,
  }) {
    final yesterdayDate = DateTime(now.year, now.month, now.day - 1);
    final todayDate = DateTime(now.year, now.month, now.day);
    final tomorrowDate = DateTime(now.year, now.month, now.day + 1);

    final ptYesterday = PrayerTimes(
      coordinates: coordinates,
      date: yesterdayDate,
      calculationParameters: calculationParameters,
      precision: true,
    );

    final ptToday = PrayerTimes(
      coordinates: coordinates,
      date: todayDate,
      calculationParameters: calculationParameters,
      precision: true,
    );

    final ptTomorrow = PrayerTimes(
      coordinates: coordinates,
      date: tomorrowDate,
      calculationParameters: calculationParameters,
      precision: true,
    );

    final events = <_PrayerTimelineEvent>[
      _PrayerTimelineEvent(Prayer.isha, ptYesterday.isha.toLocal()),
      if (ptYesterday.tahajjud != null)
        _PrayerTimelineEvent(Prayer.tahajjud, ptYesterday.tahajjud!.toLocal()),
      _PrayerTimelineEvent(Prayer.fajr, ptToday.fajr.toLocal()),
      _PrayerTimelineEvent(Prayer.sunrise, ptToday.sunrise.toLocal()),
      _PrayerTimelineEvent(Prayer.dhuhr, ptToday.dhuhr.toLocal()),
      _PrayerTimelineEvent(Prayer.asr, ptToday.asr.toLocal()),
      _PrayerTimelineEvent(Prayer.maghrib, ptToday.maghrib.toLocal()),
      _PrayerTimelineEvent(Prayer.isha, ptToday.isha.toLocal()),
      if (ptToday.tahajjud != null)
        _PrayerTimelineEvent(Prayer.tahajjud, ptToday.tahajjud!.toLocal()),
      _PrayerTimelineEvent(Prayer.fajr, ptTomorrow.fajr.toLocal()),
      _PrayerTimelineEvent(Prayer.sunrise, ptTomorrow.sunrise.toLocal()),
    ];

    // Find the next upcoming event strictly after 'now'
    int nextIndex = -1;
    for (int i = 0; i < events.length; i++) {
      if (events[i].time.isAfter(now)) {
        nextIndex = i;
        break;
      }
    }

    if (nextIndex == -1) {
      nextIndex = events.length - 1;
    }

    final nextEvent = events[nextIndex];
    final currentEvent = nextIndex > 0 ? events[nextIndex - 1] : events[0];

    final duration = nextEvent.time.difference(now);
    final totalWindow = nextEvent.time.difference(currentEvent.time);
    final elapsedWindow = now.difference(currentEvent.time);

    double progress = 0.0;
    if (totalWindow.inMilliseconds > 0) {
      progress = (elapsedWindow.inMilliseconds / totalWindow.inMilliseconds)
          .clamp(0.0, 1.0);
    }

    return PrayerTimeline(
      currentPrayer: currentEvent.prayer,
      nextPrayer: nextEvent.prayer,
      currentPrayerTime: currentEvent.time,
      nextPrayerTime: nextEvent.time,
      durationUntilNext: duration.isNegative ? Duration.zero : duration,
      progressElapsed: progress,
    );
  }
}

class _PrayerTimelineEvent {
  final Prayer prayer;
  final DateTime time;
  const _PrayerTimelineEvent(this.prayer, this.time);
}

class PrayerTimeHelper {
  PrayerTimeHelper();

  static String? localizedPrayerName(
    BuildContext? context,
    Prayer? prayer, {
    AppLocalizations? appLocalizations,
  }) {
    final AppLocalizations localizations =
        appLocalizations ?? AppLocalizations.of(context!);
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

  static String arabicPrayerName(Prayer? prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return "الفجر";
      case Prayer.sunrise:
        return "الشروق";
      case Prayer.dhuha:
        return "الضحى";
      case Prayer.noon:
        return "الزوال";
      case Prayer.dhuhr:
        return "الظهر";
      case Prayer.asr:
        return "العصر";
      case Prayer.sunset:
        return "الغروب";
      case Prayer.maghrib:
        return "المغرب";
      case Prayer.isha:
        return "العشاء";
      case Prayer.tahajjud:
        return "التهجد";
      default:
        return "";
    }
  }

  static IconData getPrayerIcon(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return FluentIcons.weather_haze_24_regular;
      case Prayer.sunrise:
        return FluentIcons.weather_sunny_low_24_regular;
      case Prayer.dhuha:
        return FluentIcons.weather_sunny_24_regular;
      case Prayer.noon:
        return FluentIcons.weather_sunny_high_24_regular;
      case Prayer.dhuhr:
        return FluentIcons.weather_sunny_24_filled;
      case Prayer.asr:
        return FluentIcons.weather_partly_cloudy_day_24_regular;
      case Prayer.sunset:
        return FluentIcons.weather_sunny_low_24_filled;
      case Prayer.maghrib:
        return FluentIcons.weather_moon_off_24_regular;
      case Prayer.isha:
        return FluentIcons.weather_moon_24_regular;
      case Prayer.tahajjud:
        return FluentIcons.weather_moon_24_filled;
    }
  }

  static String formatDuration(Duration? duration) {
    if (duration == null) {
      return "--:--:--";
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }

  static List<ForbiddenTimeInfo> getForbiddenWindows(
    PrayerTimes prayerTimes,
    DateTime now,
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context);

    // 1. Post Sunrise: Sunrise until +15 minutes
    final sunriseStart = prayerTimes.sunrise.toLocal();
    final sunriseEnd = sunriseStart.add(const Duration(minutes: 15));
    final isSunriseForbidden =
        now.isAfter(sunriseStart) && now.isBefore(sunriseEnd);

    // 2. Midday / Zenith (Zawal): Dhuhr - 8 minutes until Dhuhr
    final dhuhrStart = prayerTimes.dhuhr.toLocal();
    final noonStart = dhuhrStart.subtract(const Duration(minutes: 8));
    final isNoonForbidden = now.isAfter(noonStart) && now.isBefore(dhuhrStart);

    // 3. Pre Sunset: Maghrib - 15 minutes until Maghrib
    final maghribStart = prayerTimes.maghrib.toLocal();
    final sunsetStart = maghribStart.subtract(const Duration(minutes: 15));
    final isSunsetForbidden =
        now.isAfter(sunsetStart) && now.isBefore(maghribStart);

    return [
      ForbiddenTimeInfo(
        isForbiddenNow: isSunriseForbidden,
        title: l10n.sunrise,
        description: l10n.forbiddenSunriseDescription,
        startTime: sunriseStart,
        endTime: sunriseEnd,
        prayer: Prayer.sunrise,
      ),
      ForbiddenTimeInfo(
        isForbiddenNow: isNoonForbidden,
        title: l10n.noon,
        description: l10n.forbiddenNoonDescription,
        startTime: noonStart,
        endTime: dhuhrStart,
        prayer: Prayer.noon,
      ),
      ForbiddenTimeInfo(
        isForbiddenNow: isSunsetForbidden,
        title: l10n.sunset,
        description: l10n.forbiddenSunsetDescription,
        startTime: sunsetStart,
        endTime: maghribStart,
        prayer: Prayer.sunset,
      ),
    ];
  }

  static ForbiddenTimeInfo? getActiveForbiddenWindow(
    PrayerTimes prayerTimes,
    DateTime now,
    BuildContext context,
  ) {
    final windows = getForbiddenWindows(prayerTimes, now, context);
    for (final window in windows) {
      if (window.isForbiddenNow) return window;
    }
    return null;
  }
}
