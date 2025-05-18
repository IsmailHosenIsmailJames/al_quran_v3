import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/resources/audio/segmented_quran_recitation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/adapters.dart";

class SegmentedAudioCubit extends Cubit<ReciterInfoModel> {
  SegmentedAudioCubit() : super(getSelectedReciterModel());

  void change(ReciterInfoModel reciterInfoModel) {
    emit(reciterInfoModel);
  }
}

ReciterInfoModel getSelectedReciterModel() {
  Map metaInfo = Hive.box("segmented_quran_recitation").get("meta_data");
  int index = metaInfo["index"];
  String audioBase =
      Hive.box("segmented_quran_recitation").get("1:1")["audio_url"];
  audioBase = audioBase.substring(0, audioBase.lastIndexOf("/"));

  return ReciterInfoModel.fromMap({
    "link": audioBase,
    "name":
        segmentedQuranRecitation[index]
            .replaceAll(".json.txt", "")
            .split("/")
            .last,
    "supportWordSegmentation": true,
  });
}
