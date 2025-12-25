import "dart:convert";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/utils/encode_decode.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/administrator_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/city_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/pages/countries_selection.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:http/http.dart" as http;

import "../../../theme/controller/theme_cubit.dart";

class AddressSelection extends StatefulWidget {
  final bool backToPage;
  const AddressSelection({super.key, this.backToPage = false});

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
    context.read<ManualLocationSelectionCubit>().changeData(
      isLoading: true,
      isError: false,
      isSuccess: false,
    );
    try {
      final response = await http.get(
        Uri.parse("${ApisUrls.base}locations/compressed/worldcities.json.txt"),
      );

      if (response.statusCode == 200) {
        Map locationResources = jsonDecode(decodeBZip2String(response.body));
        context.read<ManualLocationSelectionCubit>().changeData(
          locationData: locationResources,
          isLoading: false,
          isError: false,
          isSuccess: true,
        );
      } else {
        context.read<ManualLocationSelectionCubit>().changeData(
          isLoading: false,
          isError: true,
          isSuccess: false,
        );
      }
    } catch (e) {
      context.read<ManualLocationSelectionCubit>().changeData(
        isLoading: false,
        isError: true,
        isSuccess: false,
      );
    }
  }

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body:
          BlocBuilder<
            ManualLocationSelectionCubit,
            ManualLocationSelectionState
          >(
            builder: (context, state) {
              if (state.isLoading) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: state.downloadProgress,
                        color: context.read<ThemeCubit>().state.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.downloadingLocationResources,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.checkYourInternetConnection),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: downloadLocationResources,
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                );
              } else if (state.isSuccess) {
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
              }
              return const SizedBox.shrink();
            },
          ),
    );
  }
}
