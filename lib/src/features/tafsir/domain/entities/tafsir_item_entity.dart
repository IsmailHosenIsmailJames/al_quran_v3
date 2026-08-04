import 'package:freezed_annotation/freezed_annotation.dart';

part 'tafsir_item_entity.freezed.dart';
part 'tafsir_item_entity.g.dart';

@freezed
abstract class TafsirItemEntity with _$TafsirItemEntity {
  const factory TafsirItemEntity({
    required String bookName,
    required String ayahKey,
    required String text,
  }) = _TafsirItemEntity;

  factory TafsirItemEntity.fromJson(Map<String, dynamic> json) =>
      _$TafsirItemEntityFromJson(json);
}
