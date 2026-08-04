import "dart:developer";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/l10n/app_localizations_ar.dart";
import "package:al_quran_v3/l10n/app_localizations_az.dart";
import "package:al_quran_v3/l10n/app_localizations_bn.dart";
import "package:al_quran_v3/l10n/app_localizations_de.dart";
import "package:al_quran_v3/l10n/app_localizations_en.dart";
import "package:al_quran_v3/l10n/app_localizations_es.dart";
import "package:al_quran_v3/l10n/app_localizations_fa.dart";
import "package:al_quran_v3/l10n/app_localizations_fr.dart";
import "package:al_quran_v3/l10n/app_localizations_hi.dart";
import "package:al_quran_v3/l10n/app_localizations_id.dart";
import "package:al_quran_v3/l10n/app_localizations_it.dart";
import "package:al_quran_v3/l10n/app_localizations_ja.dart";
import "package:al_quran_v3/l10n/app_localizations_kk.dart";
import "package:al_quran_v3/l10n/app_localizations_ko.dart";
import "package:al_quran_v3/l10n/app_localizations_ms.dart";
import "package:al_quran_v3/l10n/app_localizations_pa.dart";
import "package:al_quran_v3/l10n/app_localizations_ps.dart";
import "package:al_quran_v3/l10n/app_localizations_pt.dart";
import "package:al_quran_v3/l10n/app_localizations_ru.dart";
import "package:al_quran_v3/l10n/app_localizations_sw.dart";
import "package:al_quran_v3/l10n/app_localizations_ta.dart";
import "package:al_quran_v3/l10n/app_localizations_tr.dart";
import "package:al_quran_v3/l10n/app_localizations_ur.dart";
import "package:al_quran_v3/l10n/app_localizations_vi.dart";
import "package:al_quran_v3/l10n/app_localizations_zh.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";
import "package:shared_preferences/shared_preferences.dart";

class ReminderScheduler {
  static late SharedPreferences _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // ─── Schedule ──────────────────────────────────────────────────────────

  static Future<void> scheduleNotification() async {
    LocationQiblaPrayerDataState locationState =
        await LocationQiblaPrayerDataCubit.getSavedState();

    if (locationState.latLon == null) return;

    PrayerReminderState reminderState = getState();

    DateTime now = DateTime.now();

    // check permission
    if (!await Permission.notification.isGranted ||
        !await Permission.scheduleExactAlarm.isGranted) {
      return;
    }

    await _scheduleNotifications(locationState, reminderState, now);
  }

