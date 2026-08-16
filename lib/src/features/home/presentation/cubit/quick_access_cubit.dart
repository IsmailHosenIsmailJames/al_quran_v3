import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class QuickAccessCubit extends Cubit<List<QuickAccessModel>> {
  QuickAccessCubit()
    : super(
        List<QuickAccessModel>.from(
          Hive.box("user")
                  .get("quick_access", defaultValue: null)
                  ?.toList()
                  ?.map(
                    (e) =>
                        QuickAccessModel.fromMap(Map<String, dynamic>.from(e)),
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
    Hive.box("user").put("quick_access", state.map((e) => e.toMap()).toList());
  }

  void removeQuickAccess(QuickAccessModel quickAccessModel) {
    List<QuickAccessModel> copyState = ([...state]..removeWhere(
      (element) => element.surahNumber == quickAccessModel.surahNumber,
    ));
    copyState.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(copyState);
    Hive.box(
      "user",
    ).put("quick_access", copyState.map((e) => e.toMap()).toList());
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
    ).put("quick_access", copyState.map((e) => e.toMap()).toList());
  }
}

class QuickAccessModel {
  int surahNumber;
  int? scrollIndex;
  DateTime createdAt;

  QuickAccessModel({
    required this.surahNumber,
    this.scrollIndex,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "surahNumber": surahNumber,
      "scrollIndex": scrollIndex,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory QuickAccessModel.fromMap(Map<String, dynamic> map) {
    return QuickAccessModel(
      surahNumber: map["surahNumber"],
      scrollIndex: map["scrollIndex"],
      createdAt:
          map["createdAt"] == null
              ? DateTime.now()
              : DateTime.parse(map["createdAt"]),
    );
  }
}
