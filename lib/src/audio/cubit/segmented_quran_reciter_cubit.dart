import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

class SegmentedQuranReciterCubit extends Cubit<ReciterInfoModel> {
  SegmentedQuranReciterCubit()
    : super(
        ReciterInfoModel.fromMap(
          Map<String, dynamic>.from(
            Hive.box("segmented_quran_recitation").get("meta_data") ??
                getSegmentsSupportedReciters().first.toMap(),
          ),
        ),
      );

  void changeReciter(ReciterInfoModel reciter) async {
    if (reciter.segmentsUrl == null) {
      assert(true, "Segments is not supported");
    }
    await Hive.box(
      "segmented_quran_recitation",
    ).put("meta_data", reciter.toMap());
    emit(reciter);
  }
}

List<ReciterInfoModel> getSegmentsSupportedReciters() {
  List<ReciterInfoModel> recitations =
      recitationsInfoList.map((e) => ReciterInfoModel.fromMap(e)).toList();
  recitations =
      recitations.where((element) => element.segmentsUrl != null).toList();
  recitations =
      recitations
          .map((e) => e.copyWith(supportWordSegmentation: true))
          .toList();
  return recitations;
}
