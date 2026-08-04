import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_info_entity.freezed.dart';
part 'app_info_entity.g.dart';

@freezed
abstract class AppInfoEntity with _$AppInfoEntity {
  const factory AppInfoEntity({
    required String name,
    required String version,
    required String description,
  }) = _AppInfoEntity;

  factory AppInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$AppInfoEntityFromJson(json);
}
