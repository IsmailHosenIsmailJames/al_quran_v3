import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:flex_color_picker/flex_color_picker.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../theme/colors/app_colors.dart";
import "../../theme/values/values.dart";
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
    TextStyle titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Prayer Settings")),
      body: ListView(
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
              Text("Calculation Method: ", style: titleStyle),
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
                  child: const Text("Change"),
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
                state.calculationMethod!,
              );
            },
          ),
          const Gap(20),
          Text("Reminder Settings", style: titleStyle),
          const Gap(5),
          getDropPrayerSettings(),
        ],
      ),
    );
  }

  Widget getDropPrayerSettings() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
        builder: (context, prayerReminderState) {
          return Column(
            children: List.generate(PrayerModelTimesType.values.length, (
              index,
            ) {
              PrayerModelTimesType currentPrayerType =
                  PrayerModelTimesType.values[index];

              PrayerReminderType currentPrayerReminderType =
                  prayerReminderState
                      .previousReminderModes[currentPrayerType] ??
                  PrayerReminderType.alarm;

              return Container(
                decoration: BoxDecoration(
                  color:
                      index.isEven
                          ? AppColors.primaryShade100
                          : AppColors.primaryShade200,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.only(left: 10, right: 5),
                margin: const EdgeInsets.only(bottom: 2, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      currentPrayerType.name.capitalize,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButton(
                      value: currentPrayerReminderType,
                      alignment: Alignment.centerRight,
                      items: List.generate(
                        PrayerReminderType.values.length,
                        (index) => DropdownMenuItem(
                          value: PrayerReminderType.values[index],
                          child: Row(
                            children: <Widget>[
                              Icon(
                                PrayerReminderType.values[index] ==
                                        PrayerReminderType.notification
                                    ? FluentIcons.alert_on_24_regular
                                    : Icons.alarm_rounded,
                              ),
                              const Gap(10),
                              Text(
                                PrayerReminderType
                                    .values[index]
                                    .name
                                    .capitalize,
                              ),
                              const Gap(7),
                            ],
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<PrayerReminderCubit>().setReminderMode(
                          ReminderTypeWithPrayModel(
                            prayerTimesType: currentPrayerType,
                            reminderType: value!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
