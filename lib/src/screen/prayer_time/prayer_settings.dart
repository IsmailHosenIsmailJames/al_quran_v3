import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../widget/prayers/prayer_calculation_method_info_widget.dart";
import "../location_handler/cubit/location_data_qibla_data_cubit.dart";
import "../location_handler/model/location_data_qibla_data_state.dart";

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({super.key});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.prayerSettings)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 80,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.calculationMethod, style: titleStyle),
                SizedBox(
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    onPressed: () async {
                      var state =
                          context.read<LocationQiblaPrayerDataCubit>().state;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DownloadDataForPrayerView(
                                lat: state.latLon!.latitude,
                                long: state.latLon!.latitude,
                                showCalculationMethodPopupAtOnInit: true,
                                moveToDownload: true,
                              ),
                        ),
                      );
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
          ],
        ),
      ),
    );
  }
}
