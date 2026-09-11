import "dart:developer";
import "dart:io";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/screens/home_page.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/location/presentation/screens/location_acquire_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/models/prayer_reminder_mode.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:geolocator/geolocator.dart";
import "package:hive_ce/hive.dart";
import "package:permission_handler/permission_handler.dart";

class PrayerGuidanceSetupScreen extends StatefulWidget {
  final bool isFromSettings;

  const PrayerGuidanceSetupScreen({super.key, this.isFromSettings = false});

  @override
  State<PrayerGuidanceSetupScreen> createState() =>
      _PrayerGuidanceSetupScreenState();
}

class _PrayerGuidanceSetupScreenState extends State<PrayerGuidanceSetupScreen>
    with WidgetsBindingObserver {
  String _selectedPreset = "balanced";
  bool _hasNotificationPermission = false;
  bool _hasExactAlarmPermission = false;
  bool _isDetectingLocation = false;

  final List<Prayer> _corePrayers = [
    Prayer.fajr,
    Prayer.sunrise,
    Prayer.dhuhr,
    Prayer.asr,
    Prayer.maghrib,
    Prayer.isha,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
      if (mounted) {
        context.read<PrayerReminderCubit>().checkAllPermissions();
      }
    }
  }

  Future<void> _checkPermissions() async {
    try {
      bool notifAllowed = false;
      try {
        notifAllowed = await AwesomeNotifications().isNotificationAllowed();
      } catch (_) {}

      if (!kIsWeb && Platform.isAndroid) {
        final notifStatus = await Permission.notification.status;
        if (notifStatus.isGranted) {
          notifAllowed = true;
        }
      }

      bool exactAlarmAllowed = true;
      if (!kIsWeb && Platform.isAndroid) {
        final status = await Permission.scheduleExactAlarm.status;
        exactAlarmAllowed = status.isGranted;
      }

      if (mounted) {
        context.read<PrayerReminderCubit>().checkAllPermissions();
        setState(() {
          _hasNotificationPermission = notifAllowed;
          _hasExactAlarmPermission = exactAlarmAllowed;
        });
      }
    } catch (_) {}
  }

  Future<void> _requestNotificationPermission() async {
    try {
      if (!kIsWeb && Platform.isAndroid) {
        final status = await Permission.notification.request();
        if (status.isGranted) {
          if (mounted) {
            setState(() => _hasNotificationPermission = true);
          }
        }
      }
      final granted = await AwesomeNotifications()
          .requestPermissionToSendNotifications();
      if (mounted) {
        setState(() {
          _hasNotificationPermission = _hasNotificationPermission || granted;
        });
      }
    } catch (_) {}
    await _checkPermissions();
  }

  Future<void> _requestExactAlarmPermission() async {
    try {
      if (!kIsWeb && Platform.isAndroid) {
        final status = await Permission.scheduleExactAlarm.request();
        if (mounted) {
          setState(() {
            _hasExactAlarmPermission = status.isGranted;
          });
        }
      }
    } catch (_) {}
  }

  Future<void> _detectGpsLocation() async {
    setState(() => _isDetectingLocation = true);
    final l10n = AppLocalizations.of(context);
    try {
      bool isServiceAvailable = await Geolocator.isLocationServiceEnabled();
      if (!isServiceAvailable) {
        Fluttertoast.showToast(msg: l10n.pleaseEnableLocationService);
        await Geolocator.openLocationSettings();
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        if (mounted) {
          await context.read<LocationQiblaPrayerDataCubit>().saveLocationData(
            LatLon(latitude: position.latitude, longitude: position.longitude),
            save: true,
          );
          Fluttertoast.showToast(msg: l10n.selectedLocation);
        }
      }
    } catch (e) {
      log("Error detecting GPS location: $e");
    } finally {
      if (mounted) {
        setState(() => _isDetectingLocation = false);
      }
    }
  }

  void _finishSetup() async {
    final locationState = context.read<LocationQiblaPrayerDataCubit>().state;
    if (locationState.latLon == null && !widget.isFromSettings) {
      Fluttertoast.showToast(
        msg: "Please set your location to calculate prayer times, or tap Skip.",
      );
      return;
    }

    final userBox = Hive.box("user");
    await userBox.put("is_setup_complete", true);

    if (!mounted) return;

    if (widget.isFromSettings) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  void _skipSetup() async {
    final userBox = Hive.box("user");
    await userBox.put("is_setup_complete", true);

    if (!mounted) return;

    if (widget.isFromSettings) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          widget.isFromSettings
              ? l10n.prayerGuidanceSetupTitle
              : l10n.prayerSettings,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: widget.isFromSettings,
        actions: [
          if (!widget.isFromSettings)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: _skipSetup,
                child: Text(
                  l10n.skip,
                  style: TextStyle(
                    color: themeState.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(themeState, isDark, l10n),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
              children: [
                // 1. Mandatory Location Section (Required for prayer times)
                _buildLocationSection(themeState, isDark, l10n),
                const Gap(16),

                // 2. Required Permissions Checklist
                _buildPermissionsSection(themeState, isDark, l10n),
                const Gap(16),

                // 3. Informational Overview (Professional, non-button design)
                _buildReminderInfoSection(themeState, isDark, l10n),
                const Gap(16),

                // 4. One-Tap Bulk Presets
                _buildPresetsSection(themeState, isDark, l10n),
                const Gap(16),

                // 5. Individual Prayer Configuration
                _buildIndividualPrayersSection(themeState, isDark, l10n),
                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Sticky Bottom Bar ──────────────────────────────────────────────────

  Widget _buildBottomBar(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white12 : Colors.grey.shade200,
          ),
        ),
      ),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: _finishSetup,
          style: ElevatedButton.styleFrom(
            backgroundColor: themeState.primary,
            foregroundColor: Colors.white,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.isFromSettings
                      ? l10n.saveAndReturn
                      : l10n.saveAndGetStarted,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(6),
              const Icon(FluentIcons.arrow_right_24_filled, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─── 1. Location Section ─────────────────────────────────────────────────

  Widget _buildLocationSection(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<
      LocationQiblaPrayerDataCubit,
      LocationQiblaPrayerDataState
    >(
      builder: (context, locationState) {
        final hasLocation = locationState.latLon != null;
        final latLon = locationState.latLon;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasLocation
                  ? const Color(0xFF10B981).withValues(alpha: 0.35)
                  : const Color(0xFFF59E0B).withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: hasLocation
                          ? const Color(0xFF10B981).withValues(alpha: 0.12)
                          : const Color(0xFFF59E0B).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      hasLocation
                          ? FluentIcons.location_24_filled
                          : FluentIcons.location_dismiss_24_regular,
                      color: hasLocation
                          ? const Color(0xFF10B981)
                          : const Color(0xFFF59E0B),
                      size: 20,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasLocation
                              ? l10n.selectedLocation
                              : "Prayer Location Required",
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.grey.shade900,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          hasLocation
                              ? "Lat: ${latLon!.latitude.toStringAsFixed(2)}°, Lon: ${latLon.longitude.toStringAsFixed(2)}°"
                              : "Required to calculate prayer times and schedule alarms",
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasLocation)
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LocationAcquire(backToPage: true),
                          ),
                        );
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: themeState.primary,
                        ),
                      ),
                    ),
                ],
              ),
              if (!hasLocation) ...[
                const Gap(14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: _isDetectingLocation
                            ? null
                            : _detectGpsLocation,
                        icon: _isDetectingLocation
                            ? SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: themeState.primary,
                                ),
                              )
                            : const Icon(Icons.my_location_rounded, size: 16),
                        label: Text(
                          _isDetectingLocation
                              ? "Locating..."
                              : l10n.allowLocation,
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LocationAcquire(backToPage: true),
                            ),
                          );
                        },
                        icon: const Icon(
                          FluentIcons.search_16_regular,
                          size: 16,
                        ),
                        label: Text(
                          l10n.manualLocation,
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                            color: isDark
                                ? Colors.white24
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ─── 2. Permissions Checklist ──────────────────────────────────────────

  Widget _buildPermissionsSection(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.requiredPermissions,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
              const Gap(3),
              Text(
                l10n.batteryOptimizationDesc,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              const Gap(12),

              // 1. Notifications Permission
              _buildPermissionTile(
                title: l10n.notification,
                subtitle: l10n.allowNotificationPermission,
                isGranted: _hasNotificationPermission,
                onGrant: _requestNotificationPermission,
                themeState: themeState,
                isDark: isDark,
                grantText: l10n.grantPermission,
                grantedText: l10n.granted,
              ),

              Divider(
                height: 16,
                thickness: 1,
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),

              // 2. Exact Alarm Permission (Android 12+)
              _buildPermissionTile(
                title: l10n.exactAlarmPermission,
                subtitle: l10n.exactAlarmPermissionDesc,
                isGranted: _hasExactAlarmPermission,
                onGrant: _requestExactAlarmPermission,
                themeState: themeState,
                isDark: isDark,
                grantText: l10n.grantPermission,
                grantedText: l10n.granted,
              ),

              Divider(
                height: 16,
                thickness: 1,
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),

              // 3. Full-Screen Intent Permission (Android 14+)
              _buildPermissionTile(
                title: l10n.fullScreenAlarmPermission,
                subtitle: l10n.fullScreenAlarmPermissionDesc,
                isGranted: state.hasFullScreenIntentPermission,
                onGrant: () async {
                  await context
                      .read<PrayerReminderCubit>()
                      .openFullScreenIntentSettings();
                },
                themeState: themeState,
                isDark: isDark,
                grantText: l10n.grantPermission,
                grantedText: l10n.granted,
              ),

              Divider(
                height: 16,
                thickness: 1,
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),

              // 4. Battery Optimization Exemption (Honor, Xiaomi, Samsung)
              _buildPermissionTile(
                title: l10n.batteryOptimizationTitle,
                subtitle: l10n.batteryOptimizationDesc,
                isGranted: state.isIgnoringBatteryOptimizations,
                onGrant: () async {
                  await context
                      .read<PrayerReminderCubit>()
                      .requestIgnoreBatteryOptimizations();
                },
                themeState: themeState,
                isDark: isDark,
                grantText: l10n.grantPermission,
                grantedText: l10n.granted,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPermissionTile({
    required String title,
    required String subtitle,
    required bool isGranted,
    required VoidCallback onGrant,
    required dynamic themeState,
    required bool isDark,
    required String grantText,
    required String grantedText,
  }) {
    return Row(
      children: [
        Icon(
          isGranted
              ? FluentIcons.checkmark_circle_24_filled
              : FluentIcons.warning_24_regular,
          color: isGranted ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
          size: 20,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.5,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        if (!isGranted)
          FilledButton.tonal(
            onPressed: onGrant,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              visualDensity: VisualDensity.compact,
            ),
            child: Text(grantText, style: const TextStyle(fontSize: 11)),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.checkmark_16_regular,
                  color: Color(0xFF10B981),
                  size: 13,
                ),
                const Gap(3),
                Text(
                  grantedText,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ─── 3. Informational Overview (Professional, non-button design) ────────

  Widget _buildReminderInfoSection(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FluentIcons.info_16_regular,
                size: 16,
                color: themeState.primary,
              ),
              const Gap(8),
              Text(
                l10n.howRemindersWork,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
            ],
          ),
          const Gap(10),
          _buildInfoRow(
            icon: Icons.alarm_rounded,
            iconColor: const Color(0xFFE11D48),
            title: l10n.fullScreenAlarmModeTitle,
            desc: l10n.fullScreenAlarmModeDesc,
            isDark: isDark,
          ),
          Divider(
            height: 16,
            thickness: 1,
            color: isDark ? Colors.white10 : Colors.grey.shade100,
          ),
          _buildInfoRow(
            icon: FluentIcons.alert_20_regular,
            iconColor: themeState.primary,
            title: l10n.gentleNotificationModeTitle,
            desc: l10n.gentleNotificationModeDesc,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
              const Gap(2),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.35,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── 4. Bulk Presets ───────────────────────────────────────────────────

  Widget _buildPresetsSection(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickPresets,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
        const Gap(10),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(
            children: [
              _buildPresetRowTile(
                title: l10n.presetBalanced,
                subtitle: l10n.presetBalancedSubtitle,
                badge: "Recommended",
                isSelected: _selectedPreset == "balanced",
                icon: Icons.auto_awesome_rounded,
                themeState: themeState,
                isDark: isDark,
                onTap: () {
                  setState(() => _selectedPreset = "balanced");
                  context.read<PrayerReminderCubit>().applyBulkPreset(
                    "balanced",
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),
              _buildPresetRowTile(
                title: l10n.presetAllAlarms,
                subtitle: l10n.presetAllAlarmsSubtitle,
                isSelected: _selectedPreset == "all_alarm",
                icon: Icons.alarm_on_rounded,
                themeState: themeState,
                isDark: isDark,
                onTap: () {
                  setState(() => _selectedPreset = "all_alarm");
                  context.read<PrayerReminderCubit>().applyBulkPreset(
                    "all_alarm",
                  );
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),
              _buildPresetRowTile(
                title: l10n.presetAllNotifications,
                subtitle: l10n.presetAllNotificationsSubtitle,
                isSelected: _selectedPreset == "all_notification",
                icon: FluentIcons.alert_20_regular,
                themeState: themeState,
                isDark: isDark,
                onTap: () {
                  setState(() => _selectedPreset = "all_notification");
                  context.read<PrayerReminderCubit>().applyBulkPreset(
                    "all_notification",
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPresetRowTile({
    required String title,
    required String subtitle,
    required bool isSelected,
    required IconData icon,
    required dynamic themeState,
    required bool isDark,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? themeState.primary.withValues(alpha: isDark ? 0.15 : 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? FluentIcons.checkmark_circle_24_filled
                  : FluentIcons.circle_24_regular,
              color: isSelected
                  ? themeState.primary
                  : (isDark ? Colors.white30 : Colors.grey.shade400),
              size: 20,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 2,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: isSelected
                              ? themeState.primary
                              : (isDark ? Colors.white : Colors.grey.shade900),
                        ),
                      ),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: themeState.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: isSelected
                  ? themeState.primary
                  : (isDark ? Colors.white24 : Colors.grey.shade400),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  // ─── 5. Individual Prayers ─────────────────────────────────────────────

  Widget _buildIndividualPrayersSection(
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, reminderState) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.prayerSettings,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    "🔕 Off  •  🔔 Notify  •  ⏰ Alarm",
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              ..._corePrayers.map((prayer) {
                final mode =
                    reminderState.prayerReminderModes?[prayer] ??
                    ReminderScheduler.getPrayerReminderMode(prayer);
                final prayerName =
                    PrayerTimeHelper.localizedPrayerName(context, prayer) ??
                    prayer.name;

                return _buildPrayerRowItem(
                  prayer: prayer,
                  prayerName: prayerName,
                  mode: mode,
                  themeState: themeState,
                  isDark: isDark,
                  l10n: l10n,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrayerRowItem({
    required Prayer prayer,
    required String prayerName,
    required PrayerReminderMode mode,
    required dynamic themeState,
    required bool isDark,
    required AppLocalizations l10n,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252528) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              PrayerTimeHelper.getPrayerIcon(prayer),
              color: themeState.primary,
              size: 17,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  prayerName,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _getPrayerModeSubtitle(mode, l10n),
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: mode == PrayerReminderMode.off
                        ? FontWeight.normal
                        : FontWeight.w600,
                    color: _getPrayerModeColor(mode, themeState.primary),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(6),
          _buildSegmentedModePill(
            currentMode: mode,
            onChanged: (newMode) {
              setState(() => _selectedPreset = "custom");
              context.read<PrayerReminderCubit>().setPrayerReminderMode(
                prayer,
                newMode,
              );
            },
            themeState: themeState,
            isDark: isDark,
            l10n: l10n,
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedModePill({
    required PrayerReminderMode currentMode,
    required ValueChanged<PrayerReminderMode> onChanged,
    required dynamic themeState,
    required bool isDark,
    required AppLocalizations l10n,
  }) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPillButton(
            isSelected: currentMode == PrayerReminderMode.off,
            selectedColor: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
            activeIconColor: Colors.white,
            inactiveIconColor: isDark ? Colors.white38 : Colors.grey.shade500,
            icon: Icons.notifications_off_outlined,
            tooltip: l10n.reminderModeOff,
            onTap: () => onChanged(PrayerReminderMode.off),
          ),
          const Gap(2.5),
          _buildPillButton(
            isSelected: currentMode == PrayerReminderMode.notification,
            selectedColor: themeState.primary,
            activeIconColor: Colors.white,
            inactiveIconColor: isDark ? Colors.white38 : Colors.grey.shade500,
            icon: FluentIcons.alert_20_regular,
            tooltip: l10n.reminderModeNotification,
            onTap: () => onChanged(PrayerReminderMode.notification),
          ),
          const Gap(2.5),
          _buildPillButton(
            isSelected: currentMode == PrayerReminderMode.alarm,
            selectedColor: const Color(0xFFE11D48),
            activeIconColor: Colors.white,
            inactiveIconColor: isDark ? Colors.white38 : Colors.grey.shade500,
            icon: Icons.alarm_rounded,
            tooltip: l10n.reminderModeAlarm,
            onTap: () => onChanged(PrayerReminderMode.alarm),
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton({
    required bool isSelected,
    required Color selectedColor,
    required Color activeIconColor,
    required Color inactiveIconColor,
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: selectedColor.withValues(alpha: 0.3),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 16,
            color: isSelected ? activeIconColor : inactiveIconColor,
          ),
        ),
      ),
    );
  }

  String _getPrayerModeSubtitle(
    PrayerReminderMode mode,
    AppLocalizations l10n,
  ) {
    switch (mode) {
      case PrayerReminderMode.off:
        return l10n.reminderModeOff;
      case PrayerReminderMode.notification:
        return l10n.reminderModeNotification;
      case PrayerReminderMode.alarm:
        return l10n.fullScreenAlarmModeTitle;
    }
  }

  Color _getPrayerModeColor(PrayerReminderMode mode, Color primary) {
    switch (mode) {
      case PrayerReminderMode.off:
        return Colors.grey.shade500;
      case PrayerReminderMode.notification:
        return primary;
      case PrayerReminderMode.alarm:
        return const Color(0xFFE11D48);
    }
  }
}
