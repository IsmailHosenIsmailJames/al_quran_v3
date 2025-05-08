part of 'ayah_by_ayah_in_scroll_info_cubit.dart';

class AyahByAyahInScrollInfoState {
  SurahInfoModel? surahInfoModel;
  List<String>? expandedForWordByWord;
  bool isAyahByAyah;
  List<int>? pageByPageList;

  AyahByAyahInScrollInfoState({
    this.surahInfoModel,
    this.expandedForWordByWord,
    this.pageByPageList,
    required this.isAyahByAyah,
  });

  AyahByAyahInScrollInfoState copyWith({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    bool? isAyahByAyah,
    List<int>? pageByPageList,
  }) {
    return AyahByAyahInScrollInfoState(
      surahInfoModel: surahInfoModel ?? this.surahInfoModel,
      expandedForWordByWord:
          expandedForWordByWord ?? this.expandedForWordByWord,
      isAyahByAyah: isAyahByAyah ?? this.isAyahByAyah,
      pageByPageList: pageByPageList ?? this.pageByPageList,
    );
  }

  static Map toMap(AyahByAyahInScrollInfoState ayahByAyahInScrollInfoState) {
    return {
      'surahInfoModel': ayahByAyahInScrollInfoState.surahInfoModel?.toMap(),
      'expandedForWordByWord':
          ayahByAyahInScrollInfoState.expandedForWordByWord,
      'isAyahByAyah': ayahByAyahInScrollInfoState.isAyahByAyah,
      'pageByPageList': ayahByAyahInScrollInfoState.pageByPageList,
    };
  }
}

final class AyahByAyahInScrollInfoInitial extends AyahByAyahInScrollInfoState {
  AyahByAyahInScrollInfoInitial({required super.isAyahByAyah});
}
