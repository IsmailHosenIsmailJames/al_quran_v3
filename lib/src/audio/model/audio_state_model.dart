import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/audio/resources/quran_com/all_recitations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';

class AudioStateModel {
  String? ayahKey;
  AudioStateModel({this.ayahKey});

  ReciterInfoModel reciterInfoModel = ReciterInfoModel.fromMap(
    Hive.box('user').get('reciter', defaultValue: null) ??
        recitationsListOfQuranCom[0],
  );
  bool isPlaying = false;
  bool expanded = false;
  AudioPlayer audioPlayer = AudioPlayer();
}
