import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geocoding/geocoding.dart";

AddressClass? address;
LatLon? _lastLatLon;
Future<String>? _cachedFuture;

Future<String> locationName(BuildContext context, LatLon latLon) {
  if (address == null ||
      _lastLatLon?.latitude != latLon.latitude ||
      _lastLatLon?.longitude != latLon.longitude) {
    _lastLatLon = latLon;
    _cachedFuture = _fetchLocationName(context, latLon);
  }
  return _cachedFuture!;
}

Future<String> _fetchLocationName(BuildContext context, LatLon latLon) async {
  final countryCode = context.read<LanguageCubit>().state.locale.countryCode;
  final Geocoding geocoding = Geocoding(locale: Locale(countryCode ?? "US"));

  final placeMarks = await geocoding.placemarkFromCoordinates(
    latLon.latitude,
    latLon.longitude,
  );

  address = AddressClass();
  for (final placeMark in placeMarks) {
    address!.name = placeMark.name;
    address!.subThoroughfare = placeMark.subThoroughfare;
    address!.thoroughfare = placeMark.thoroughfare;
    address!.subLocality = placeMark.subLocality;
    address!.locality = placeMark.locality;
    address!.subAdministrativeArea = placeMark.subAdministrativeArea;
    address!.administrativeArea = placeMark.administrativeArea;
    address!.postalCode = placeMark.postalCode;
    address!.country = placeMark.country;
    address!.isoCountryCode = placeMark.isoCountryCode;
  }

  return [
    address!.name,
    address!.subThoroughfare,
    address!.thoroughfare,
    address!.subLocality,
    address!.locality,
    address!.subAdministrativeArea,
    address!.administrativeArea,
    address!.postalCode,
    address!.country,
    address!.isoCountryCode,
  ].where((e) => e != null && e.isNotEmpty).toSet().join(", ");
}

class AddressClass {
  String? name;
  String? subThoroughfare;
  String? thoroughfare;
  String? subLocality;
  String? locality;
  String? subAdministrativeArea;
  String? administrativeArea;
  String? postalCode;
  String? country;
  String? isoCountryCode;

  AddressClass({
    this.name,
    this.subThoroughfare,
    this.thoroughfare,
    this.subLocality,
    this.locality,
    this.subAdministrativeArea,
    this.administrativeArea,
    this.postalCode,
    this.country,
    this.isoCountryCode,
  });
}
