import 'package:al_quran_v3/src/audio/model/ayahkey_management.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AyahKeyCubit extends Cubit<AyahKeyManagement> {
  AyahKeyCubit() : super(AyahKeyManagement());

  void changeCurrentAyahKey(String ayahKey) {
    emit(state.copyWith(current: ayahKey));
  }

  void changeData(AyahKeyManagement ayahData) {
    emit(ayahData);
  }
}
