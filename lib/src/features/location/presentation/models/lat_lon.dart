import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_lon.freezed.dart';
part 'lat_lon.g.dart';

@freezed
abstract class LatLon with _$LatLon {
  const LatLon._();

  @JsonSerializable(explicitToJson: true)
  const factory LatLon({
    required double latitude,
    required double longitude,
  }) = _LatLon;

  factory LatLon.fromJson(Map<String, dynamic> json) => _$LatLonFromJson(json);

  factory LatLon.fromJsonString(String str) =>
      LatLon.fromJson(json.decode(str) as Map<String, dynamic>);

  factory LatLon.fromMap(Map<String, dynamic> map) => LatLon.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
  String toJsonString() => json.encode(toJson());
}
