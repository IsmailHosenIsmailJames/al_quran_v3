import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

/// A clean, modern Islamic geometric octagon badge displaying localized numbers.
class QuranIndexBadge extends StatelessWidget {
  final int index;
  final double size;
  final Color? color;
  final Color? textColor;

  const QuranIndexBadge({
    super.key,
    required this.index,
    this.size = 38,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final langCode = context.watch<LanguageCubit>().state.locale.languageCode;

    final badgeColor = color ?? themeState.primary;
    final textStyleColor = textColor ??
        (isDark ? Colors.white : Colors.grey.shade900);

    final localizedStr = NumberFormat.decimalPattern(langCode).format(index);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Islamic geometric octagon star outline
          CustomPaint(
            size: Size(size, size),
            painter: _OctagonStarPainter(
              color: badgeColor.withValues(alpha: isDark ? 0.35 : 0.25),
              fillColor: badgeColor.withValues(alpha: isDark ? 0.12 : 0.08),
              strokeWidth: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                localizedStr,
                style: TextStyle(
                  fontSize: size * 0.38,
                  fontWeight: FontWeight.w700,
                  color: textStyleColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OctagonStarPainter extends CustomPainter {
  final Color color;
  final Color fillColor;
  final double strokeWidth;

  _OctagonStarPainter({
    required this.color,
    required this.fillColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;

    // Draw two overlapping rounded rectangles rotated 45 degrees
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: radius * 1.8,
        height: radius * 1.8,
      ),
      Radius.circular(radius * 0.28),
    );

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // First square
    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, strokePaint);

    // Second square rotated 45 degrees
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(0.785398); // 45 degrees in radians
    canvas.translate(-center.dx, -center.dy);
    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, strokePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OctagonStarPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
