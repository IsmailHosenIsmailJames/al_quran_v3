import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";
import "package:injectable/injectable.dart";

abstract class PrayerTimeCalculatorDataSource {
  PrayerTimeEntity calculatePrayerTimes({
    required LocationCoordinates coordinates,
    required DateTime date,
    required CalculationParameters params,
    required Madhab madhab,
  });

  List<PrayerTimeEntity> calculateMonthlyPrayerTimes({
    required LocationCoordinates coordinates,
    required int year,
    required int month,
    required CalculationParameters params,
    required Madhab madhab,
  });
}

@LazySingleton(as: PrayerTimeCalculatorDataSource)
class PrayerTimeCalculatorDataSourceImpl
    implements PrayerTimeCalculatorDataSource {
  @override
  PrayerTimeEntity calculatePrayerTimes({
    required LocationCoordinates coordinates,
    required DateTime date,
    required CalculationParameters params,
    required Madhab madhab,
  }) {
    Coordinates coords = Coordinates(coordinates.latitude, coordinates.longitude);
    CalculationParameters calcParams = params;
    calcParams.madhab = madhab;

    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coords,
      date: date,
      calculationParameters: calcParams,
      precision: true,
    );

    return PrayerTimeEntity.fromPrayerTimes(prayerTimes);
  }

  @override
  List<PrayerTimeEntity> calculateMonthlyPrayerTimes({
    required LocationCoordinates coordinates,
    required int year,
    required int month,
    required CalculationParameters params,
    required Madhab madhab,
  }) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<PrayerTimeEntity> monthlyTimes = [];

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(year, month, day);
      monthlyTimes.add(calculatePrayerTimes(
        coordinates: coordinates,
        date: date,
        params: params,
        madhab: madhab,
      ));
    }
    return monthlyTimes;
  }
}
