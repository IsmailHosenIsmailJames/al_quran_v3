import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/find_cloest_calculation_method.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class CitySelection extends StatefulWidget {
  final bool moveToDownload;
  final PageController pageController;

  const CitySelection({
    super.key,
    required this.pageController,
    this.moveToDownload = false,
  });

  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Gap(15),
                const Text("Select Your City", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SearchBar(
              hintText: "Search for a city",
              controller: controller,
              onChanged: (value) {
                setState(() {});
              },
              elevation: const WidgetStatePropertyAll(0),
              leading: const Icon(Icons.search),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<
              ManualLocationSelectionCubit,
              ManualLocationSelectionState
            >(
              builder: (context, state) {
                if (state.cityList == null) {
                  return const Text("Something went wrong");
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.cityList!.length,
                  itemBuilder: (context, index) {
                    String cityName = state.cityList![index]["city"];

                    if (cityName.toLowerCase().contains(
                      controller.text.toLowerCase().trim(),
                    )) {
                      return ListTile(
                        title: Text(cityName),
                        onTap: () {
                          LatLon latLon = LatLon(
                            latitude: double.parse(
                              state.cityList![index]["lat"],
                            ),
                            longitude: double.parse(
                              state.cityList![index]["lng"],
                            ),
                          );
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .saveLocationData(
                                latLon,
                                save: !widget.moveToDownload,
                              );
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .saveCalculationMethod(
                                findClosestCalculationMethod(
                                  latLon.latitude,
                                  latLon.longitude,
                                ),
                                save: !widget.moveToDownload,
                              );

                          Navigator.pop(context);
                          if (widget.moveToDownload) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DownloadDataForPrayerView(
                                      lat: latLon.latitude,
                                      long: latLon.longitude,
                                      moveToDownload: widget.moveToDownload,
                                    ),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
