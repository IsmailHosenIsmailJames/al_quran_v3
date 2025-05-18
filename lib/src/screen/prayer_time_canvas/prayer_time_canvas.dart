import "package:al_quran_v3/src/theme/colors/app_colors.dart";
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
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: AppColors.primaryColor,
      ),
      alignment: Alignment.center,
    );
  }
}
