import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";

class LocationQiblaPrayerDataState {
  LatLon? latLon;
  CalculationMethod? calculationMethod;
  bool isDataExits;
  bool? isPrayerTimeDownloading;

  LocationQiblaPrayerDataState({
    this.latLon,
    this.calculationMethod,
    this.isDataExits = false,
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
      calculationMethod: calculationMethod ?? this.calculationMethod,
      isDataExits: isDataExits ?? this.isDataExits,
      isPrayerTimeDownloading:
          isPrayerTimeDownloading ?? this.isPrayerTimeDownloading,
    );
  }
}
