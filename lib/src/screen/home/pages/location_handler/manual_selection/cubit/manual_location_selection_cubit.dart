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

  ManualLocationSelectionState({
    this.downloadProgress,
    this.country,
    this.adminName,
    this.city,
    this.locationData,
    this.adminMap,
    this.cityList,
  });

  ManualLocationSelectionState copyWith({
    double? downloadProgress,
    String? country,
    String? adminName,
    String? city,
    Map? locationData,
    Map? adminMap,
    List? cityList,
  }) {
    return ManualLocationSelectionState(
      downloadProgress: downloadProgress ?? this.downloadProgress,
      country: country ?? this.country,
      adminName: adminName ?? this.adminName,
      city: city ?? this.city,
      locationData: locationData ?? this.locationData,
      adminMap: adminMap ?? this.adminMap,
      cityList: cityList ?? this.cityList,
    );
  }
}
