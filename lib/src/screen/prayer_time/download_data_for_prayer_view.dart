import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../widget/prayers/adress_from_lat_lon.dart";
import "../../widget/prayers/prayer_calculation_method_info_widget.dart";
import "../../widget/prayers/select_calculation_method.dart";
import "../location_handler/cubit/location_data_qibla_data_cubit.dart";

class DownloadDataForPrayerView extends StatefulWidget {
  final double lat;
  final double long;
  final bool moveToDownload;
  final bool showCalculationMethodPopupAtOnInit;

  const DownloadDataForPrayerView({
    super.key,
    required this.lat,
    required this.long,
    this.moveToDownload = false,
    this.showCalculationMethodPopupAtOnInit = false,
  });

  @override
  State<DownloadDataForPrayerView> createState() =>
      _DownloadDataForPrayerViewState();
}

class _DownloadDataForPrayerViewState extends State<DownloadDataForPrayerView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.showCalculationMethodPopupAtOnInit) {
        showCalculationMethodPopup(context, (calculationMethod) {
          context.read<LocationQiblaPrayerDataCubit>().saveCalculationMethod(
            calculationMethod,
          );
          Navigator.pop(context);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: widget.moveToDownload ? AppBar() : null,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(roundedRadius),
                      border: Border.all(
                        color: context.read<ThemeCubit>().state.secondary,
                      ),
                    ),
                    child: Text(
                      l10n.notificationScheduleWarning,
                      style: TextStyle(
                        color: context.read<ThemeCubit>().state.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Gap(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.address,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                          ),
                          onPressed: () async {
                            if (widget.moveToDownload) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => LocationAcquire(
                                        moveToDownload: widget.moveToDownload,
                                      ),
                                ),
                              );
                            } else {
                              context
                                  .read<LocationQiblaPrayerDataCubit>()
                                  .saveLocationData(
                                    null,
                                    save: !widget.moveToDownload,
                                  );
                            }
                          },
                          child: Text(l10n.change),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  getAddressView(
                    context: context,
                    lat: widget.lat,
                    long: widget.long,
                  ),
                  const Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.calculationMethod,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                          ),
                          onPressed: () async {
                            await showCalculationMethodPopup(context, (
                              calculationMethod,
                            ) {
                              context
                                  .read<LocationQiblaPrayerDataCubit>()
                                  .saveCalculationMethod(calculationMethod);

                              Navigator.pop(context);
                            });
                          },
                          child: Text(l10n.change),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  BlocBuilder<
                    LocationQiblaPrayerDataCubit,
                    LocationQiblaPrayerDataState
                  >(
                    builder: (context, state) {
                      return getPrayerCalculationMethodInfoWidget(
                        context,
                        state.calculationMethod!,
                      );
                    },
                  ),
                  const Gap(30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () async {
                        var cubit =
                            context.read<LocationQiblaPrayerDataCubit>();
                        cubit.changePrayerTimeDownloading(true);
                        await PrayersTimeFunction.downloadPrayerDataFromAPI(
                          lat: widget.lat,
                          lon: widget.long,
                          calculationMethod: cubit.state.calculationMethod!,
                        );
                        cubit.saveLocationData(
                          LatLon(latitude: widget.lat, longitude: widget.long),
                          save: true,
                        );
                        cubit.saveCalculationMethod(
                          cubit.state.calculationMethod,
                          save: true,
                        );
                        await cubit.alignWithDatabase();

                        await cubit.checkPrayerDataExits();
                        if (widget.moveToDownload) {
                          Navigator.pop(context);
                        }
                        cubit.changePrayerTimeDownloading(false);
                      },
                      icon: BlocBuilder<
                        LocationQiblaPrayerDataCubit,
                        LocationQiblaPrayerDataState
                      >(
                        builder: (context, state) {
                          return state.isPrayerTimeDownloading == true
                              ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                              : const Icon(
                                FluentIcons.arrow_download_24_filled,
                              );
                        },
                      ),
                      label: Text(l10n.downloadPrayerTime),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
