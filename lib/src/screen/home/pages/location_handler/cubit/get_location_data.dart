import "package:al_quran_v3/src/screen/home/pages/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/home/pages/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/home/pages/qibla/qibla_direction.dart";
import "package:hive/hive.dart";

LocationDataQiblaDataState getSavedLocation() {
  LocationDataQiblaDataState data = LocationDataQiblaDataState();
  final jsonLocation = Hive.box(
    "user",
  ).get("user_location", defaultValue: null);
  if (jsonLocation == null) {
    data.latLon = null;
    data.kaabaAngle = null;
  } else {
    data.latLon = LatLon.fromJson(jsonLocation);
    data.kaabaAngle = calculateQiblaAngle(
      data.latLon!.latitude,
      data.latLon!.longitude,
    );
  }
  return data;
}
