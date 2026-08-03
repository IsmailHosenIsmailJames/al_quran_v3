import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/repositories/prayer_time_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetPrayerTimesUseCase {
  final PrayerTimeRepository _repository;

  GetPrayerTimesUseCase(this._repository);

  PrayerTimeEntity call({
    required LocationCoordinates coordinates,
    required DateTime date,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  }) {
    return _repository.getPrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: calculationParameters,
      madhab: madhab,
    );
  }

  List<PrayerTimeEntity> getMonthly({
    required LocationCoordinates coordinates,
    required int year,
    required int month,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
  }) {
    return _repository.getMonthlyPrayerTimes(
      coordinates: coordinates,
      year: year,
      month: month,
      calculationParameters: calculationParameters,
      madhab: madhab,
    );
  }
}
