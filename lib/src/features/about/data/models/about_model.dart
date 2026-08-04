import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/about/domain/entities/app_info_entity.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
abstract class AboutModel with _$AboutModel {
  const factory AboutModel({
    required String name,
    required String version,
    required String description,
  }) = _AboutModel;

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  const AboutModel._();

  AppInfoEntity toEntity() {
    return AppInfoEntity(
      name: name,
      version: version,
      description: description,
    );
  }
}
