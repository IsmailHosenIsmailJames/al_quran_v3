import "package:al_quran_v3/src/features/quran_resources/data/utils/location_resources_function.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:injectable/injectable.dart";

part 'manual_location_selection_cubit.freezed.dart';

@freezed
abstract class ManualLocationSelectionState with _$ManualLocationSelectionState {
  const factory ManualLocationSelectionState({
    @Default(0.0) double? downloadProgress,
    String? country,
    String? city,
    Map? locationData,
    List? cityList,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default(false) bool isSuccess,
  }) = _ManualLocationSelectionState;
}

@injectable
class ManualLocationSelectionCubit extends Cubit<ManualLocationSelectionState> {
  ManualLocationSelectionCubit() : super(const ManualLocationSelectionState());

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
        downloadProgress: downloadProgress ?? state.downloadProgress,
        country: country ?? state.country,
        city: city ?? state.city,
        locationData: locationData ?? state.locationData,
        cityList: cityList ?? state.cityList,
        isLoading: isLoading ?? state.isLoading,
        isError: isError ?? state.isError,
        isSuccess: isSuccess ?? state.isSuccess,
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
