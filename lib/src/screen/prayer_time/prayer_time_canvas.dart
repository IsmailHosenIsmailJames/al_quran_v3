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
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Prayer Time Painter Canvas\nUnder Dev",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
