import "package:freezed_annotation/freezed_annotation.dart";

part 'pinned_model.freezed.dart';
part 'pinned_model.g.dart';

@freezed
abstract class PinnedModel with _$PinnedModel {
  const factory PinnedModel({
    required String id,
    required String ayahKey,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PinnedModel;

  factory PinnedModel.fromJson(Map<String, dynamic> json) =>
      _$PinnedModelFromJson(json);
}
