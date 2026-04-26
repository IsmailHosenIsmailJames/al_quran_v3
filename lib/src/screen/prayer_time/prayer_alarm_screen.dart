import 'package:flutter/material.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/theme/controller/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:alarm/alarm.dart';
import 'package:gap/gap.dart';
import 'package:al_quran_v3/src/screen/home/home_page.dart';

class PrayerAlarmScreen extends StatefulWidget {
  final String payload;
  const PrayerAlarmScreen({super.key, required this.payload});

  @override
  State<PrayerAlarmScreen> createState() => _PrayerAlarmScreenState();
}

class _PrayerAlarmScreenState extends State<PrayerAlarmScreen> {
  String prayerName = 'Prayer';
  int? notificationId;

  @override
  void initState() {
    super.initState();
    _parsePayload();
  }

  void _parsePayload() {
    if (widget.payload.contains(':')) {
      final parts = widget.payload.split(':');
      prayerName = parts[0];
      notificationId = int.tryParse(parts[1]);
    } else {
      prayerName = widget.payload;
    }
  }

  void _dismissAlarm() async {
    if (notificationId != null) {
      await Alarm.stop(notificationId!);
    } else {
      // Stop all alarms as fallback
      final alarms = await Alarm.getAlarms();
      for (final alarm in alarms) {
        await Alarm.stop(alarm.id);
      }
    }

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState.themeMode == ThemeMode.dark;
        final timeString = DateFormat.jm().format(DateTime.now());

        return Scaffold(
          backgroundColor: isDark
              ? const Color(0xFF121212)
              : const Color(0xFFF8F9FA),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        themeState.primary.withValues(alpha: 0.2),
                        const Color(0xFF121212),
                      ]
                    : [
                        themeState.primary.withValues(alpha: 0.1),
                        const Color(0xFFF8F9FA),
                      ],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(
                    FluentIcons.alert_24_regular,
                    size: 80,
                    color: themeState.primary,
                  ),
                  const Gap(24),
                  Text(
                    timeString,
                    style: GoogleFonts.outfit(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    "It's time for $prayerName",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 48.0,
                    ),
                    child: InkWell(
                      onTap: _dismissAlarm,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 72,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: themeState.primary,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: themeState.primary.withValues(alpha: 0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FluentIcons.dismiss_24_filled,
                              color: Colors.white,
                              size: 28,
                            ),
                            const Gap(12),
                            Text(
                              "Stop & Dismiss",
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
