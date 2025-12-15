import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";

class LocationQiblaPrayerDataState {
  LatLon? latLon;
  double? kaabaAngle;
  CalculationMethod? calculationMethod;
  bool? isPrayerTimeDownloading;

  LocationQiblaPrayerDataState({
    this.latLon,
    this.kaabaAngle,
    this.calculationMethod,
    this.isPrayerTimeDownloading = false,
  });

  LocationQiblaPrayerDataState copyWith({
    LatLon? latLon,
    double? kaabaAngle,
    CalculationMethod? calculationMethod,
    bool? isDataExits,
    bool? isPrayerTimeDownloading,
  }) {
    return LocationQiblaPrayerDataState(
      latLon: latLon ?? this.latLon,
      kaabaAngle: kaabaAngle ?? this.kaabaAngle,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      isPrayerTimeDownloading:
          isPrayerTimeDownloading ?? this.isPrayerTimeDownloading,
    );
  }
}
