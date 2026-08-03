import "package:adhan_dart/adhan_dart.dart";

class PrayerSettingsEntity {
  final CalculationParameters calculationMethod;
  final Madhab madhab;

  const PrayerSettingsEntity({
    required this.calculationMethod,
    required this.madhab,
  });

  PrayerSettingsEntity copyWith({
    CalculationParameters? calculationMethod,
    Madhab? madhab,
  }) {
    return PrayerSettingsEntity(
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
    );
  }
}
