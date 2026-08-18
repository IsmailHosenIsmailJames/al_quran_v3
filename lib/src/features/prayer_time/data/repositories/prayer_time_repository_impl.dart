import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/prayer_time/data/datasources/prayer_time_calculator_datasource.dart";
import "package:al_quran_v3/src/features/prayer_time/data/datasources/prayer_time_local_datasource.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/repositories/prayer_time_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: PrayerTimeRepository)
class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimeCalculatorDataSource _calculatorDataSource;
  final PrayerTimeLocalDataSource _localDataSource;

  PrayerTimeRepositoryImpl(
    this._calculatorDataSource,
    this._localDataSource,
  );

  @override
  PrayerTimeEntity getPrayerTimes({
    required LocationCoordinates coordinates,
    required DateTime date,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  }) {
    return _calculatorDataSource.calculatePrayerTimes(
      coordinates: coordinates,
      date: date,
      params: calculationParameters,
      madhab: madhab,
    );
  }

  @override
  List<PrayerTimeEntity> getMonthlyPrayerTimes({
    required LocationCoordinates coordinates,
    required int year,
    required int month,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  }) {
    return _calculatorDataSource.calculateMonthlyPrayerTimes(
      coordinates: coordinates,
      year: year,
      month: month,
      params: calculationParameters,
      madhab: madhab,
    );
  }

  @override
  Future<void> saveCalculationMethod(CalculationParameters method) {
    return _localDataSource.saveCalculationMethod(method);
  }

  @override
  Future<void> saveMadhab(Madhab madhab) {
    return _localDataSource.saveMadhab(madhab);
  }

  @override
  Future<void> schedulePrayerNotifications() {
    return _localDataSource.scheduleNotifications();
  }
}
