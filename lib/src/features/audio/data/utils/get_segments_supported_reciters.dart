import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/resources/recitations.dart";

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
