import 'package:al_quran_v3/src/screen/home/pages/location_handler/model/location_data_qibla_data_state.dart';
import 'package:al_quran_v3/src/screen/home/pages/location_handler/cubit/get_location_data.dart';
import 'package:al_quran_v3/src/screen/home/pages/location_handler/model/lat_lon.dart';
import 'package:al_quran_v3/src/screen/home/pages/qibla/qibla_direction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LocationDataQiblaDataCubit extends Cubit<LocationDataQiblaDataState> {
  LocationDataQiblaDataCubit() : super(getSavedLocation());
  void saveLocationData(LatLon latLon) {
    LocationDataQiblaDataState data = LocationDataQiblaDataState();
    data.latLon = latLon;
    data.kaabaAngle = calculateQiblaAngle(latLon.latitude, latLon.longitude);
    emit(data);
    Hive.box('user').put('user_location', latLon.toJson());
  }
}
