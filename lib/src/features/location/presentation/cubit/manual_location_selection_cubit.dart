import "package:al_quran_v3/src/utils/quran_resources/location_resources_function.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ManualLocationSelectionCubit extends Cubit<ManualLocationSelectionState> {
  ManualLocationSelectionCubit() : super(ManualLocationSelectionState());

  void changeData({
    double? downloadProgress,
    String? country,
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
        city: city,
        locationData: locationData,
        cityList: cityList,
        isLoading: isLoading,
        isError: isError,
        isSuccess: isSuccess,
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (state.locationData != null) return; // already loaded

    changeData(isLoading: true, isError: false, isSuccess: false);
    Map? data = await LocationResourcesFunction.loadLocationResources();
    
    if (data == null) {
      // Data not found locally, download it
      bool downloaded = await LocationResourcesFunction.downloadLocationResources(context: context);
      if (downloaded) {
        data = await LocationResourcesFunction.loadLocationResources();
      }
    }

    if (data != null) {
      changeData(
        locationData: data,
        isLoading: false,
        isSuccess: true,
        isError: false,
      );
    } else {
      changeData(
        isLoading: false,
        isSuccess: false,
        isError: true,
      );
    }
  }

  void selectCountry(String country) {
    if (state.locationData == null) return;
    
    // Flatten cities from all admin regions of the country
    final countryData = state.locationData![country];
    List flattenedCities = [];
    if (countryData is Map) {
      for (var adminData in countryData.values) {
        if (adminData is List) {
          flattenedCities.addAll(adminData);
        }
      }
    }
    
    // Sort cities alphabetically
    flattenedCities.sort((a, b) => (a['city'] as String).compareTo(b['city'] as String));

    changeData(
      country: country,
      city: null, // reset city
      cityList: flattenedCities,
    );
  }

  void selectCity(String city) {
    changeData(city: city);
  }
}

class ManualLocationSelectionState {
  double? downloadProgress = 0.0;
  String? country;
  String? city;
  Map? locationData;
  List? cityList;
  bool isLoading = false;
  bool isError = false;
  bool isSuccess = false;

  ManualLocationSelectionState({
    this.downloadProgress,
    this.country,
    this.city,
    this.locationData,
    this.cityList,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
  });

  ManualLocationSelectionState copyWith({
    double? downloadProgress,
    String? country,
    String? city,
    Map? locationData,
    List? cityList,
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
  }) {
    return ManualLocationSelectionState(
      downloadProgress: downloadProgress ?? this.downloadProgress,
      country: country ?? this.country,
      city: city ?? this.city,
      locationData: locationData ?? this.locationData,
      cityList: cityList ?? this.cityList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
