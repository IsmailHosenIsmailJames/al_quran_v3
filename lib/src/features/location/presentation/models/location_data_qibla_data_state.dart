import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'location_data_qibla_data_state.freezed.dart';

@freezed
abstract class LocationQiblaPrayerDataState with _$LocationQiblaPrayerDataState {
  const factory LocationQiblaPrayerDataState({
    LatLon? latLon,
    double? kaabaAngle,
    CalculationParameters? calculationMethod,
    @Default(false) bool? isPrayerTimeDownloading,
    @Default(false) bool? isGettingLocation,
    Madhab? madhab,
    @Default(false) bool hasInitialLocationUpdated,
  }) = _LocationQiblaPrayerDataState;
}
