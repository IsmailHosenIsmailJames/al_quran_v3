import 'package:freezed_annotation/freezed_annotation.dart';

part 'mushaf_state.freezed.dart';

@freezed
abstract class MushafState with _$MushafState {
  const factory MushafState({
    @Default(true) bool isChecking,
    @Default(false) bool isDownloading,
    @Default(0.0) double downloadProgress,
    @Default("") String downloadStatus,
    @Default(false) bool dataReady,
    @Default("") String baseDirPath,
    @Default(1) int currentPage,
  }) = _MushafState;
}
