import "package:adhan_dart/adhan_dart.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'prayer_settings_entity.freezed.dart';

@freezed
abstract class PrayerSettingsEntity with _$PrayerSettingsEntity {
  const factory PrayerSettingsEntity({
    required CalculationParameters calculationMethod,
    required Madhab madhab,
  }) = _PrayerSettingsEntity;
}
