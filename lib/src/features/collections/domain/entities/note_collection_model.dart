import "package:freezed_annotation/freezed_annotation.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";

part 'note_collection_model.freezed.dart';
part 'note_collection_model.g.dart';

@freezed
abstract class NoteCollectionModel with _$NoteCollectionModel {
  @JsonSerializable(explicitToJson: true)
  const factory NoteCollectionModel({
    required String id,
    required String name,
    @Default("808080") String colorHex,
    required List<NoteModel> notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NoteCollectionModel;

  factory NoteCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$NoteCollectionModelFromJson(json);
}
