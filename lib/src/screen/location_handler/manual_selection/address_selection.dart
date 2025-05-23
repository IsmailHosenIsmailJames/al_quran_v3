import "dart:convert";

import "package:al_quran_v3/src/functions/encode_decode.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/administrator_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/city_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/countries_selection.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AddressSelection extends StatefulWidget {
  const AddressSelection({super.key});

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  @override
  void initState() {
    downloadLocationResources();
    super.initState();
  }

  Future<void> downloadLocationResources() async {
    Map locationResources = jsonDecode(
      decodeBZip2String(
        await rootBundle.loadString("assets/address/cities_address.txt"),
      ),
    );
    context.read<ManualLocationSelectionCubit>().changeData(
      locationData: locationResources,
    );
  }

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<
        ManualLocationSelectionCubit,
        ManualLocationSelectionState
      >(
        builder: (context, state) {
          if (state.locationData == null) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    value: state.downloadProgress,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Downloading location resources...",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              CountriesSelection(pageController: pageController),
              AdministratorSelection(pageController: pageController),
              CitySelection(pageController: pageController),
            ],
            onPageChanged: (index) {
              context.read<ManualLocationSelectionCubit>().changeData(
                country: state.locationData!.keys.elementAt(index),
              );
            },
          );
        },
      ),
    );
  }
}
