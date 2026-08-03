import "dart:developer";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/platform_services.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:geolocator/geolocator.dart";

class LocationAcquire extends StatefulWidget {
  final bool backToPage;

  const LocationAcquire({super.key, this.backToPage = false});

  @override
  State<LocationAcquire> createState() => _LocationAcquireState();
}

class _LocationAcquireState extends State<LocationAcquire> {
  bool isGPSLocationLoading = false;
  bool isManualMode = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.read<ThemeCubit>().state;

    return BlocProvider(
      create: (context) => ManualLocationSelectionCubit(),
      child: Scaffold(
        appBar: widget.backToPage ? AppBar() : null,
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

                    if (!(platformOwn == PlatformOwn.isLinux))
                      _buildAllowLocationCard(context, themeState, l10n),

                    if (!(platformOwn == PlatformOwn.isLinux)) const Gap(15),

                    _buildManualLocationCard(context, themeState, l10n),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllowLocationCard(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations l10n,
  ) {
    return InkWell(
      onTap: () async {
        setState(() {
          isManualMode = false;
          isGPSLocationLoading = true;
        });
        try {
          bool isServiceAvailable = await Geolocator.isLocationServiceEnabled();
          if (!isServiceAvailable) {
            Fluttertoast.showToast(msg: l10n.pleaseEnableLocationService);
            await Geolocator.openLocationSettings();
          }
          LocationPermission permission = await Geolocator.checkPermission();
          if (!(permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always)) {
            permission = await Geolocator.requestPermission();
          }
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            Position position = await Geolocator.getCurrentPosition();
            context.read<LocationQiblaPrayerDataCubit>().saveLocationData(
                  LatLon(
                    latitude: position.latitude,
                    longitude: position.longitude,
                  ),
                  save: !widget.backToPage,
                );
            setState(() {
              isGPSLocationLoading = false;
            });
            if (widget.backToPage) {
              Navigator.pop(context);
            }
          } else {
            setState(() {
              isGPSLocationLoading = false;
            });
          }
        } catch (e) {
          setState(() {
            isGPSLocationLoading = false;
          });
          log(e.toString());
        }
      },
      borderRadius: BorderRadius.circular(roundedRadius),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: !isManualMode
              ? themeState.primaryShade200.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(roundedRadius),
          border: Border.all(
            color: !isManualMode
                ? themeState.primaryShade200
                : themeState.mutedGray,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isGPSLocationLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: themeState.primary,
                    ),
                  )
                : Icon(Icons.gps_fixed, color: themeState.primary),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.allowLocation,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Gap(5),
                  Text(
                    l10n.allowLocationDescription,
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualLocationCard(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<ManualLocationSelectionCubit, ManualLocationSelectionState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            setState(() {
              isManualMode = true;
            });
            context.read<ManualLocationSelectionCubit>().loadData(context);
          },
          borderRadius: BorderRadius.circular(roundedRadius),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isManualMode
                  ? themeState.primaryShade200.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(roundedRadius),
              border: Border.all(
                color: isManualMode
                    ? themeState.primaryShade200
                    : themeState.mutedGray,
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(FluentIcons.location_24_regular, color: themeState.primary),
                    const Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.manualLocation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            l10n.manualLocationDescription,
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                    if (isManualMode)
                      Icon(Icons.check_circle, color: themeState.primary),
                  ],
                ),
                if (isManualMode) ...[
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(roundedRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.selectLocation,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const Gap(15),
                        if (state.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (state.isError)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                context.read<ManualLocationSelectionCubit>().loadData(context);
                              },
                              child: Text(l10n.retry),
                            ),
                          )
                        else ...[
                          _buildDropdownField(
                            context: context,
                            label: state.country ?? l10n.selectCountry,
                            onTap: () {
                              _showCountrySelection(context);
                            },
                          ),
                          const Gap(10),
                          _buildDropdownField(
                            context: context,
                            label: state.city ?? l10n.selectCity,
                            enabled: state.country != null,
                            onTap: () {
                              _showCitySelection(context);
                            },
                          ),
                        ],
                      ],
                    ),
                  )
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(roundedRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: context.read<ThemeCubit>().state.mutedGray),
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: enabled ? null : Theme.of(context).hintColor,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: enabled ? null : Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showCountrySelection(BuildContext parentContext) {
    final cubit = parentContext.read<ManualLocationSelectionCubit>();
    final l10n = AppLocalizations.of(parentContext);
    final themeState = parentContext.read<ThemeCubit>().state;
    
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Theme.of(parentContext).scaffoldBackgroundColor,
      useSafeArea: true,
      builder: (context) {
        return _SelectionList(
          title: l10n.selectCountry,
          hint: l10n.searchForACountry,
          items: cubit.state.locationData!.keys.toList(),
          themeState: themeState,
          onSelected: (selected) {
            cubit.selectCountry(selected as String);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showCitySelection(BuildContext parentContext) {
    final cubit = parentContext.read<ManualLocationSelectionCubit>();
    final l10n = AppLocalizations.of(parentContext);
    final themeState = parentContext.read<ThemeCubit>().state;
    
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Theme.of(parentContext).scaffoldBackgroundColor,
      useSafeArea: true,
      builder: (context) {
        return _SelectionList(
          title: l10n.selectCity,
          hint: l10n.searchForACity,
          items: cubit.state.cityList!,
          isCity: true,
          themeState: themeState,
          onSelected: (selected) {
            final cityMap = selected as Map;
            cubit.selectCity(cityMap['city'] as String);
            
            LatLon latLon = LatLon(
              latitude: double.parse(cityMap["lat"]),
              longitude: double.parse(cityMap["lng"]),
            );
            parentContext
                .read<LocationQiblaPrayerDataCubit>()
                .saveLocationData(latLon, save: true);

            Navigator.pop(context);
            if (widget.backToPage) {
              Navigator.pop(parentContext);
            }
          },
        );
      },
    );
  }
}

class _SelectionList extends StatefulWidget {
  final String title;
  final String hint;
  final List items;
  final bool isCity;
  final ThemeState themeState;
  final Function(dynamic) onSelected;

  const _SelectionList({
    required this.title,
    required this.hint,
    required this.items,
    this.isCity = false,
    required this.themeState,
    required this.onSelected,
  });

  @override
  State<_SelectionList> createState() => _SelectionListState();
}

class _SelectionListState extends State<_SelectionList> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items.where((item) {
      final name = widget.isCity ? item['city'] as String : item as String;
      return name.toLowerCase().contains(searchQuery.toLowerCase().trim());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              const Gap(15),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SearchBar(
            hintText: widget.hint,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            elevation: const WidgetStatePropertyAll(0),
            leading: const Icon(Icons.search),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
                side: BorderSide(color: widget.themeState.mutedGray),
              ),
            ),
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
        const Gap(10),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              final name = widget.isCity ? item['city'] as String : item as String;
              
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                title: Text(name),
                onTap: () => widget.onSelected(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
