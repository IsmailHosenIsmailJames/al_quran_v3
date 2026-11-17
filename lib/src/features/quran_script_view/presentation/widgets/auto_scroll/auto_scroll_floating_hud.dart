import "dart:ui";

import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/auto_scroll_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/auto_scroll_state.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class AutoScrollFloatingHud extends StatelessWidget {
  final VoidCallback? onTrigger;
  final VoidCallback? onDismiss;
  final bool isFabVisible;

  const AutoScrollFloatingHud({
    super.key,
    this.onTrigger,
    this.onDismiss,
    this.isFabVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = context.watch<ThemeCubit>().state.primary;

    return BlocBuilder<AutoScrollCubit, AutoScrollState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.88, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: state.isActive
              ? _buildExpandedHud(context, state, primary, isDark)
              : _buildFloatingTriggerButton(context, primary, isDark),
        );
      },
    );
  }

  /// Compact, elegantly styled Floating Action Button for triggering Auto-Scroll.
  Widget _buildFloatingTriggerButton(
    BuildContext context,
    Color primary,
    bool isDark,
  ) {
    return SafeArea(
      key: const ValueKey("auto_scroll_fab"),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16),
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            offset: isFabVisible ? Offset.zero : const Offset(0, 1.8),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              opacity: isFabVisible ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !isFabVisible,
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onTrigger?.call();
                    },
                    child: Tooltip(
                      message: "Auto-Scroll Reading",
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary,
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: isDark ? 0.45 : 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Expanded glassmorphic control capsule docked at bottom center.
  Widget _buildExpandedHud(
    BuildContext context,
    AutoScrollState state,
    Color primary,
    bool isDark,
  ) {
    final isPlaying = state.isPlaying;
    final isPausedByTouch = state.isPausedByTouch;

    return SafeArea(
      key: const ValueKey("auto_scroll_expanded_hud"),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1E1E1E).withValues(alpha: 0.92)
                : Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : primary.withValues(alpha: 0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.12),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Play / Pause Action Button
                    Material(
                      color: primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          HapticFeedback.selectionClick();
                          if (isPausedByTouch) {
                            context.read<AutoScrollCubit>().resumeFromTouch();
                          } else {
                            context.read<AutoScrollCubit>().togglePlayPause();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),

                    const Gap(10),

                    // Current Status & Ayah Info
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Auto-Scroll",
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF111827),
                                ),
                              ),
                              const Gap(6),
                              if (isPausedByTouch)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withValues(
                                      alpha: isDark ? 0.25 : 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Paused",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.amber.shade300
                                          : Colors.amber.shade900,
                                    ),
                                  ),
                                )
                              else if (isPlaying)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primary.withValues(
                                      alpha: isDark ? 0.25 : 0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Gap(1.5),
                          Text(
                            state.currentAyahKey != null
                                ? "Ayah ${state.currentAyahKey}"
                                : "Reading",
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

                    const Gap(10),

                    // Speed Stepper [-] [Speed] [+]
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSpeedButton(
                            icon: Icons.remove_rounded,
                            isDark: isDark,
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              context.read<AutoScrollCubit>().decreaseSpeed();
                            },
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              context.read<AutoScrollCubit>().increaseSpeed();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                "${state.speed.toStringAsFixed(state.speed % 1 == 0 ? 0 : (state.speed == 0.75 || state.speed == 1.25 ? 2 : 1))}x",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: primary,
                                ),
                              ),
                            ),
                          ),
                          _buildSpeedButton(
                            icon: Icons.add_rounded,
                            isDark: isDark,
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              context.read<AutoScrollCubit>().increaseSpeed();
                            },
                          ),
                        ],
                      ),
                    ),

                    const Gap(6),

                    // Close HUD Button
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 22),
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                      tooltip: "Close Auto-Scroll",
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        context.read<AutoScrollCubit>().deactivate();
                        onDismiss?.call();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedButton({
    required IconData icon,
    required bool isDark,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}
