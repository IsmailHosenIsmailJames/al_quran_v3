part of "ayah_by_ayah_in_scroll_info_cubit.dart";

class AyahByAyahInScrollInfoState {
  SurahInfoModel? surahInfoModel;
  List<String>? expandedForWordByWord;
  bool isAyahByAyah;
  List<int>? pageByPageList;
  dynamic dropdownAyahKey;

  AyahByAyahInScrollInfoState({
    this.surahInfoModel,
    this.expandedForWordByWord,
    this.pageByPageList,
    required this.isAyahByAyah,
    this.dropdownAyahKey,
  });

  AyahByAyahInScrollInfoState copyWith({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    bool? isAyahByAyah,
    List<int>? pageByPageList,
    dynamic dropdownAyahKey,
    bool? isScrollingToDown,
  }) {
    return AyahByAyahInScrollInfoState(
      surahInfoModel: surahInfoModel ?? this.surahInfoModel,
      expandedForWordByWord:
          expandedForWordByWord ?? this.expandedForWordByWord,
      isAyahByAyah: isAyahByAyah ?? this.isAyahByAyah,
      pageByPageList: pageByPageList ?? this.pageByPageList,
      dropdownAyahKey: dropdownAyahKey ?? this.dropdownAyahKey,
    );
  }

  static Map toMap(AyahByAyahInScrollInfoState ayahByAyahInScrollInfoState) {
    return {
      "surahInfoModel": ayahByAyahInScrollInfoState.surahInfoModel?.toMap(),
      "expandedForWordByWord":
          ayahByAyahInScrollInfoState.expandedForWordByWord,
      "isAyahByAyah": ayahByAyahInScrollInfoState.isAyahByAyah,
      "pageByPageList": ayahByAyahInScrollInfoState.pageByPageList,
      "dropdownAyahKey": ayahByAyahInScrollInfoState.dropdownAyahKey,
    };
  }

  // helper for list equality without imports
  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AyahByAyahInScrollInfoState) return false;
    return other.surahInfoModel == surahInfoModel &&
        _listEquals(other.expandedForWordByWord, expandedForWordByWord) &&
        other.isAyahByAyah == isAyahByAyah &&
        _listEquals(other.pageByPageList, pageByPageList) &&
        other.dropdownAyahKey == dropdownAyahKey;
  }

  @override
  int get hashCode => Object.hash(
    surahInfoModel,
    Object.hashAll(expandedForWordByWord ?? const []),
    isAyahByAyah,
    Object.hashAll(pageByPageList ?? const []),
    dropdownAyahKey,
  );
}
