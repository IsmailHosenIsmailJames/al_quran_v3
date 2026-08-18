import "package:freezed_annotation/freezed_annotation.dart";

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  @JsonSerializable(explicitToJson: true)
  const factory NoteModel({
    required String id,
    required List<String> ayahKey,
    required String text,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
