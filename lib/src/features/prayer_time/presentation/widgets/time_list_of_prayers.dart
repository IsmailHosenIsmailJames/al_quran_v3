import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/hijri_date.dart";
import "package:al_quran_v3/src/features/location/data/utils/location_geocoding.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/location/presentation/screens/location_acquire_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_settings_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/fasting_sunnah_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/forbidden_prayer_times_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_hero_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_quick_settings_sheet.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_calendar_view.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_horizontal_card.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";
import "package:shimmer/shimmer.dart";

class TimeListOfPrayers extends StatefulWidget {
  const TimeListOfPrayers({super.key});

  @override
  State<TimeListOfPrayers> createState() => _TimeListOfPrayersState();
}

class _TimeListOfPrayersState extends State<TimeListOfPrayers> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndUpdate();
  }

  Future<void> _checkLocationPermissionAndUpdate() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      if (mounted) {
        context.read<LocationQiblaPrayerDataCubit>().updateLocationOnce();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final mediaQueryData = MediaQuery.of(context);
    final l10n = AppLocalizations.of(context);
    final width = mediaQueryData.size.width;
    final height = mediaQueryData.size.height;
    final isLandscapeDashboard = (width > height && width >= 600) || width >= 800;

    return BlocBuilder<
      LocationQiblaPrayerDataCubit,
      LocationQiblaPrayerDataState
    >(
      builder: (context, locationState) {
        if (locationState.latLon == null) {
          return const LocationAcquire();
        }

        return StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 30)),
          builder: (context, snapshot) {
            final DateTime now = DateTime.now();
            final PrayerTimes prayerTimes = PrayerTimes(
              date: now,
              coordinates: Coordinates(
                locationState.latLon!.latitude,
                locationState.latLon!.longitude,
              ),
              calculationParameters:
                  locationState.calculationMethod ??
                        CalculationMethodParameters.muslimWorldLeague()
                    ..madhab = locationState.madhab ?? Madhab.shafi,
            );

            if (isLandscapeDashboard) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ).copyWith(
                      top: mediaQueryData.padding.top + 8,
                      bottom: 40,
                    ),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column: Location, Date & Live Countdown
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                _buildTopHeader(
                                  context,
                                  locationState,
                                  prayerTimes,
                                  themeState,
                                  isDark,
                                  l10n,
                                ),
                                const Gap(10),
                                _buildDateAndConfigRow(
                                  context,
                                  locationState,
                                  prayerTimes,
                                  themeState,
                                  isDark,
                                  l10n,
                                ),
                                const Gap(12),
                                PrayerHeroCard(prayerTimes: prayerTimes),
                              ],
                            ),
                          ),
                          const Gap(14),

                          // Right Column: 5 Prayers Strip, Forbidden Times, Fasting Row
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                PrayerTimesHorizontalCard(prayerTimes: prayerTimes),
                                const Gap(12),
                                ForbiddenPrayerTimesCard(prayerTimes: prayerTimes),
                                const Gap(12),
                                FastingSunnahCard(prayerTimes: prayerTimes),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            // Portrait Mode Flow
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ).copyWith(top: mediaQueryData.padding.top + 10, bottom: 120),
                  children: [
                    // Top App Header: Location & Action Buttons
                    _buildTopHeader(
                      context,
                      locationState,
                      prayerTimes,
                      themeState,
                      isDark,
                      l10n,
                    ),

                    const Gap(10),

                    // Date & Quick Configuration Pill Row
                    _buildDateAndConfigRow(
                      context,
                      locationState,
                      prayerTimes,
                      themeState,
                      isDark,
                      l10n,
                    ),

                    const Gap(14),

                    // Live Next Prayer Hero Card
                    PrayerHeroCard(prayerTimes: prayerTimes),

                    const Gap(14),

                    // Compact Horizontal 5-Prayer Card
                    PrayerTimesHorizontalCard(prayerTimes: prayerTimes),

                    const Gap(14),

                    // Forbidden Prayer Times Card
                    ForbiddenPrayerTimesCard(prayerTimes: prayerTimes),

                    const Gap(14),

                    // Fasting & Voluntary 3-Column Row (Suhur End, Iftar Start, Tahajjud Start)
                    FastingSunnahCard(prayerTimes: prayerTimes),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTopHeader(
    BuildContext context,
    LocationQiblaPrayerDataState locationState,
    PrayerTimes prayerTimes,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            FluentIcons.location_24_filled,
            color: themeState.primary,
            size: 20,
          ),
          const Gap(10),
          Expanded(
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationAcquire(backToPage: true),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.location.replaceAll(":", ""),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  FutureBuilder(
                    future: locationName(
                      context,
                      LatLon(
                        latitude: locationState.latLon!.latitude,
                        longitude: locationState.latLon!.longitude,
                      ),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Shimmer.fromColors(
                          baseColor: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          highlightColor: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade100,
                          child: Container(
                            height: 16,
                            width: 140,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }
                      return Text(
                        snapshot.data ?? l10n.selectedLocation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const Gap(8),
          // Refresh GPS button
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            onPressed: () {
              context.read<LocationQiblaPrayerDataCubit>().getLocation();
            },
            icon: locationState.isGettingLocation == true
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: themeState.primary,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    FluentIcons.arrow_clockwise_24_regular,
                    color: themeState.primary,
                    size: 20,
                  ),
          ),
          // Calendar View Button
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PrayerTimesCalenderView(prayerTimes: prayerTimes),
                ),
              );
            },
            icon: Icon(
              FluentIcons.calendar_month_24_regular,
              color: themeState.primary,
              size: 20,
            ),
          ),
          // Settings Button
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PrayerSettings(prayerTimes: prayerTimes),
                ),
              );
            },
            icon: Icon(
              FluentIcons.settings_24_regular,
              color: themeState.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateAndConfigRow(
    BuildContext context,
    LocationQiblaPrayerDataState locationState,
    PrayerTimes prayerTimes,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final gregorianFormatted =
        DateFormat("d MMMM yyyy", l10n.localeName).format(DateTime.now());

    final methodEnum =
        locationState.calculationMethod?.method ??
        CalculationMethodEnum.muslimWorldLeague;
    final methodName =
        CalculationMethodParameters.fromEnum(methodEnum).fullName ??
        methodEnum.name;

    return Row(
      children: [
        // Hijri & Gregorian Date Chip
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade300,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  FluentIcons.calendar_ltr_24_regular,
                  size: 16,
                  color: themeState.primary,
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hijriDate(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        gregorianFormatted,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(8),
        // Quick Settings Trigger Pill
        InkWell(
          onTap: () => PrayerQuickSettingsSheet.show(context, prayerTimes),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: themeState.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FluentIcons.options_24_regular,
                  size: 15,
                  color: themeState.primary,
                ),
                const Gap(6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: Text(
                    methodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: themeState.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
