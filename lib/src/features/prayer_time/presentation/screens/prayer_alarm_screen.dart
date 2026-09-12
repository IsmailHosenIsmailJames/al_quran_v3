import "dart:async";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
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
  Timer? _safetySilenceTimer;
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

    // Start playing alarm audio immediately
    _startAlarmAudio();
  }

  Future<void> _startAlarmAudio() async {
    try {
      final inCall = await RingtoneService.isInCall();
      if (inCall) return; // Prevent playing over active or incoming phone calls

      final soundType = ReminderScheduler.getSelectedRingtoneType();
      final soundUri = ReminderScheduler.getSelectedRingtoneUri();
      final volume = ReminderScheduler.getSoundVolume();

      final uriToPlay = soundType == "adhan"
          ? "resource://raw/adhan"
          : (soundType == "default_sound"
              ? "resource://raw/notification_sound"
              : (soundUri ?? soundType));

      await RingtoneService.playRingtone(
        uriToPlay,
        isAlarm: true,
        loop: true,
        volume: volume,
      );

      // Auto-silence safety timer after 10 minutes to protect device battery
      _safetySilenceTimer = Timer(const Duration(minutes: 10), () {
        RingtoneService.stopRingtone();
      });
    } catch (e) {
      debugPrint("Error starting alarm audio: $e");
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _safetySilenceTimer?.cancel();
    _pulseController.dispose();
    try {
      WakelockPlus.disable();
      RingtoneService.stopRingtone();
    } catch (_) {}
    super.dispose();
  }

  Future<void> _dismissAlarm() async {
    HapticFeedback.mediumImpact();
    _safetySilenceTimer?.cancel();
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
    _safetySilenceTimer?.cancel();
    try {
      await AwesomeNotifications().cancel(widget.notificationId);
      await RingtoneService.stopRingtone();
      await ReminderScheduler.snoozePrayerAlarm(widget.prayer, minutes: 10);
    } catch (_) {}
    if (mounted) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.snoozed10Min),
          duration: const Duration(seconds: 2),
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

                  // Mosque Dome Arch Illustration with Pulsing Celestial Halo
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(150, 150),
                        painter: MosqueArchPainter(
                          accentColor: accentColor,
                          pulseValue: _pulseController.value,
                        ),
                      );
                    },
                  ),

                  const Gap(20),

                  // Arabic Prayer Name
                  Text(
                    arabicName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.15, end: 0),

                  const Gap(4),

                  // Localized Prayer Name
                  Text(
                    prayerName,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 19,
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
                  Builder(builder: (context) {
                    final l10n = AppLocalizations.of(context);
                    return Column(
                      children: [
                        // Large Stop / Dismiss Alarm Button (Vibrant & Distinctive)
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE11D48),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                              shadowColor: const Color(0xFFE11D48).withValues(alpha: 0.5),
                            ),
                            onPressed: _dismissAlarm,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    FluentIcons.dismiss_24_filled,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  l10n.stopAlarm,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(14),

                        // Snooze Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white.withValues(alpha: 0.08),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.25),
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _snoozeAlarm,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FluentIcons.snooze_24_regular,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const Gap(8),
                                Text(
                                  l10n.snooze,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
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

class MosqueArchPainter extends CustomPainter {
  final Color accentColor;
  final double pulseValue;

  const MosqueArchPainter({
    required this.accentColor,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    // 1. Soft radial ambient glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          accentColor.withValues(alpha: 0.35 + 0.15 * pulseValue),
          accentColor.withValues(alpha: 0.12 * pulseValue),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: w * 0.55));
    canvas.drawCircle(center, w * 0.55, glowPaint);

    // 2. Circular celestial background disc
    final discPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF16203D),
          Color(0xFF090D1A),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: w * 0.42));
    canvas.drawCircle(center, w * 0.42, discPaint);

    // Border ring around disc
    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18 + 0.1 * pulseValue)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, w * 0.42, ringPaint);

    // 3. Crescent Moon inside disk
    final moonCenter = Offset(w * 0.5, h * 0.28);
    final moonRadius = w * 0.10;
    final moonPath = Path()
      ..addOval(Rect.fromCircle(center: moonCenter, radius: moonRadius));
    final moonCut = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(moonCenter.dx + moonRadius * 0.35, moonCenter.dy - moonRadius * 0.2),
        radius: moonRadius * 0.85,
      ));
    final crescent = Path.combine(PathOperation.difference, moonPath, moonCut);
    final crescentPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    canvas.drawPath(crescent, crescentPaint);

    // 4. Mosque silhouette (base, minarets, central dome)
    final silhouettePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;

    final mosquePath = Path();
    final baseY = h * 0.76;

    // Base ground line
    mosquePath.moveTo(w * 0.18, baseY);

    // Left Minaret
    mosquePath.lineTo(w * 0.24, baseY);
    mosquePath.lineTo(w * 0.24, h * 0.44);
    mosquePath.lineTo(w * 0.22, h * 0.44);
    mosquePath.lineTo(w * 0.22, h * 0.42);
    mosquePath.lineTo(w * 0.255, h * 0.34); // Spire peak
    mosquePath.lineTo(w * 0.29, h * 0.42);
    mosquePath.lineTo(w * 0.29, h * 0.44);
    mosquePath.lineTo(w * 0.27, h * 0.44);
    mosquePath.lineTo(w * 0.27, baseY);

    // Left Wall
    mosquePath.lineTo(w * 0.34, baseY);
    mosquePath.lineTo(w * 0.34, h * 0.58);

    // Central Dome (onion / oriental dome)
    mosquePath.cubicTo(
      w * 0.34, h * 0.46,
      w * 0.42, h * 0.38,
      w * 0.50, h * 0.34, // Dome apex
    );
    mosquePath.cubicTo(
      w * 0.58, h * 0.38,
      w * 0.66, h * 0.46,
      w * 0.66, h * 0.58,
    );

    // Right Wall
    mosquePath.lineTo(w * 0.66, baseY);
    mosquePath.lineTo(w * 0.73, baseY);

    // Right Minaret
    mosquePath.lineTo(w * 0.73, h * 0.44);
    mosquePath.lineTo(w * 0.71, h * 0.44);
    mosquePath.lineTo(w * 0.71, h * 0.42);
    mosquePath.lineTo(w * 0.745, h * 0.34); // Spire peak
    mosquePath.lineTo(w * 0.78, h * 0.42);
    mosquePath.lineTo(w * 0.78, h * 0.44);
    mosquePath.lineTo(w * 0.76, h * 0.44);
    mosquePath.lineTo(w * 0.76, baseY);
    mosquePath.lineTo(w * 0.82, baseY);

    mosquePath.close();
    canvas.drawPath(mosquePath, silhouettePaint);

    // Central Arched Doorway (cutout)
    final doorPaint = Paint()
      ..color = const Color(0xFF0D1426)
      ..style = PaintingStyle.fill;
    final doorPath = Path()
      ..moveTo(w * 0.46, baseY)
      ..lineTo(w * 0.46, h * 0.66)
      ..arcToPoint(
        Offset(w * 0.54, h * 0.66),
        radius: Radius.circular(w * 0.04),
      )
      ..lineTo(w * 0.54, baseY)
      ..close();
    canvas.drawPath(doorPath, doorPaint);
  }

  @override
  bool shouldRepaint(covariant MosqueArchPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue || oldDelegate.accentColor != accentColor;
  }
}
