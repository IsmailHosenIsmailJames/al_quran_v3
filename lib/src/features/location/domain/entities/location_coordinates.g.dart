// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationCoordinates _$LocationCoordinatesFromJson(Map<String, dynamic> json) =>
    _LocationCoordinates(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cityName: json['cityName'] as String?,
      countryName: json['countryName'] as String?,
    );

Map<String, dynamic> _$LocationCoordinatesToJson(
  _LocationCoordinates instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'cityName': instance.cityName,
  'countryName': instance.countryName,
};
