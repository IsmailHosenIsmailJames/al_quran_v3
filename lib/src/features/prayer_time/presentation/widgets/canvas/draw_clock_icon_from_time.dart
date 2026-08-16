import "dart:math" as math;
import "package:flutter/material.dart";

class ClockIcon extends StatelessWidget {
  final TimeOfDay time;
  final double size;
  final Color? color;
  final double strokeWidth;

  const ClockIcon({
    super.key,
    required this.time,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = color ?? theme.iconTheme.color ?? Colors.black;

    return CustomPaint(
      size: Size(size, size),
      painter: _ClockPainter(
        time: time,
        color: iconColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final TimeOfDay time;
  final Color color;
  final double strokeWidth;

  _ClockPainter({
    required this.time,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw clock circle
    canvas.drawCircle(center, radius - (strokeWidth / 2), paint);

    // Draw center dot
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, strokeWidth / 1.5, dotPaint);

    // Calculate hand lengths
    final hourHandLength = radius * 0.5;
    final minuteHandLength = radius * 0.7;

    // Calculate angles
    // 12 o'clock is -math.pi / 2
    final minuteAngle = (time.minute * 6 * math.pi / 180) - (math.pi / 2);
    final hourAngle =
        ((time.hour % 12) * 30 + time.minute * 0.5) * math.pi / 180 -
        (math.pi / 2);

    // Draw minute hand
    canvas.drawLine(
      center,
      Offset(
        center.dx + minuteHandLength * math.cos(minuteAngle),
        center.dy + minuteHandLength * math.sin(minuteAngle),
      ),
      paint,
    );

    // Draw hour hand
    canvas.drawLine(
      center,
      Offset(
        center.dx + hourHandLength * math.cos(hourAngle),
        center.dy + hourHandLength * math.sin(hourAngle),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ClockPainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
