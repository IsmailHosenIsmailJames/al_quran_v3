import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_coordinates.freezed.dart';
part 'location_coordinates.g.dart';

@freezed
abstract class LocationCoordinates with _$LocationCoordinates {
  const LocationCoordinates._();

  @JsonSerializable(explicitToJson: true)
  const factory LocationCoordinates({
    required double latitude,
    required double longitude,
    String? cityName,
    String? countryName,
  }) = _LocationCoordinates;

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) =>
      _$LocationCoordinatesFromJson(json);

  factory LocationCoordinates.fromJsonString(String str) =>
      LocationCoordinates.fromJson(json.decode(str) as Map<String, dynamic>);

  factory LocationCoordinates.fromMap(Map<String, dynamic> map) =>
      LocationCoordinates.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
  String toJsonString() => json.encode(toJson());
}
