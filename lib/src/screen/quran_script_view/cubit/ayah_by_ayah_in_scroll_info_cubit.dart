import 'package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

part 'ayah_by_ayah_in_scroll_info_state.dart';

class AyahByAyahInScrollInfoCubit extends Cubit<AyahByAyahInScrollInfoState> {
  AyahByAyahInScrollInfoCubit()
    : super(
        AyahByAyahInScrollInfoInitial(
          isAyahByAyah: Hive.box(
            'user',
          ).get('isAyahByAyah', defaultValue: true),
        ),
      );

  void setData({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    bool? isAyahByAyah,
    List<int>? pageByPageList,
  }) {
    final newState = state.copyWith(
      surahInfoModel: surahInfoModel,
      expandedForWordByWord: expandedForWordByWord,
      isAyahByAyah: isAyahByAyah,
      pageByPageList: pageByPageList,
    );
    if (AyahByAyahInScrollInfoState.toMap(newState).toString() !=
        AyahByAyahInScrollInfoState.toMap(state).toString()) {
      emit(newState);
    }
  }
}
