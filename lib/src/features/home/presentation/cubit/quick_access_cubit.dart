import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

part 'quick_access_cubit.freezed.dart';
part 'quick_access_cubit.g.dart';

@freezed
abstract class QuickAccessModel with _$QuickAccessModel {
  const QuickAccessModel._();

  @JsonSerializable(explicitToJson: true)
  const factory QuickAccessModel({
    required int surahNumber,
    int? scrollIndex,
    required DateTime createdAt,
  }) = _QuickAccessModel;

  factory QuickAccessModel.fromJson(Map<String, dynamic> json) =>
      _$QuickAccessModelFromJson(json);

  factory QuickAccessModel.fromMap(Map<String, dynamic> map) =>
      QuickAccessModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

@lazySingleton
class QuickAccessCubit extends Cubit<List<QuickAccessModel>> {
  QuickAccessCubit()
    : super(
        List<QuickAccessModel>.from(
          Hive.box("user")
                  .get("quick_access", defaultValue: null)
                  ?.toList()
                  ?.map(
                    (e) =>
                        QuickAccessModel.fromJson(Map<String, dynamic>.from(e)),
                  )
                  .toList() ??
              [
                QuickAccessModel(
                  surahNumber: 112,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 113,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 114,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 2,
                  scrollIndex: 255,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 36,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 18,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 67,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 55,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 56,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
                QuickAccessModel(
                  surahNumber: 109,
                  scrollIndex: 1,
                  createdAt: DateTime.now(),
                ),
              ],
        ),
      );

  void addQuickAccess(QuickAccessModel quickAccessModel) {
    emit([quickAccessModel, ...state]);
    Hive.box("user").put("quick_access", state.map((e) => e.toJson()).toList());
  }

  void removeQuickAccess(QuickAccessModel quickAccessModel) {
    List<QuickAccessModel> copyState = ([...state]..removeWhere(
      (element) => element.surahNumber == quickAccessModel.surahNumber,
    ));
    copyState.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(copyState);
    Hive.box(
      "user",
    ).put("quick_access", copyState.map((e) => e.toJson()).toList());
  }

  void updateQuickAccess(QuickAccessModel quickAccessModel) {
    int index = state.indexWhere(
      (element) => element.surahNumber == quickAccessModel.surahNumber,
    );
    List<QuickAccessModel> copyState =
        [...state]
          ..removeAt(index)
          ..insert(index, quickAccessModel);

    copyState.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(copyState);
    Hive.box(
      "user",
    ).put("quick_access", copyState.map((e) => e.toJson()).toList());
  }
}
