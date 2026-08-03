import "dart:math" as math;

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector;

double transformAngle(double inputAngle) {
  double result = 180.0 - inputAngle;
  double normalizedResult = (result % 360 + 360) % 360;
  return normalizedResult;
}

class CompassPainter extends CustomPainter {
  final BuildContext context;
  final double kaabaAngle;
  final bool isAligned;
  final ThemeState themeState;
  final AppLocalizations appLocalizations;

  CompassPainter(
    this.themeState, {
    required this.context,
    required this.kaabaAngle,
    required this.isAligned,
    required this.appLocalizations,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);

    double radius = size.width / 2;
    bool isDark = Theme.brightnessOf(context) == Brightness.dark;

    Color grayColor = isDark ? Colors.grey.shade400 : Colors.grey.shade700;
    Color accentColor = themeState.primary;

    // Draw outer background circle
    Paint outerBgPaint = Paint()
      ..color = isDark ? Colors.black.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, radius, outerBgPaint);

    // Draw outer glow ring
    Paint ringPaint = Paint()
      ..color = isAligned
          ? accentColor.withValues(alpha: 0.4)
          : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08))
      ..style = PaintingStyle.stroke
      ..strokeWidth = isAligned ? 4.0 : 2.0;
    canvas.drawCircle(Offset.zero, radius - 2, ringPaint);

    // Draw inner target circle
    Paint centerCirclePaint = Paint()
      ..color = isAligned ? accentColor : (isDark ? Colors.grey.shade800 : Colors.grey.shade300)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 28, centerCirclePaint);

    // Draw Kaaba direction line / pointer
    double kaabaRadian = vector.radians(transformAngle(kaabaAngle));
    double kaabaX = math.sin(kaabaRadian) * (radius - 12);
    double kaabaY = math.cos(kaabaRadian) * (radius - 12);

    Paint kaabaLinePaint = Paint()
      ..color = isAligned ? accentColor : (isDark ? Colors.amber.shade400 : Colors.amber.shade700)
      ..strokeWidth = isAligned ? 5.0 : 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 0), Offset(kaabaX, kaabaY), kaabaLinePaint);

    // Draw Kaaba pointer head circle
    Paint kaabaHeadPaint = Paint()
      ..color = isAligned ? accentColor : (isDark ? Colors.amber.shade400 : Colors.amber.shade700)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(kaabaX, kaabaY), isAligned ? 8.0 : 6.0, kaabaHeadPaint);

    // Draw North (N) indicator triangle at degree 0
    double northRadian = vector.radians(0);
    double northX = math.sin(northRadian) * (radius - 18);
    double northY = -math.cos(northRadian) * (radius - 18);
    Path northPath = Path()
      ..moveTo(northX, northY)
      ..lineTo(northX - 6, northY + 12)
      ..lineTo(northX + 6, northY + 12)
      ..close();
    Paint northPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.fill;
    canvas.drawPath(northPath, northPaint);

    // Draw angle tick lines & labels
    Paint tickPaint = Paint();
    for (int degree = 0; degree < 360; degree++) {
      if (degree % 2 == 0) {
        bool is30 = degree % 30 == 0;
        bool is90 = degree % 90 == 0;
        double length = 6;

        tickPaint
          ..color = grayColor.withValues(alpha: 0.6)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.0;

        if (is30) {
          length = 12;
          tickPaint
            ..color = accentColor
            ..strokeWidth = 2.0;
        }
        if (is90) {
          length = 18;
          tickPaint
            ..color = accentColor
            ..strokeWidth = 3.0;
        }

        double tickRadian = vector.radians(degree.toDouble());
        double outerX = math.sin(tickRadian) * (radius - 4);
        double outerY = math.cos(tickRadian) * (radius - 4);

        double innerX = math.sin(tickRadian) * (radius - 4 - length);
        double innerY = math.cos(tickRadian) * (radius - 4 - length);

        canvas.drawLine(
          Offset(outerX, outerY),
          Offset(innerX, innerY),
          tickPaint,
        );

        if (is30) {
          canvas.save();
          TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: localizedNumber(context, degree),
              style: TextStyle(
                fontSize: is90 ? 14 : 11,
                color: is90 ? accentColor : grayColor,
                fontWeight: is90 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();
          canvas.rotate(tickRadian);
          textPainter.paint(
            canvas,
            Offset(-textPainter.width / 2, -(radius - 28)),
          );

          if (is90) {
            List<String> directionList = [
              appLocalizations.north,
              appLocalizations.east,
              appLocalizations.south,
              appLocalizations.west,
            ];
            String direction = directionList[(degree / 90).toInt()];
            TextPainter dirPainter = TextPainter(
              text: TextSpan(
                text: direction,
                style: TextStyle(
                  fontSize: 16,
                  color: degree == 0 ? Colors.redAccent : accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );

            dirPainter.layout();
            dirPainter.paint(
              canvas,
              Offset(-dirPainter.width / 2, -(radius - 54)),
            );
          }
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CompassPainter oldDelegate) {
    return oldDelegate.kaabaAngle != kaabaAngle ||
        oldDelegate.isAligned != isAligned ||
        oldDelegate.themeState != themeState;
  }
}
