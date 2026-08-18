import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_state.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class AyahByAyahInScrollInfoCubit extends Cubit<AyahByAyahInScrollInfoState> {
  AyahByAyahInScrollInfoCubit()
    : super(
        AyahByAyahInScrollInfoState(
          isAyahByAyah: Hive.box(
            "user",
          ).get("isAyahByAyah", defaultValue: true),
        ),
      );

  void toggleView() {
    setData(isAyahByAyah: !state.isAyahByAyah);
  }

  void toggleWordByWord(String ayahKey) {
    final List<String> list =
        List<String>.from(state.expandedForWordByWord ?? []);
    if (list.contains(ayahKey)) {
      list.remove(ayahKey);
    } else {
      list.add(ayahKey);
    }
    setData(expandedForWordByWord: list);
  }

  void setData({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    bool? isAyahByAyah,
    List<int>? pageByPageList,
    dynamic dropdownAyahKey,
    bool clearDropdownAyahKey = false,
  }) {
    final newState = state.copyWith(
      surahInfoModel: surahInfoModel ?? state.surahInfoModel,
      expandedForWordByWord:
          expandedForWordByWord ?? state.expandedForWordByWord,
      isAyahByAyah: isAyahByAyah ?? state.isAyahByAyah,
      pageByPageList: pageByPageList ?? state.pageByPageList,
      dropdownAyahKey: clearDropdownAyahKey
          ? null
          : (dropdownAyahKey ?? state.dropdownAyahKey),
    );
    if (newState != state) {
      emit(newState);
    }
    if (isAyahByAyah != null) {
      Hive.box("user").put("isAyahByAyah", isAyahByAyah);
    }
  }
}
