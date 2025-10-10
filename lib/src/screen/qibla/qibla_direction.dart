import "package:al_quran_v3/l10n/app_localizations.dart";
import "dart:math" as math;

import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/qibla/compass_view/compass_view.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_compass/flutter_compass.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:vector_math/vector_math.dart" as vector;

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
    super.initState();
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
      child: BlocBuilder<
        LocationQiblaPrayerDataCubit,
        LocationQiblaPrayerDataState
      >(
        builder: (context, state) {
          LocationQiblaPrayerDataState? dataState =
              context.read<LocationQiblaPrayerDataCubit>().state;
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
                  backgroundColor:
                      context.read<ThemeCubit>().state.primaryShade100,
                ),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  Center(
                    child: StreamBuilder<CompassEvent>(
                      stream: FlutterCompass.events,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(appLocalizations.unableToGetCompassData);
                        }
                        if (snapshot.hasData) {
                          double? direction = snapshot.data?.heading;
                          if (direction == null) {
                            return Center(
                              child: Text(
                                appLocalizations.deviceDoesNotHaveSensors,
                              ),
                            );
                          }
                          if (direction < 0) {
                            direction = 180 + (180 - direction.abs());
                          }
                          return getCompassRotationView(
                            direction,
                            state.kaabaAngle!,
                            compassView,
                            themeState,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }

  bool vibrateOnceEnter = false;

  Widget getCompassRotationView(
    double direction,
    double kaabaAngle,
    Widget compassView,
    ThemeState themeState,
  ) {
    Color kaabaColor =
        Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    if ((direction.abs() - kaabaAngle.abs()).abs() < 5) {
      kaabaColor = themeState.primary;
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