  /// Schedule notification-type reminders using `awesome_notifications`.
  /// Schedules 7 days ahead.
  static Future<void> _scheduleNotifications(
    LocationQiblaPrayerDataState locationState,
    PrayerReminderState reminderState,
    DateTime now,
  ) async {
    Locale locale = (await LanguageCubit.getInitialLocale()).locale;
    AppLocalizations appLocalizations = appLocalizationsFromLocale(locale);
    List<Map<Prayer, DateTime?>> next7DaysPrayerTimes = _getNext7DayPrayerTimes(
      locationState,
      now,
    );

    for (int i = 0; i < next7DaysPrayerTimes.length; i++) {
      final prayerTimesToday = next7DaysPrayerTimes[i];
      for (Prayer prayerName in prayerTimesToday.keys) {
        DateTime? time = prayerTimesToday[prayerName];
        if (time != null) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              channelKey: "prayer_reminder",
              id: _notificationId(prayerName, time),
              title:
                  "${getPrayerGroupName(prayerName, appLocalizations)} - ${getPrayerNameWithSomeDetails(prayerName, appLocalizations)}",
              body: DateFormat.jm(
                (await LanguageCubit.getInitialLocale()).locale.languageCode,
              ).format(time),
            ),

            schedule: NotificationCalendar(
              day: time.day,
              month: time.month,
              year: time.year,
              hour: time.hour,
              minute: time.minute,
              second: time.second,
              millisecond: time.millisecond,
              allowWhileIdle: true,
              repeats: false,
            ),
          );
        }
      }
    }
  }

  static AppLocalizations appLocalizationsFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return AppLocalizationsAr();
      case 'az':
        return AppLocalizationsAz();
      case 'bn':
        return AppLocalizationsBn();
      case 'de':
        return AppLocalizationsDe();
      case 'en':
        return AppLocalizationsEn();
      case 'es':
        return AppLocalizationsEs();
      case 'fa':
        return AppLocalizationsFa();
      case 'fr':
        return AppLocalizationsFr();
      case 'hi':
        return AppLocalizationsHi();
      case 'id':
        return AppLocalizationsId();
      case 'it':
        return AppLocalizationsIt();
      case 'ja':
        return AppLocalizationsJa();
      case 'kk':
        return AppLocalizationsKk();
      case 'ko':
        return AppLocalizationsKo();
      case 'ms':
        return AppLocalizationsMs();
      case 'pa':
        return AppLocalizationsPa();
      case 'ps':
        return AppLocalizationsPs();
      case 'pt':
        return AppLocalizationsPt();
      case 'ru':
        return AppLocalizationsRu();
      case 'sw':
        return AppLocalizationsSw();
      case 'ta':
        return AppLocalizationsTa();
      case 'tr':
        return AppLocalizationsTr();
      case 'ur':
        return AppLocalizationsUr();
      case 'vi':
        return AppLocalizationsVi();
      case 'zh':
        return AppLocalizationsZh();
      default:
        return AppLocalizationsEn();
    }
  }

  static String getPrayerNameWithSomeDetails(
    Prayer prayer,
    AppLocalizations appLocalizations,
  ) {
    switch (prayer) {
      case Prayer.sunrise:
        return appLocalizations.sunRising;
      case Prayer.noon:
        return appLocalizations.sunTopOfTheHead;
      case Prayer.sunset:
        return appLocalizations.sunSetting;
      case Prayer.fajr:
        return appLocalizations.fajr.capitalize();
      case Prayer.dhuha:
        return appLocalizations.dhuha.capitalize();
      case Prayer.dhuhr:
        return appLocalizations.dhuhr.capitalize();
      case Prayer.asr:
        return appLocalizations.asr.capitalize();
      case Prayer.maghrib:
        return appLocalizations.maghrib.capitalize();
      case Prayer.isha:
        return appLocalizations.isha.capitalize();
      case Prayer.tahajjud:
        return appLocalizations.tahajjud.capitalize();
    }
  }

  static String getPrayerGroupName(
    Prayer prayer,
    AppLocalizations appLocalizations,
  ) {
    switch (prayer) {
      case Prayer.fajr:
      case Prayer.dhuhr:
      case Prayer.asr:
      case Prayer.maghrib:
      case Prayer.isha:
      case Prayer.tahajjud:
      case Prayer.dhuha:
        return appLocalizations.salatTime;

      case Prayer.sunrise:
      case Prayer.sunset:
      case Prayer.noon:
        return appLocalizations.forbiddenSalatTime;
    }
  }

  static List<Map<Prayer, DateTime?>> _getNext7DayPrayerTimes(
    LocationQiblaPrayerDataState locationState,
    DateTime now,
  ) {
    List<Map<Prayer, DateTime?>> prayerTimes = [];
    final reminderTimeAdjustment = getReminderTimeAdjustment();
    for (int i = 0; i < 7; i++) {
      final prayer = PrayerTimes(
        date: now.add(Duration(days: i)),
        coordinates: Coordinates(
          locationState.latLon!.latitude,
          locationState.latLon!.longitude,
        ),
        calculationParameters:
            (locationState.calculationMethod ??
                  CalculationMethodParameters.muslimWorldLeague())
              ..madhab = locationState.madhab ?? Madhab.shafi,
      );
      Map<Prayer, DateTime?> prayerTimesToday = {};
      for (Prayer prayerName in Prayer.values) {
        DateTime? time = prayer.timeForPrayer(prayerName);
        if (time != null) {
          time = time.toLocal();
          int adjust = reminderTimeAdjustment[prayerName] ?? 0;
          if (adjust != 0) {
            time = time.add(Duration(minutes: adjust));
          }
        }
        prayerTimesToday[prayerName] = time;
      }
      prayerTimes.add(prayerTimesToday);
    }
    return prayerTimes;
  }

  static Future<void> cancelAllNotifications() async {
    log("Cancelling all notifications");
    await AwesomeNotifications().cancelAll();
  }

  // ─── ID Helpers ────────────────────────────────────────────────────────

  /// Notification IDs: prayerIndex * 1000 + dayOffset (range: 0-9999)
  static int _notificationId(Prayer prayer, DateTime time) {
    return prayer.index * 1000 + time.month * 100 + time.day;
  }

  static PrayerReminderState getState() {
    return PrayerReminderState(
      reminderTimeAdjustment: getReminderTimeAdjustment(),
      enforceAlarmSound: getEnforceAlarmSound(),
      soundVolume: getSoundVolume(),
    );
  }

  static Future<void> enablePrayerRemindNotification() async {
    _sharedPreferences.setBool("prayer_remind_notification", true);
    await scheduleNotification();
  }

  static Future<void> disablePrayerRemindNotification() async {
    _sharedPreferences.setBool("prayer_remind_notification", false);
    await cancelAllNotifications();
  }

  static bool isPrayerRemindNotificationEnabled() {
    return _sharedPreferences.getBool("prayer_remind_notification") ?? false;
  }

  static Map<Prayer, int> getReminderTimeAdjustment() {
    Map<Prayer, int> map = {};
    for (var element in Prayer.values) {
      int? time = _sharedPreferences.getInt(
        "prayer_${element.name}_reminder_time",
      );
      time ??= 0;
      map[element] = time;
    }
    return map;
  }

  static Future<void> setReminderTimeAdjustment(Prayer prayer, int time) async {
    _sharedPreferences.setInt("prayer_${prayer.name}_reminder_time", time);
  }

  static bool getEnforceAlarmSound() {
    return _sharedPreferences.getBool("prayer_reminder_enforce_alarm_sound") ??
        false;
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    _sharedPreferences.setBool("prayer_reminder_enforce_alarm_sound", value);
  }

  static double getSoundVolume() {
    return _sharedPreferences.getDouble("prayer_reminder_sound_volume") ?? 0.8;
  }

  static Future<void> setSoundVolume(double volume) async {
    _sharedPreferences.setDouble("prayer_reminder_sound_volume", volume);
  }
}
