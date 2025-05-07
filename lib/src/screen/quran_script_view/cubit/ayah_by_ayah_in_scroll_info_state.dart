part of 'ayah_by_ayah_in_scroll_info_cubit.dart';

class AyahByAyahInScrollInfoState {
  SurahInfoModel? surahInfoModel;
  List<String>? expandedForWordByWord;
  bool isAyahByAyah;

  AyahByAyahInScrollInfoState({
    this.surahInfoModel,
    this.expandedForWordByWord,
    required this.isAyahByAyah,
  });

  AyahByAyahInScrollInfoState copyWith({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    bool? isAyahByAyah,
  }) {
    return AyahByAyahInScrollInfoState(
      surahInfoModel: surahInfoModel ?? this.surahInfoModel,
      expandedForWordByWord:
          expandedForWordByWord ?? this.expandedForWordByWord,
      isAyahByAyah: isAyahByAyah ?? this.isAyahByAyah,
    );
  }
}

final class AyahByAyahInScrollInfoInitial extends AyahByAyahInScrollInfoState {
  AyahByAyahInScrollInfoInitial({required super.isAyahByAyah});
}
