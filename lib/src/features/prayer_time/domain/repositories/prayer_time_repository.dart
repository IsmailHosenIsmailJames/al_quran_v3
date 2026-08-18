import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";

abstract class PrayerTimeRepository {
  /// Calculates daily prayer times for a date given coordinates and calculation settings.
  PrayerTimeEntity getPrayerTimes({
    required LocationCoordinates coordinates,
    required DateTime date,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  });

  /// Calculates monthly prayer times for calendar view.
  List<PrayerTimeEntity> getMonthlyPrayerTimes({
    required LocationCoordinates coordinates,
    required int year,
    required int month,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  });

  /// Saves prayer calculation settings to local storage.
  Future<void> saveCalculationMethod(CalculationParameters method);

  /// Saves Madhab setting to local storage.
  Future<void> saveMadhab(Madhab madhab);

  /// Schedules background notifications for upcoming prayers.
  Future<void> schedulePrayerNotifications();
}
