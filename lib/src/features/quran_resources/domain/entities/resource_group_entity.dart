import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';

part 'resource_group_entity.freezed.dart';

@freezed
abstract class ResourceGroupEntity with _$ResourceGroupEntity {
  const factory ResourceGroupEntity({
    required String languageKey,
    required String languageNative,
    required String languageEnglish,
    required List<QuranResourceEntity> resources,
  }) = _ResourceGroupEntity;
}
