import "package:freezed_annotation/freezed_annotation.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_model.dart";

part 'pinned_collection_model.freezed.dart';
part 'pinned_collection_model.g.dart';

@freezed
abstract class PinnedCollectionModel with _$PinnedCollectionModel {
  const factory PinnedCollectionModel({
    required String id,
    required String name,
    @Default("808080") String colorHex,
    required List<PinnedModel> pinned,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PinnedCollectionModel;

  factory PinnedCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$PinnedCollectionModelFromJson(json);
}
