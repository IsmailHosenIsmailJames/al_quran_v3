import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/address_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
// import "package:geolocator/geolocator.dart";

class LocationAcquire extends StatefulWidget {
  final bool moveToDownload;

  const LocationAcquire({super.key, this.moveToDownload = false});

  @override
  State<LocationAcquire> createState() => _LocationAcquireState();
}

class _LocationAcquireState extends State<LocationAcquire> {
  bool isGPSLocationLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: widget.moveToDownload ? AppBar() : null,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.getPrayerTimesAndQibla,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    l10n.getPrayerTimesAndQiblaDescription,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Gap(30),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (context) =>
                                          ManualLocationSelectionCubit(),
                                  child: AddressSelection(
                                    moveToDownloadPage: widget.moveToDownload,
                                  ),
                                ),
                          ),
                        );
                      },
                      label: Text(l10n.selectYourCity),
                      icon: const Icon(Icons.location_city_rounded),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
