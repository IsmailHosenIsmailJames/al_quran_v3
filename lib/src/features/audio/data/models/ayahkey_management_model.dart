import 'package:freezed_annotation/freezed_annotation.dart';

part 'ayahkey_management_model.freezed.dart';
part 'ayahkey_management_model.g.dart';

@freezed
abstract class AyahKeyManagement with _$AyahKeyManagement {
  @JsonSerializable(explicitToJson: true)
  const factory AyahKeyManagement({
    required String start,
    required String end,
    required String current,
    required List<String> ayahList,
    int? lastScrolledPageNumber,
  }) = _AyahKeyManagement;

  factory AyahKeyManagement.fromJson(Map<String, dynamic> json) =>
      _$AyahKeyManagementFromJson(json);
}
