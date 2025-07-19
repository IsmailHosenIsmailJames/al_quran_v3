import "package:flutter_bloc/flutter_bloc.dart";

class QuickAccessCubit extends Cubit<List<QuickAccessModel>> {
  QuickAccessCubit()
    : super([
        QuickAccessModel(surahNumber: 112),
        QuickAccessModel(surahNumber: 113),
        QuickAccessModel(surahNumber: 114),
        QuickAccessModel(surahNumber: 2, scrollIndex: 255),
        QuickAccessModel(surahNumber: 36),
        QuickAccessModel(surahNumber: 18),
        QuickAccessModel(surahNumber: 67),
        QuickAccessModel(surahNumber: 55),
        QuickAccessModel(surahNumber: 56),
        QuickAccessModel(surahNumber: 109),
      ]);
}

class QuickAccessModel {
  int surahNumber;
  int? scrollIndex;

  QuickAccessModel({required this.surahNumber, this.scrollIndex});

  Map<String, dynamic> toMap() {
    return {"surahNumber": surahNumber, "ayahs": scrollIndex};
  }

  factory QuickAccessModel.fromMap(Map<String, dynamic> map) {
    return QuickAccessModel(
      surahNumber: map["surahNumber"],
      scrollIndex: map["scrollIndex"],
    );
  }
}
