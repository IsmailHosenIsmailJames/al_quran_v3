import "package:freezed_annotation/freezed_annotation.dart";

part 'navigation_info_model.freezed.dart';

@freezed
abstract class NavigationInfoModel with _$NavigationInfoModel {
  const factory NavigationInfoModel({
    String? previousStartKey,
    String? previousEndKey,
    String? nextStartKey,
    String? nextEndKey,
  }) = _NavigationInfoModel;
}
