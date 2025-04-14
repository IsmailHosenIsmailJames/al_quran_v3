import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:bloc/bloc.dart';

part 'ayah_by_ayah_in_scroll_info_state.dart';

class AyahByAyahInScrollInfoCubit extends Cubit<AyahByAyahInScrollInfoState> {
  AyahByAyahInScrollInfoCubit() : super(AyahByAyahInScrollInfoInitial());

  void setData(SurahInfoModel surahInfoModel) {
    emit(AyahByAyahInScrollInfoState()..surahInfoModel = surahInfoModel);
  }
}
