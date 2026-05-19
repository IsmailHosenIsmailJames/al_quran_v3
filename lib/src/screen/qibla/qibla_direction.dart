import "package:al_quran_v3/l10n/app_localizations.dart";
import "dart:async";
import "dart:math" as math;

import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/qibla/compass_view/compass_view.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_compass/flutter_compass.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:vector_math/vector_math.dart" as vector;
import "package:vibration/vibration.dart";

const double kaabaLatDegrees = 21.422487;
const double kaabaLonDegrees = 39.826206;

class QiblaDirection extends StatefulWidget {
  const QiblaDirection({super.key});

  @override
  State<QiblaDirection> createState() => _QiblaDirectionState();
}

class _QiblaDirectionState extends State<QiblaDirection> {
  late bool hasVibrator;
  late bool hasSupportAmplitude;
  late AppLocalizations appLocalizations;
  @override
  void initState() {
    initStateCall();
    super.initState();
  }

  Future<void> initStateCall() async {
    hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      hasSupportAmplitude = await Vibration.hasCustomVibrationsSupport();
    }
  }

  bool disposed = false;
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandScape = width > height;
    appLocalizations = AppLocalizations.of(context);
    return Center(
      child:
          BlocBuilder<
            LocationQiblaPrayerDataCubit,
            LocationQiblaPrayerDataState
          >(
            builder: (context, state) {
              LocationQiblaPrayerDataState? dataState = context
                  .read<LocationQiblaPrayerDataCubit>()
                  .state;
              Widget compassView = const SizedBox();
              if (dataState.kaabaAngle != null) {
                compassView = SizedBox(
                  width: isLandScape ? height * 0.6 : width * 0.8,
                  height: isLandScape ? height * 0.6 : width * 0.8,
                  child: CustomPaint(
                    painter: CompassView(
                      themeState,
                      context: context,
                      kaabaAngle: dataState.kaabaAngle!,
                      appLocalizations: appLocalizations,
                    ),
                  ),
                );
              }
              return state.latLon == null
                  ? const LocationAcquire()
                  : state.kaabaAngle == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: themeState.primary,
                        backgroundColor: context
                            .read<ThemeCubit>()
                            .state
                            .primaryShade100,
                      ),
                    )
                  : StreamBuilder<CompassEvent>(
                      stream: FlutterCompass.events?.timeout(
                        const Duration(seconds: 2),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return _buildSensorUnavailableView(
                            context,
                            themeState,
                            appLocalizations,
                            state.kaabaAngle!,
                          );
                        }
                        if (snapshot.hasData) {
                          double? direction = snapshot.data?.heading;
                          if (direction == null) {
                            return _buildSensorUnavailableView(
                              context,
                              themeState,
                              appLocalizations,
                              state.kaabaAngle!,
                            );
                          }
                          if (direction < 0) {
                            direction = 180 + (180 - direction.abs());
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Gap(20),
                              Center(
                                child: getCompassRotationView(
                                  direction,
                                  state.kaabaAngle!,
                                  compassView,
                                  themeState,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: themeState.primary,
                              backgroundColor: themeState.primaryShade100,
                            ),
                          );
                        }
                      },
                    );
            },
          ),
    );
  }

  Widget _buildSensorUnavailableView(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    double kaabaAngle,
  ) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandScape = width > height;

    Widget dialWidget = _buildStaticDial(
      context,
      themeState,
      appLocalizations,
      kaabaAngle,
      isLandScape ? height * 0.45 : width * 0.6,
    );

    Widget detailsWidget = _buildDetailsCard(
      context,
      themeState,
      appLocalizations,
      kaabaAngle,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: isLandScape
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 4, child: Center(child: dialWidget)),
                    const Gap(32),
                    Expanded(flex: 5, child: detailsWidget),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dialWidget,
                    const Gap(32),
                    detailsWidget,
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStaticDial(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    double kaabaAngle,
    double size,
  ) {
    double radius = size / 2;
    double kaabaIconRadius = radius - 24;
    double thetaRad = vector.radians(270 + kaabaAngle);
    double iconSize = 36;
    double posX = radius + kaabaIconRadius * math.cos(thetaRad) - (iconSize / 2);
    double posY = radius + kaabaIconRadius * math.sin(thetaRad) - (iconSize / 2);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // The main compass outer circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeState.primaryShade200.withValues(alpha: 0.05),
              border: Border.all(
                color: themeState.primaryShade200.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: themeState.primary.withValues(alpha: 0.03),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CustomPaint(
              painter: CompassView(
                themeState,
                context: context,
                kaabaAngle: kaabaAngle,
                appLocalizations: appLocalizations,
              ),
            ),
          ),
          
          // Glowing Kaaba Badge at the exact bearing
          Positioned(
            left: posX,
            top: posY,
            child: Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: themeState.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: themeState.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                "assets/img/kaaba.svg",
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),

          // Central Glassmorphic/Solid Info Ring
          Center(
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: themeState.primaryShade200.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${kaabaAngle.toStringAsFixed(1)}°",
                    style: TextStyle(
                      fontSize: size * 0.06,
                      fontWeight: FontWeight.bold,
                      color: themeState.primary,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    getCardinalDirection(kaabaAngle, appLocalizations),
                    style: TextStyle(
                      fontSize: size * 0.04,
                      fontWeight: FontWeight.bold,
                      color: themeState.mutedGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    double kaabaAngle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeState.primaryShade200.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(roundedRadius),
            border: Border.all(
              color: themeState.primaryShade200.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.explore_off_outlined,
                color: themeState.primary,
                size: 28,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.deviceDoesNotHaveSensors,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      appLocalizations.unableToGetCompassData,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(24),

        // Steps Title
        Text(
          "How to Find Qibla Manually",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: themeState.primary,
          ),
        ),
        const Gap(16),

        // Step 1
        _buildStepItem(
          context,
          themeState,
          "1",
          "Locate North",
          "Use a physical compass, the sun, or a map to determine the direction of true North.",
        ),
        const Gap(12),

        // Step 2
        _buildStepItem(
          context,
          themeState,
          "2",
          "Align Phone",
          "Hold your phone flat and point the top of the screen directly towards North.",
        ),
        const Gap(12),

        // Step 3
        _buildStepItem(
          context,
          themeState,
          "3",
          "Turn to Qibla",
          "Rotate your phone clockwise by ${kaabaAngle.toStringAsFixed(0)}° (towards ${getCardinalDirection(kaabaAngle, appLocalizations)}). You are now facing the Qibla.",
        ),
        const Gap(24),

        // Action Button: Re-acquire Location
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationAcquire(backToPage: true),
                ),
              );
            },
            icon: Icon(Icons.location_on_outlined, color: themeState.primary),
            label: Text(
              "Change / Update Location",
              style: TextStyle(
                color: themeState.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: themeState.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    ThemeState themeState,
    String stepNumber,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: themeState.primaryShade200.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: themeState.primary.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: TextStyle(
                color: themeState.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const Gap(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Gap(4),
              Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getCardinalDirection(double angle, AppLocalizations appLocalizations) {
    final double normalized = (angle % 360 + 360) % 360;
    final String n = appLocalizations.north;
    final String e = appLocalizations.east;
    final String s = appLocalizations.south;
    final String w = appLocalizations.west;

    if (normalized >= 337.5 || normalized < 22.5) {
      return n;
    } else if (normalized >= 22.5 && normalized < 67.5) {
      return "$n$e";
    } else if (normalized >= 67.5 && normalized < 112.5) {
      return e;
    } else if (normalized >= 112.5 && normalized < 157.5) {
      return "$s$e";
    } else if (normalized >= 157.5 && normalized < 202.5) {
      return s;
    } else if (normalized >= 202.5 && normalized < 247.5) {
      return "$s$w";
    } else if (normalized >= 247.5 && normalized < 292.5) {
      return w;
    } else {
      return "$n$w";
    }
  }

  bool vibrateOnceEnter = false;
  void doVibrateThePhone() async {
    if (hasVibrator && !vibrateOnceEnter) {
      await Vibration.vibrate(
        amplitude: hasSupportAmplitude ? 200 : -1,
        duration: 100,
      );
      vibrateOnceEnter = true;
    }
  }

  Widget getCompassRotationView(
    double direction,
    double kaabaAngle,
    Widget compassView,
    ThemeState themeState,
  ) {
    Color kaabaColor = Theme.brightnessOf(context) == Brightness.light
        ? Colors.black
        : Colors.white;
    if ((direction.abs() - kaabaAngle.abs()).abs() < 5) {
      kaabaColor = themeState.primary;
      doVibrateThePhone();
    } else {
      vibrateOnceEnter = false;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 50,
            width: 50,
            // ignore: deprecated_member_use
            child: SvgPicture.asset("assets/img/kaaba.svg", color: kaabaColor),
          ),
        ),
        const Gap(50),
        Transform.rotate(
          angle: vector.radians(360 - direction),
          child: compassView,
        ),
      ],
    );
  }
}

double calculateQiblaAngle(double userLat, double userLon) {
  if (userLat == kaabaLatDegrees && userLon == kaabaLonDegrees) {
    return -1.0;
  }

  final double userLatRad = vector.radians(userLat);
  final double userLonRad = vector.radians(userLon);
  final double kaabaLatRad = vector.radians(kaabaLatDegrees);
  final double kaabaLonRad = vector.radians(kaabaLonDegrees);

  final double deltaLon = kaabaLonRad - userLonRad;

  final double y = math.sin(deltaLon) * math.cos(kaabaLatRad);
  final double x =
      math.cos(userLatRad) * math.sin(kaabaLatRad) -
      math.sin(userLatRad) * math.cos(kaabaLatRad) * math.cos(deltaLon);

  final double bearingRad = math.atan2(y, x);

  final double bearingDeg = vector.degrees(bearingRad);

  final double qiblaAngle = (bearingDeg + 360) % 360;

  return qiblaAngle;
}

double transformAngle(double inputAngle) {
  double result = 180.0 - inputAngle;
  double normalizedResult = (result % 360 + 360) % 360;
  return normalizedResult;
}
