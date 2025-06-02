import "dart:async";

import "dart:math" as math;
import "package:al_quran_v3/src/resources/meta_data/kaaba_location_data.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/home/pages/qibla/compass_view/compass_view.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_compass/flutter_compass.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:vector_math/vector_math.dart" as vector;
import "package:vibration/vibration.dart";

class QiblaDirection extends StatefulWidget {
  const QiblaDirection({super.key});

  @override
  State<QiblaDirection> createState() => _QiblaDirectionState();
}

class _QiblaDirectionState extends State<QiblaDirection> {
  late bool hasVibrator;
  late bool hasSupportAmplitude;
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
    return BlocBuilder<LocationDataQiblaDataCubit, LocationDataQiblaDataState>(
      builder: (context, state) {
        LocationDataQiblaDataState? dataState =
            context.read<LocationDataQiblaDataCubit>().state;
        Widget compassView = const SizedBox();
        if (dataState.kaabaAngle != null) {
          compassView = SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: CustomPaint(
              painter: CompassView(
                context: context,
                kaabaAngle: dataState.kaabaAngle!,
              ),
            ),
          );
        }
        return state.latLon == null
            ? const LocationAcquire()
            : state.kaabaAngle == null
            ? Center(child: CircularProgressIndicator(color: AppColors.primary))
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
                        return const Text("Unable to get compass data");
                      }
                      if (snapshot.hasData) {
                        double? direction = snapshot.data?.heading;
                        if (direction == null) {
                          return const Center(
                            child: Text("Device does not have sensors !"),
                          );
                        }
                        if (direction < 0) {
                          direction = 180 + (180 - direction.abs());
                        }
                        return getCompassRotationView(
                          direction,
                          state.kaabaAngle!,
                          compassView,
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
    );
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
  ) {
    Color kaabaColor =
        Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    if ((direction.abs() - kaabaAngle.abs()).abs() < 5) {
      kaabaColor = AppColors.primary;
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
