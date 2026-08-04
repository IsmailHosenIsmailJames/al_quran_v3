import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/tafsir/domain/entities/tafsir_item_entity.dart';

part 'tafsir_item_model.freezed.dart';
part 'tafsir_item_model.g.dart';

@freezed
abstract class TafsirItemModel with _$TafsirItemModel {
  const factory TafsirItemModel({
    required String bookName,
    required String ayahKey,
    required String text,
  }) = _TafsirItemModel;

  factory TafsirItemModel.fromJson(Map<String, dynamic> json) =>
      _$TafsirItemModelFromJson(json);

  const TafsirItemModel._();

  TafsirItemEntity toEntity() {
    return TafsirItemEntity(
      bookName: bookName,
      ayahKey: ayahKey,
      text: text,
    );
  }
}
