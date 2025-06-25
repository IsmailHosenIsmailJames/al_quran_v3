import "dart:math" as math;

import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector;

import "../qibla_direction.dart";

class CompassView extends CustomPainter {
  final BuildContext context;
  final double kaabaAngle;
  final ThemeState themeState;
  CompassView(
    this.themeState, {
    required this.context,
    required this.kaabaAngle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.height / 2, size.width / 2);
    canvas.translate(center.dx, center.dy);
    Paint degreeAnglePaint = Paint();
    Color grayColor =
        Theme.of(context).brightness != Brightness.light
            ? Colors.grey.shade500
            : Colors.grey.shade700;
    canvas.drawCircle(
      const Offset(0, 0),
      25,
      degreeAnglePaint..color = grayColor,
    );

    double degreeDistanceFromCenter = size.width / 2;

    // draw kaaba direction
    double radian = vector.radians(transformAngle(kaabaAngle));
    double maxX = math.sin(radian) * (degreeDistanceFromCenter + 50);
    double maxY = math.cos(radian) * (degreeDistanceFromCenter + 50);

    canvas.drawLine(
      Offset(maxX, maxY),
      const Offset(0, 0),
      degreeAnglePaint
        ..color = grayColor
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    // draw angle lines
    for (int degree = 0; degree < 360; degree++) {
      if (degree % 2 == 0) {
        bool is30 = degree % 30 == 0;
        bool is90 = degree % 90 == 0;
        double length = 5;
        degreeAnglePaint
          ..color = grayColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1;
        if (is30) {
          length = 10;
          degreeAnglePaint
            ..color = themeState.primary
            ..strokeWidth = 2;
        }
        if (is90) {
          degreeAnglePaint
            ..color = themeState.primary
            ..strokeWidth = 3;
          length = 15;
        }
        double radian = vector.radians(degree.toDouble());
        double maxX = math.sin(radian) * degreeDistanceFromCenter;
        double maxY = math.cos(radian) * degreeDistanceFromCenter;

        double minX = math.sin(radian) * (degreeDistanceFromCenter - length);
        double minY = math.cos(radian) * (degreeDistanceFromCenter - length);

        canvas.drawLine(
          Offset(maxX, maxY),
          Offset(minX, minY),
          degreeAnglePaint,
        );

        if (is30) {
          canvas.save();
          // Draw angle text
          TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: degree.toString(),
              style: TextStyle(
                fontSize: is90 ? 14 : 12,
                color: is90 ? themeState.primary : grayColor,
              ),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();

          canvas.rotate(radian);
          textPainter.paint(
            canvas,
            Offset(-textPainter.width / 2, -(degreeDistanceFromCenter - 20)),
          );

          // draw [W, N, E, S]
          if (is90) {
            List<String> directionList = ["N", "E", "S", "W"];
            String direction = directionList[(degree / 90).toInt()];
            textPainter = TextPainter(
              text: TextSpan(
                text: direction,
                style: TextStyle(
                  fontSize: is90 ? 18 : 12,
                  color: themeState.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );

            textPainter.layout();
            textPainter.paint(
              canvas,
              Offset(-textPainter.width / 2, -(degreeDistanceFromCenter - 50)),
            );
          }
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
