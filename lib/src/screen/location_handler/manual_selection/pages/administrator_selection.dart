import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class AdministratorSelection extends StatefulWidget {
  final PageController pageController;
  const AdministratorSelection({super.key, required this.pageController});

  @override
  State<AdministratorSelection> createState() => _AdministratorSelectionState();
}

class _AdministratorSelectionState extends State<AdministratorSelection> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                Text(
                  l10n.selectYourAdministratorTitle,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SearchBar(
              hintText: l10n.searchForAdministratorHint,
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
                if (state.adminMap == null) {
                  return Text(l10n.somethingWentWrongError);
                }
                List listOfCountry = state.adminMap!.keys.toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: listOfCountry.length,
                  itemBuilder: (context, index) {
                    String adminName = listOfCountry[index];

                    if (adminName.toLowerCase().contains(
                      controller.text.toLowerCase().trim(),
                    )) {
                      return ListTile(
                        title: Text(adminName),
                        onTap: () {
                          context
                              .read<ManualLocationSelectionCubit>()
                              .changeData(
                                cityList: state.adminMap![adminName],
                                adminName: adminName,
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
