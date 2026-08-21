import "dart:convert";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:flutter/foundation.dart";
import "package:home_widget/home_widget.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Service responsible for synchronizing prayer time data with native
/// Home Screen and Lock Screen widgets on Android and iOS.
class PrayerWidgetService {
  static const String appGroupId = "group.com.ismail_hosen_james.al_bayan_quran";
  static const String smallWidgetAndroid = "PrayerWidgetSmallProvider";
  static const String mediumWidgetAndroid = "PrayerWidgetMediumProvider";
  static const String iosWidget = "PrayerWidget";

  static bool _isInitialized = false;

  /// Initializes HomeWidget configuration (App Group ID for iOS).
  static Future<void> init() async {
    if (_isInitialized) return;
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      _isInitialized = true;
    } catch (e) {
      debugPrint("PrayerWidgetService.init error: $e");
    }
  }

  /// Calculates prayer times and updates all active widgets.
  static Future<void> updateWidgets({
    LocationQiblaPrayerDataState? locationState,
    DateTime? currentTime,
    String? locationNameOverride,
  }) async {
    try {
      await init();

      final locState = locationState ?? await LocationQiblaPrayerDataCubit.getSavedState();
      if (locState.latLon == null) return;

      final now = currentTime ?? DateTime.now();
      final coordinates = Coordinates(
        locState.latLon!.latitude,
        locState.latLon!.longitude,
      );

      final calcParams = (locState.calculationMethod ??
              CalculationMethodParameters.muslimWorldLeague())
          ..madhab = locState.madhab ?? Madhab.shafi;

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: calcParams,
        now: now,
      );

      final ptToday = PrayerTimes(
        coordinates: coordinates,
        date: DateTime(now.year, now.month, now.day),
        calculationParameters: calcParams,
        precision: true,
      );

      // Localization
      final locale = (await LanguageCubit.getInitialLocale()).locale;
      final l10n = ReminderScheduler.appLocalizationsFromLocale(locale);
      final timeFormatter = DateFormat.jm(locale.languageCode);
      final dateFormatter = DateFormat("EEE, MMM d", locale.languageCode);

      // Location Name
      final prefs = await SharedPreferences.getInstance();
      String locationName = locationNameOverride ??
          prefs.getString("user_location_name") ??
          "Prayer Times";
      if (locationName.contains(",")) {
        locationName = locationName.split(",").first.trim();
      }

      // Next prayer name & remaining text
      final nextPrayerName = prayerTitle(timeline.nextPrayer, l10n);
      final nextPrayerTime = timeFormatter.format(timeline.nextPrayerTime);
      final durationUntil = timeline.durationUntilNext;
      final hours = durationUntil.inHours;
      final minutes = durationUntil.inMinutes % 60;
      final countdownText = hours > 0
          ? "In ${hours}h ${minutes}m"
          : "In ${minutes}m";

      // 5-Prayer times today
      final fajrTime = timeFormatter.format(ptToday.fajr.toLocal());
      final sunriseTime = timeFormatter.format(ptToday.sunrise.toLocal());
      final dhuhrTime = timeFormatter.format(ptToday.dhuhr.toLocal());
      final asrTime = timeFormatter.format(ptToday.asr.toLocal());
      final maghribTime = timeFormatter.format(ptToday.maghrib.toLocal());
      final ishaTime = timeFormatter.format(ptToday.isha.toLocal());

      // Determine active prayer index for 5-prayer strip
      // 0: Fajr, 1: Dhuhr, 2: Asr, 3: Maghrib, 4: Isha
      int activeIndex = -1;
      if (timeline.currentPrayer == Prayer.fajr) {
        activeIndex = 0;
      } else if (timeline.currentPrayer == Prayer.dhuhr) {
        activeIndex = 1;
      } else if (timeline.currentPrayer == Prayer.asr) {
        activeIndex = 2;
      } else if (timeline.currentPrayer == Prayer.maghrib) {
        activeIndex = 3;
      } else if (timeline.currentPrayer == Prayer.isha || timeline.currentPrayer == Prayer.tahajjud) {
        activeIndex = 4;
      }

      // 1. Save individual fields for Android RemoteViews
      final isDark = PlatformDispatcher.instance.platformBrightness == Brightness.dark;
      await HomeWidget.saveWidgetData<bool>("is_dark_mode", isDark);
      await HomeWidget.saveWidgetData<String>("location_name", locationName);
      await HomeWidget.saveWidgetData<String>("date_text", dateFormatter.format(now));
      await HomeWidget.saveWidgetData<String>("next_prayer_name", nextPrayerName);
      await HomeWidget.saveWidgetData<String>("next_prayer_time", nextPrayerTime);
      await HomeWidget.saveWidgetData<String>("next_prayer_countdown", countdownText);
      await HomeWidget.saveWidgetData<String>("next_prayer_target_iso", timeline.nextPrayerTime.toIso8601String());

      // Prayer names
      await HomeWidget.saveWidgetData<String>("fajr_name", l10n.fajr);
      await HomeWidget.saveWidgetData<String>("sunrise_name", l10n.sunrise);
      await HomeWidget.saveWidgetData<String>("dhuhr_name", l10n.dhuhr);
      await HomeWidget.saveWidgetData<String>("asr_name", l10n.asr);
      await HomeWidget.saveWidgetData<String>("maghrib_name", l10n.maghrib);
      await HomeWidget.saveWidgetData<String>("isha_name", l10n.isha);

      // Prayer times
      await HomeWidget.saveWidgetData<String>("fajr_time", fajrTime);
      await HomeWidget.saveWidgetData<String>("sunrise_time", sunriseTime);
      await HomeWidget.saveWidgetData<String>("dhuhr_time", dhuhrTime);
      await HomeWidget.saveWidgetData<String>("asr_time", asrTime);
      await HomeWidget.saveWidgetData<String>("maghrib_time", maghribTime);
      await HomeWidget.saveWidgetData<String>("isha_time", ishaTime);

      // Active flags
      await HomeWidget.saveWidgetData<bool>("fajr_is_active", activeIndex == 0);
      await HomeWidget.saveWidgetData<bool>("dhuhr_is_active", activeIndex == 1);
      await HomeWidget.saveWidgetData<bool>("asr_is_active", activeIndex == 2);
      await HomeWidget.saveWidgetData<bool>("maghrib_is_active", activeIndex == 3);
      await HomeWidget.saveWidgetData<bool>("isha_is_active", activeIndex == 4);
      await HomeWidget.saveWidgetData<int>("active_prayer_index", activeIndex);

      // 2. Generate 7-Day Timeline JSON for iOS WidgetKit TimelineProvider
      final timelineDays = <Map<String, dynamic>>[];
      for (int i = 0; i < 7; i++) {
        final dayDate = DateTime(now.year, now.month, now.day + i);
        final ptDay = PrayerTimes(
          coordinates: coordinates,
          date: dayDate,
          calculationParameters: calcParams,
          precision: true,
        );

        timelineDays.add({
          "date": dayDate.toIso8601String(),
          "date_formatted": dateFormatter.format(dayDate),
          "fajr": ptDay.fajr.toLocal().toIso8601String(),
          "fajr_formatted": timeFormatter.format(ptDay.fajr.toLocal()),
          "sunrise": ptDay.sunrise.toLocal().toIso8601String(),
          "sunrise_formatted": timeFormatter.format(ptDay.sunrise.toLocal()),
          "dhuhr": ptDay.dhuhr.toLocal().toIso8601String(),
          "dhuhr_formatted": timeFormatter.format(ptDay.dhuhr.toLocal()),
          "asr": ptDay.asr.toLocal().toIso8601String(),
          "asr_formatted": timeFormatter.format(ptDay.asr.toLocal()),
          "maghrib": ptDay.maghrib.toLocal().toIso8601String(),
          "maghrib_formatted": timeFormatter.format(ptDay.maghrib.toLocal()),
          "isha": ptDay.isha.toLocal().toIso8601String(),
          "isha_formatted": timeFormatter.format(ptDay.isha.toLocal()),
        });
      }

      final timelinePayload = {
        "location": locationName,
        "days": timelineDays,
        "labels": {
          "fajr": l10n.fajr,
          "sunrise": l10n.sunrise,
          "dhuhr": l10n.dhuhr,
          "asr": l10n.asr,
          "maghrib": l10n.maghrib,
          "isha": l10n.isha,
          "next": "Next",
        },
      };

      await HomeWidget.saveWidgetData<String>(
        "prayer_timeline_json",
        jsonEncode(timelinePayload),
      );

      // 3. Notify native widget engines to re-render
      await HomeWidget.updateWidget(
        androidName: smallWidgetAndroid,
        iOSName: iosWidget,
      );
      await HomeWidget.updateWidget(
        androidName: mediumWidgetAndroid,
        iOSName: iosWidget,
      );
    } catch (e) {
      debugPrint("PrayerWidgetService.updateWidgets error: $e");
    }
  }

  /// Translates Prayer enum to human localized name.
  static String prayerTitle(Prayer prayer, AppLocalizations l10n) {
    switch (prayer) {
      case Prayer.fajr:
        return l10n.fajr;
      case Prayer.sunrise:
        return l10n.sunrise;
      case Prayer.dhuha:
        return l10n.dhuha;
      case Prayer.dhuhr:
        return l10n.dhuhr;
      case Prayer.asr:
        return l10n.asr;
      case Prayer.maghrib:
        return l10n.maghrib;
      case Prayer.isha:
        return l10n.isha;
      case Prayer.tahajjud:
        return l10n.tahajjud;
      case Prayer.sunset:
        return l10n.sunSetting;
      case Prayer.noon:
        return l10n.sunTopOfTheHead;
    }
  }
}
