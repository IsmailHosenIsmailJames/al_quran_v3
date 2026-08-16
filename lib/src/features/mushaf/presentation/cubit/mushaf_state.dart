class MushafState {
  final bool isChecking;
  final bool isDownloading;
  final double downloadProgress;
  final String downloadStatus;
  final bool dataReady;
  final String baseDirPath;
  final int currentPage;

  const MushafState({
    this.isChecking = true,
    this.isDownloading = false,
    this.downloadProgress = 0.0,
    this.downloadStatus = "",
    this.dataReady = false,
    this.baseDirPath = "",
    this.currentPage = 1,
  });

  MushafState copyWith({
    bool? isChecking,
    bool? isDownloading,
    double? downloadProgress,
    String? downloadStatus,
    bool? dataReady,
    String? baseDirPath,
    int? currentPage,
  }) {
    return MushafState(
      isChecking: isChecking ?? this.isChecking,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      dataReady: dataReady ?? this.dataReady,
      baseDirPath: baseDirPath ?? this.baseDirPath,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
