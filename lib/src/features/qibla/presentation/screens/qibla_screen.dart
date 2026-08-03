import "dart:math" as math;

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/location/presentation/screens/location_acquire_screen.dart";
import "package:al_quran_v3/src/features/qibla/presentation/cubit/qibla_cubit.dart";
import "package:al_quran_v3/src/features/qibla/presentation/cubit/qibla_state.dart";
import "package:al_quran_v3/src/features/qibla/presentation/widgets/compass_painter.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:vector_math/vector_math.dart" as vector;

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QiblaCubit>(
      create: (context) {
        final cubit = getIt<QiblaCubit>();
        final locationState =
            context.read<LocationQiblaPrayerDataCubit>().state;
        if (locationState.latLon != null) {
          cubit.init(
            latitude: locationState.latLon!.latitude,
            longitude: locationState.latLon!.longitude,
            preCalculatedKaabaAngle: locationState.kaabaAngle,
          );
        }
        return cubit;
      },
      child: const _QiblaView(),
    );
  }
}

class _QiblaView extends StatelessWidget {
  const _QiblaView();

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLandscape = width > height;
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<LocationQiblaPrayerDataCubit,
            LocationQiblaPrayerDataState>(
          listener: (context, locationState) {
            if (locationState.kaabaAngle != null) {
              context
                  .read<QiblaCubit>()
                  .updateKaabaAngle(locationState.kaabaAngle!);
            } else if (locationState.latLon != null) {
              context.read<QiblaCubit>().init(
                    latitude: locationState.latLon!.latitude,
                    longitude: locationState.latLon!.longitude,
                  );
            }
          },
          child: BlocBuilder<LocationQiblaPrayerDataCubit,
              LocationQiblaPrayerDataState>(
            builder: (context, locationState) {
              if (locationState.latLon == null) {
                return const LocationAcquire();
              }

              if (locationState.kaabaAngle == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: themeState.primary,
                    backgroundColor: themeState.primaryShade100,
                  ),
                );
              }

              return BlocBuilder<QiblaCubit, QiblaState>(
                builder: (context, qiblaState) {
                  if (qiblaState.hasError) {
                    return Center(
                      child: Text(
                        appLocalizations.unableToGetCompassData,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  if (!qiblaState.isSensorSupported ||
                      qiblaState.compassHeading == null) {
                    return Center(
                      child: Text(
                        appLocalizations.deviceDoesNotHaveSensors,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  double heading = qiblaState.compassHeading!;
                  double kaabaAngle = locationState.kaabaAngle!;
                  bool isAligned = qiblaState.isAligned;

                  double compassDiameter =
                      isLandscape ? height * 0.55 : width * 0.82;

                  Widget compassView = SizedBox(
                    width: compassDiameter,
                    height: compassDiameter,
                    child: CustomPaint(
                      painter: CompassPainter(
                        themeState,
                        context: context,
                        kaabaAngle: kaabaAngle,
                        isAligned: isAligned,
                        appLocalizations: appLocalizations,
                      ),
                    ),
                  );

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(10),
                      // Top Header Metric Card
                      _buildHeaderMetrics(
                        context: context,
                        themeState: themeState,
                        heading: heading,
                        kaabaAngle: kaabaAngle,
                        isAligned: isAligned,
                      ),

                      // Compass Rotation Container
                      Center(
                        child: _CompassRotationContainer(
                          heading: heading,
                          isAligned: isAligned,
                          compassView: compassView,
                          themeState: themeState,
                          diameter: compassDiameter,
                        ),
                      ),

                      // Alignment Status Pill Badge
                      _buildAlignmentBadge(
                        context: context,
                        themeState: themeState,
                        isAligned: isAligned,
                        heading: heading,
                        kaabaAngle: kaabaAngle,
                      ),
                      const Gap(10),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderMetrics({
    required BuildContext context,
    required ThemeState themeState,
    required double heading,
    required double kaabaAngle,
    required bool isAligned,
  }) {
    bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade900.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isAligned
              ? themeState.primary.withValues(alpha: 0.5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricColumn(
            label: "Heading",
            value: "${heading.round()}°",
            color: isDark ? Colors.white : Colors.black87,
          ),
          Container(
            height: 30,
            width: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
          _buildMetricColumn(
            label: "Qibla",
            value: "${kaabaAngle.round()}°",
            color: themeState.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const Gap(4),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAlignmentBadge({
    required BuildContext context,
    required ThemeState themeState,
    required bool isAligned,
    required double heading,
    required double kaabaAngle,
  }) {
    double diff = (kaabaAngle - heading + 360) % 360;
    if (diff > 180) diff -= 360;

    String guidanceText;
    IconData iconData;

    if (isAligned) {
      guidanceText = "Aligned with Kaaba";
      iconData = Icons.check_circle_rounded;
    } else if (diff > 0) {
      guidanceText = "Turn ${diff.abs().round()}° Right";
      iconData = Icons.arrow_circle_right_rounded;
    } else {
      guidanceText = "Turn ${diff.abs().round()}° Left";
      iconData = Icons.arrow_circle_left_rounded;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isAligned
            ? themeState.primary
            : Theme.brightnessOf(context) == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        boxShadow: isAligned
            ? [
                BoxShadow(
                  color: themeState.primary.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: isAligned
                ? Colors.white
                : Theme.brightnessOf(context) == Brightness.dark
                    ? Colors.white70
                    : Colors.black87,
            size: 20,
          ),
          const Gap(8),
          Text(
            guidanceText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isAligned
                  ? Colors.white
                  : Theme.brightnessOf(context) == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassRotationContainer extends StatefulWidget {
  final double heading;
  final bool isAligned;
  final Widget compassView;
  final ThemeState themeState;
  final double diameter;

  const _CompassRotationContainer({
    required this.heading,
    required this.isAligned,
    required this.compassView,
    required this.themeState,
    required this.diameter,
  });

  @override
  State<_CompassRotationContainer> createState() =>
      _CompassRotationContainerState();
}

class _CompassRotationContainerState extends State<_CompassRotationContainer> {
  late double _accumulatedAngle;
  late double _lastTarget;

  @override
  void initState() {
    super.initState();
    _lastTarget = vector.radians(360 - widget.heading);
    _accumulatedAngle = _lastTarget;
  }

  @override
  void didUpdateWidget(covariant _CompassRotationContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    double newTarget = vector.radians(360 - widget.heading);
    double diff = (newTarget - _lastTarget) % (2 * math.pi);
    if (diff > math.pi) {
      diff -= 2 * math.pi;
    } else if (diff < -math.pi) {
      diff += 2 * math.pi;
    }
    _accumulatedAngle += diff;
    _lastTarget = newTarget;
  }

  @override
  Widget build(BuildContext context) {
    Color kaabaColor = widget.isAligned
        ? widget.themeState.primary
        : (Theme.brightnessOf(context) == Brightness.light
            ? Colors.black
            : Colors.white);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Smooth unrolled continuous rotation animation (no 360° spin on 0°/360° boundary)
        TweenAnimationBuilder<double>(
          tween: Tween<double>(end: _accumulatedAngle),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          builder: (context, angle, child) {
            return Transform.rotate(
              angle: angle,
              child: child,
            );
          },
          child: widget.compassView,
        ),

        // Central Kaaba Icon Container with alignment pulse glow
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.brightnessOf(context) == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: widget.isAligned
                    ? widget.themeState.primary.withValues(alpha: 0.5)
                    : Colors.black.withValues(alpha: 0.1),
                blurRadius: widget.isAligned ? 16 : 8,
                spreadRadius: widget.isAligned ? 4 : 0,
              )
            ],
            border: Border.all(
              color: widget.isAligned
                  ? widget.themeState.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 32,
              width: 32,
              child: SvgPicture.asset(
                "assets/img/kaaba.svg",
                // ignore: deprecated_member_use
                color: kaabaColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
