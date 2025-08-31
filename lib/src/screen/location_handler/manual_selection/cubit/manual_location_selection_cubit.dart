import "package:flutter_bloc/flutter_bloc.dart";

class ManualLocationSelectionCubit extends Cubit<ManualLocationSelectionState> {
  ManualLocationSelectionCubit() : super(ManualLocationSelectionState());

  void changeData({
    double? downloadProgress,
    String? country,
    String? adminName,
    Map? adminMap,
    String? city,
    List? cityList,
    Map? locationData,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    emit(
      state.copyWith(
        downloadProgress: downloadProgress,
        country: country,
        adminName: adminName,
        city: city,
        locationData: locationData,
        adminMap: adminMap,
        cityList: cityList,
        isLoading: isLoading,
        isError: isError,
        isSuccess: isSuccess,
      ),
    );
  }
}

class ManualLocationSelectionState {
  double? downloadProgress = 0.0;
  String? country;
  String? adminName;
  String? city;
  Map? locationData;
  Map? adminMap;
  List? cityList;
  bool isLoading = true;
  bool isError = false;
  bool isSuccess = false;

  ManualLocationSelectionState({
    this.downloadProgress,
    this.country,
    this.adminName,
    this.city,
    this.locationData,
    this.adminMap,
    this.cityList,
    this.isLoading = true,
    this.isError = false,
    this.isSuccess = false,
  });

  ManualLocationSelectionState copyWith({
    double? downloadProgress,
    String? country,
    String? adminName,
    String? city,
    Map? locationData,
    Map? adminMap,
    List? cityList,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    return ManualLocationSelectionState(
      downloadProgress: downloadProgress ?? this.downloadProgress,
      country: country ?? this.country,
      adminName: adminName ?? this.adminName,
      city: city ?? this.city,
      locationData: locationData ?? this.locationData,
      adminMap: adminMap ?? this.adminMap,
      cityList: cityList ?? this.cityList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
