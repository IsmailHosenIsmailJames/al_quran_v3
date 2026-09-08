import "dart:async";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/core/utils/navigator_key.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/ringtone_service.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";
import "package:wakelock_plus/wakelock_plus.dart";

void navigateToPrayerAlarmScreen(
  Prayer prayer,
  DateTime scheduledTime,
  int notificationId,
) {
  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (context) => PrayerAlarmScreen(
        prayer: prayer,
        scheduledTime: scheduledTime,
        notificationId: notificationId,
      ),
    ),
  );
}

class PrayerAlarmScreen extends StatefulWidget {
  final Prayer prayer;
  final DateTime scheduledTime;
  final int notificationId;

  const PrayerAlarmScreen({
    super.key,
    required this.prayer,
    required this.scheduledTime,
    required this.notificationId,
  });

  @override
  State<PrayerAlarmScreen> createState() => _PrayerAlarmScreenState();
}

class _PrayerAlarmScreenState extends State<PrayerAlarmScreen>
    with SingleTickerProviderStateMixin {
  late Timer _clockTimer;
  late DateTime _currentTime;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Keep screen awake while alarm screen is visible
    try {
      WakelockPlus.enable();
    } catch (_) {}
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _pulseController.dispose();
    try {
      WakelockPlus.disable();
    } catch (_) {}
    super.dispose();
  }

  Future<void> _dismissAlarm() async {
    HapticFeedback.mediumImpact();
    try {
      await AwesomeNotifications().cancel(widget.notificationId);
      await RingtoneService.stopRingtone();
    } catch (_) {}
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _snoozeAlarm() async {
    HapticFeedback.lightImpact();
    try {
      await AwesomeNotifications().cancel(widget.notificationId);
      await RingtoneService.stopRingtone();
      await ReminderScheduler.snoozePrayerAlarm(widget.prayer, minutes: 10);
    } catch (_) {}
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Snoozed for 10 minutes"),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  List<Color> _getThemeGradient() {
    switch (widget.prayer) {
      case Prayer.fajr:
        return const [
          Color(0xFF070B19),
          Color(0xFF0F1A34),
          Color(0xFF1E284E),
          Color(0xFF2D234A),
        ];
      case Prayer.sunrise:
        return const [
          Color(0xFF1E1408),
          Color(0xFF38230D),
          Color(0xFF5E3A14),
          Color(0xFF8C531B),
        ];
      case Prayer.dhuhr:
        return const [
          Color(0xFF081C2E),
          Color(0xFF0F314D),
          Color(0xFF134E6F),
          Color(0xFF1F6E8C),
        ];
      case Prayer.asr:
        return const [
          Color(0xFF21140A),
          Color(0xFF3E2310),
          Color(0xFF633718),
          Color(0xFF8B4D20),
        ];
      case Prayer.maghrib:
        return const [
          Color(0xFF1B0C1E),
          Color(0xFF33143A),
          Color(0xFF521C4A),
          Color(0xFF6E2346),
        ];
      case Prayer.isha:
        return const [
          Color(0xFF050814),
          Color(0xFF0B1124),
          Color(0xFF121B38),
          Color(0xFF1A264D),
        ];
      default:
        return const [
          Color(0xFF0B1424),
          Color(0xFF13223D),
          Color(0xFF1E355B),
        ];
    }
  }

  Color _getAccentColor() {
    switch (widget.prayer) {
      case Prayer.fajr:
        return const Color(0xFF818CF8);
      case Prayer.sunrise:
        return const Color(0xFFFBBF24);
      case Prayer.dhuhr:
        return const Color(0xFF38BDF8);
      case Prayer.asr:
        return const Color(0xFFFB923C);
      case Prayer.maghrib:
        return const Color(0xFFF472B6);
      case Prayer.isha:
        return const Color(0xFFA78BFA);
      default:
        return const Color(0xFF38BDF8);
    }
  }

  String _getIslamicQuote() {
    if (widget.prayer == Prayer.fajr) {
      return "الصَّلَاةُ خَيْرٌ مِنَ النَّوْمِ\nPrayer is better than sleep";
    }
    return "إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَوْقُوتًا\nIndeed, prayer is a prescribed duty at appointed times";
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getThemeGradient();
    final accentColor = _getAccentColor();
    final prayerName = PrayerTimeHelper.localizedPrayerName(context, widget.prayer) ??
        widget.prayer.name;
    final arabicName = PrayerTimeHelper.arabicPrayerName(widget.prayer);
    final formattedTime = DateFormat("hh:mm").format(_currentTime);
    final formattedSeconds = DateFormat("ss").format(_currentTime);
    final amPm = DateFormat("a").format(_currentTime);
    final scheduledStr = DateFormat("hh:mm a").format(widget.scheduledTime);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: gradient.first,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradient,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                children: [
                  // Top Status Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.alarm,
                          color: accentColor,
                          size: 16,
                        ),
                        const Gap(8),
                        Text(
                          "PRAYER TIME ALARM",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Pulsating Glowing Icon
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      final scale = 1.0 + (_pulseController.value * 0.08);
                      final glowOpacity = 0.2 + (_pulseController.value * 0.25);
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow Ring Outer
                          Container(
                            width: 140 * scale,
                            height: 140 * scale,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: accentColor.withValues(alpha: glowOpacity * 0.5),
                            ),
                          ),
                          // Glow Ring Inner
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: accentColor.withValues(alpha: glowOpacity),
                            ),
                          ),
                          // Icon Container
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              PrayerTimeHelper.getPrayerIcon(widget.prayer),
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const Gap(24),

                  // Arabic Prayer Name
                  Text(
                    arabicName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

                  const Gap(4),

                  // Localized Prayer Name
                  Text(
                    prayerName,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const Gap(6),

                  // Scheduled for
                  Text(
                    "Scheduled: $scheduledStr",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Live Digital Clock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        formattedTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 68,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 2,
                        ),
                      ),
                      const Gap(6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            amPm,
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formattedSeconds,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Gap(16),

                  // Islamic Quote / Hadith
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Text(
                      _getIslamicQuote(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Interactive Control Buttons: Dismiss & Snooze
                  Column(
                    children: [
                      // Large Stop / Dismiss Alarm Button
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: gradient.first,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                            shadowColor: Colors.black.withValues(alpha: 0.4),
                          ),
                          onPressed: _dismissAlarm,
                          icon: const Icon(
                            FluentIcons.dismiss_circle_24_filled,
                            color: Color(0xFFDC2626),
                            size: 24,
                          ),
                          label: const Text(
                            "Stop Alarm",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      const Gap(14),

                      // Snooze (10 Min) Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.35),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _snoozeAlarm,
                          icon: const Icon(
                            FluentIcons.snooze_24_regular,
                            size: 20,
                          ),
                          label: const Text(
                            "Snooze (10 min)",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
