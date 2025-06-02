import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class CountriesSelection extends StatefulWidget {
  final PageController pageController;
  const CountriesSelection({super.key, required this.pageController});

  @override
  State<CountriesSelection> createState() => _CountriesSelectionState();
}

class _CountriesSelectionState extends State<CountriesSelection> {
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
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Gap(15),
                const Text(
                  "Select Your Country",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SearchBar(
              hintText: "Search for a country",
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
                if (state.locationData == null) {
                  return const Text("Something went wrong");
                }
                List listOfCountry = state.locationData!.keys.toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: listOfCountry.length,
                  itemBuilder: (context, index) {
                    String countryName = listOfCountry[index];

                    if (countryName.toLowerCase().contains(
                      controller.text.toLowerCase().trim(),
                    )) {
                      return ListTile(
                        title: Text(countryName),
                        onTap: () {
                          context
                              .read<ManualLocationSelectionCubit>()
                              .changeData(
                                adminMap: state.locationData![countryName],
                                country: countryName,
                              );
                          widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
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
