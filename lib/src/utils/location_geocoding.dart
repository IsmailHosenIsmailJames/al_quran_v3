import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geocoding/geocoding.dart";

AddressClass? address;

Future<String> locationName(BuildContext context, LatLon latLon) async {
  if (address == null) {
    final countryCode = context.read<LanguageCubit>().state.locale.countryCode;
    await setLocaleIdentifier(countryCode ?? "US");

    final placeMarks = await placemarkFromCoordinates(
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
