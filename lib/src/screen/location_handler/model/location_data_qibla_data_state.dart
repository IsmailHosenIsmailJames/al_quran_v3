import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";

class LocationQiblaPrayerDataState {
  LatLon? latLon;
  double? kaabaAngle;
  CalculationParameters? calculationMethod;
  bool? isPrayerTimeDownloading;
  bool? isGettingLocation;
  Madhab? madhab;

  LocationQiblaPrayerDataState({
    this.latLon,
    this.kaabaAngle,
    this.calculationMethod,
    this.isPrayerTimeDownloading = false,
    this.isGettingLocation = false,
    this.madhab,
  });

  LocationQiblaPrayerDataState copyWith({
    LatLon? latLon,
    double? kaabaAngle,
    CalculationParameters? calculationMethod,
    bool? isDataExits,
    bool? isPrayerTimeDownloading,
    bool? isGettingLocation,
    Madhab? madhab,
  }) {
    return LocationQiblaPrayerDataState(
      latLon: latLon ?? this.latLon,
      kaabaAngle: kaabaAngle ?? this.kaabaAngle,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      isPrayerTimeDownloading:
          isPrayerTimeDownloading ?? this.isPrayerTimeDownloading,
      isGettingLocation: isGettingLocation ?? this.isGettingLocation,
      madhab: madhab ?? this.madhab,
    );
  }
}
