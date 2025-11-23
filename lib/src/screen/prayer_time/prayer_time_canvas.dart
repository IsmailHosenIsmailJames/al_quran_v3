import "dart:math" as math;

import "package:flutter/material.dart";

class PrayerTimeCanvas extends StatefulWidget {
  const PrayerTimeCanvas({super.key});

  @override
  State<PrayerTimeCanvas> createState() => _PrayerTimeCanvasState();
}

class _PrayerTimeCanvasState extends State<PrayerTimeCanvas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      alignment: Alignment.center,
      child: CustomPaint(
        size: const Size(150, 150),
        painter: CirclePainter(
          prayerTimes: const [
            TimeOfDay(hour: 3, minute: 44),

            TimeOfDay(hour: 12, minute: 00),

            TimeOfDay(hour: 15, minute: 20),

            TimeOfDay(hour: 18, minute: 46),

            TimeOfDay(hour: 20, minute: 13),
          ],
          sunriseTime: const TimeOfDay(hour: 5, minute: 12),

          sunsetTime: const TimeOfDay(hour: 18, minute: 46),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final List<TimeOfDay> prayerTimes;
  final TimeOfDay sunriseTime;
  final TimeOfDay sunsetTime;

  CirclePainter({
    required this.prayerTimes,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double circleStockWidth = 10;
    final mainCircleRadius = size.shortestSide / 2;

    final paint =
        Paint()
          ..color = Colors.grey.withValues(alpha: .5)
          ..strokeWidth = circleStockWidth
          ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.shortestSide / 2;

    canvas.drawCircle(center, radius, paint);

    final hourLinePaint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    const double normalLineLength = 3.0;
    const double slightlyBiggerLineLength = 5.0;
    const double biggerLineLength = 7.0;

    for (int i = 0; i < 24; i++) {
      final angle = (i * (360 / 24) - 90) * (math.pi / 180);

      double currentLineLength = normalLineLength;
      double currentStrokeWidth = 2.0;

      if (i == 0 || i == 6 || i == 12 || i == 18) {
        currentLineLength = biggerLineLength;
        currentStrokeWidth = 3.0;
      } else if (i == 3 || i == 9 || i == 15 || i == 21) {
        currentLineLength = slightlyBiggerLineLength;
        currentStrokeWidth = 2.5;
      }

      hourLinePaint.strokeWidth = currentStrokeWidth;

      final startX =
          center.dx + (radius - circleStockWidth / 2 - 2) * math.cos(angle);
      final startY =
          center.dy + (radius - circleStockWidth / 2 - 2) * math.sin(angle);
      final startPoint = Offset(startX, startY);

      final endX =
          center.dx +
          ((radius - circleStockWidth / 2 - 2) - currentLineLength) *
              math.cos(angle);
      final endY =
          center.dy +
          ((radius - circleStockWidth / 2 - 2) - currentLineLength) *
              math.sin(angle);
      final endPoint = Offset(endX, endY);

      canvas.drawLine(startPoint, endPoint, hourLinePaint);
    }

    final prayerMarkerPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    const double prayerMarkerRadius = 3.0;

    for (var time in prayerTimes) {
      final angle = _timeToAngle(time);

      final markerX = center.dx + (mainCircleRadius) * math.cos(angle);
      final markerY = center.dy + (mainCircleRadius) * math.sin(angle);
      canvas.drawCircle(
        Offset(markerX, markerY),
        prayerMarkerRadius,
        prayerMarkerPaint,
      );
    }

    final sunriseAngle = _timeToAngle(sunriseTime);
    final sunriseIconX =
        center.dx + (mainCircleRadius + 11) * math.cos(sunriseAngle);
    final sunriseIconY =
        center.dy + (mainCircleRadius + 11) * math.sin(sunriseAngle);
    _drawText(canvas, Offset(sunriseIconX, sunriseIconY), "☀️", 10);

    final sunsetAngle = _timeToAngle(sunsetTime);
    final sunsetIconX =
        center.dx + (mainCircleRadius + 11) * math.cos(sunsetAngle);
    final sunsetIconY =
        center.dy + (mainCircleRadius + 11) * math.sin(sunsetAngle);
    _drawText(canvas, Offset(sunsetIconX, sunsetIconY), "🌙", 10);

    final currentIconAngle = _timeToAngle(
      TimeOfDay.fromDateTime(DateTime.now()),
    );
    final currentIconX =
        center.dx + (mainCircleRadius + 28) * math.cos(currentIconAngle);
    final currentIconY =
        center.dy + (mainCircleRadius + 28) * math.sin(currentIconAngle);

    _drawText(canvas, Offset(currentIconX, currentIconY), "☀️", 18);

    final double earthRadius = mainCircleRadius / 2.5;
    final Offset earthCenter = center;

    final dayPaint = Paint()..color = Colors.grey.shade200;
    canvas.drawCircle(earthCenter, earthRadius, dayPaint);

    final nightPaint = Paint()..color = Colors.grey.shade600;

    final double currentAngleForEarth = _timeToAngle(
      TimeOfDay.fromDateTime(DateTime.now()),
    );
    final double startAngle = currentAngleForEarth + math.pi / 2;
    final double sweepAngle = math.pi;

    final Rect earthRect = Rect.fromCircle(
      center: earthCenter,
      radius: earthRadius,
    );

    canvas.drawArc(earthRect, startAngle, sweepAngle, true, nightPaint);
  }

  double _timeToAngle(TimeOfDay time) {
    const double totalMinutesInDay = 24 * 60;

    final double currentMinutes = time.hour * 60 + time.minute.toDouble();

    final double percentage = currentMinutes / totalMinutesInDay;

    final double rawAngle = percentage * 2 * math.pi;

    return (rawAngle + math.pi / 2) % (2 * math.pi);
  }

  void _drawText(Canvas canvas, Offset position, String text, double fontSize) {
    final textSpan = TextSpan(text: text, style: TextStyle(fontSize: fontSize));
    final textPainter = TextPainter(
      text: textSpan,

      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final offset = Offset(
      position.dx - textPainter.width / 2,
      position.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
