import 'dart:async';
import 'dart:developer';

import 'dart:math' as math;
import 'package:al_quran_v3/src/screen/home/pages/qibla/compass_view/compass_view.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:vibration/vibration.dart';

class QiblaDirection extends StatefulWidget {
  const QiblaDirection({super.key});

  @override
  State<QiblaDirection> createState() => _QiblaDirectionState();
}

class _QiblaDirectionState extends State<QiblaDirection> {
  bool isLocationPermissionAllowed = false;
  double? kaabaAngle;
  Widget? compassView;
  late bool hasVibrator;
  late bool hasSupportAmplitude;
  @override
  void initState() {
    fetchPermissionStatus().then((value) async {
      if (!value) {
        openAppSettings();
      } else {
        if (!disposed) {
          setState(() {
            isLocationPermissionAllowed = value;
          });
        }
        log('Getting GPS location');
        final Position position = await Geolocator.getCurrentPosition();
        log('GPS location getting successful');
        hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator) {
          hasSupportAmplitude = await Vibration.hasCustomVibrationsSupport();
        }

        if (!disposed) {
          setState(() {
            kaabaAngle = calculateQiblaAngle(
              position.latitude,
              position.longitude,
            );
            log('Kaaba Angle found at -> $kaabaAngle');
            compassView = SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: CustomPaint(
                painter: CompassView(context: context, kaabaAngle: kaabaAngle!),
              ),
            );
          });
        }
      }
    });
    FlutterCompass.events?.listen((event) {});
    super.initState();
  }

  Future<bool> fetchPermissionStatus() async {
    PermissionStatus permissionStatus =
        await Permission.locationWhenInUse.status;
    if (!permissionStatus.isGranted) {
      log('message');
      permissionStatus = await Permission.locationWhenInUse.request();
    }
    return permissionStatus.isGranted;
  }

  bool disposed = false;
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isLocationPermissionAllowed
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'We required Location Permission for get the Qibla Direction. Please allow location permission.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const Gap(20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  fetchPermissionStatus();
                },
                label: const Text('Allow Location Permission'),
                icon: const Icon(Icons.location_on),
              ),
            ),
          ],
        )
        : kaabaAngle == null
        ? Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
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
                    return const Text('Unable to get compass data');
                  }
                  if (snapshot.hasData) {
                    double? direction = snapshot.data?.heading;
                    if (direction == null) {
                      return const Center(
                        child: Text('Device does not have sensors !'),
                      );
                    }
                    if (direction < 0) {
                      direction = 180 + (180 - direction.abs());
                    }
                    return getCompassRotationView(direction, kaabaAngle!);
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),
            ),
          ],
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

  Widget getCompassRotationView(double direction, double kaabaAngle) {
    Color kaabaColor =
        Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    if ((direction.abs() - kaabaAngle.abs()).abs() < 5) {
      kaabaColor = AppColors.primaryColor;
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
            child: SvgPicture.asset('assets/img/kaaba.svg', color: kaabaColor),
          ),
        ),
        const Gap(50),
        AnimatedRotation(
          turns: (360 - direction).abs() / 360,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
          child: compassView!,
        ),
      ],
    );
  }
}

double calculateQiblaAngle(double userLat, double userLon) {
  const double kaabaLatDegrees = 21.422487;
  const double kaabaLonDegrees = 39.826206;

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
