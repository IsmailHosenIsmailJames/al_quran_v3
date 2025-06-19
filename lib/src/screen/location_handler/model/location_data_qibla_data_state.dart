import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";

class LocationQiblaPrayerDataState {
  LatLon? latLon;
  double? kaabaAngle;
  CalculationMethod? calculationMethod;
  bool isDataExits;

  LocationQiblaPrayerDataState({
    this.latLon,
    this.kaabaAngle,
    this.calculationMethod,
    this.isDataExits = false,
  });

  LocationQiblaPrayerDataState copyWith({
    LatLon? latLon,
    double? kaabaAngle,
    CalculationMethod? calculationMethod,
    bool? isDataExits,
  }) {
    return LocationQiblaPrayerDataState(
      latLon: latLon ?? this.latLon,
      kaabaAngle: kaabaAngle ?? this.kaabaAngle,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      isDataExits: isDataExits ?? this.isDataExits,
    );
  }
}
