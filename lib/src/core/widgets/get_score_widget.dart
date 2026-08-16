import "package:flutter/material.dart";
import "dart:math" as math;

Color _getColorForPercentage(double percentage) {
  final p = percentage.clamp(0.0, 100.0);
  if (p >= 0 && p <= 30) {
    return const Color.fromARGB(255, 255, 230, 0);
  } else if (p >= 31 && p <= 50) {
    return Colors.grey;
  } else if (p >= 51 && p <= 70) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}

Widget buildScoreIndicator({
  required double percentage,
  double size = 100.0,
  double borderWidth = 1.5,
  Color borderColor = Colors.grey,
  Color internalBackgroundColor = Colors.white,
  TextStyle textStyle = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),
}) {
  return SizedBox(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _ScorePainter(
            percentage: percentage,
            color: _getColorForPercentage(percentage),
            borderColor: borderColor,
            borderWidth: borderWidth,
            internalBackgroundColor: internalBackgroundColor,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(size * 0.1),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "${percentage.toStringAsFixed(0)}%",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

class _ScorePainter extends CustomPainter {
  final double percentage;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final Color internalBackgroundColor;

  _ScorePainter({
    required this.percentage,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.internalBackgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double clampedPercentage = percentage.clamp(0.0, 100.0);

    final double radius =
        (math.min(size.width, size.height) / 2) - (borderWidth / 2);
    final Offset center = size.center(Offset.zero);
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint =
        Paint()
          ..color = internalBackgroundColor
          ..style = PaintingStyle.fill;

    final foregroundPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

    const double startAngle = -math.pi / 2;
    final double sweepAngle = (clampedPercentage / 100.0) * 2 * math.pi;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (sweepAngle > 0) {
      canvas.drawArc(rect, startAngle, sweepAngle, true, foregroundPaint);
    }

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _ScorePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.internalBackgroundColor != internalBackgroundColor;
  }
}
