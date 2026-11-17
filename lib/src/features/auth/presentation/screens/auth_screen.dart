import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:url_launcher/url_launcher.dart";

class AuthScreen extends StatefulWidget {
  final bool isEmbedded;
  const AuthScreen({super.key, this.isEmbedded = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _selectedTabIndex = 0; // 0: Sign In, 1: Create Account

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();

  bool _obscureSignInPassword = true;
  bool _obscureSignUpPassword = true;

  @override
  void dispose() {
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    super.dispose();
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emailController = TextEditingController(
      text: _signInEmailController.text,
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            l10n.forgotPassword,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your email address and we will send you a link to reset your password.",
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
              ),
              const Gap(14),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 13.5),
                decoration: InputDecoration(
                  labelText: l10n.email,
                  prefixIcon: const Icon(FluentIcons.mail_24_regular, size: 20),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty) return;
                try {
                  await context.read<AuthCubit>().sendPasswordResetEmail(email);
                  if (ctx.mounted) Navigator.pop(ctx);
                  Fluttertoast.showToast(msg: l10n.resetPasswordEmailSent);
                } catch (_) {}
              },
              child: Text(l10n.sendResetLink),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openPrivacyPolicy() async {
    final url = Uri.parse("https://alquran.cloud/privacy-policy");
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          if (!state.user.isAnonymous) {
            context.read<SyncCubit>().sync(state.user.uid);
          }
          Fluttertoast.showToast(
            msg:
                "Welcome, ${state.user.displayName ?? state.user.email ?? (state.user.isAnonymous ? l10n.guestUser : 'User')}!",
          );
          if (!widget.isEmbedded && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        } else if (state is AuthError) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.accountAndSync,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // 1. Compact Header Banner
                  _buildCompactHeader(l10n, themeState, isDark),

                  const Gap(14),

                  // 2. Feature Value Showcase Grid
                  _buildFeatureChips(l10n, themeState, isDark),

                  const Gap(16),

                  // 3. Google Sign-In Button
                  _buildGoogleSignInButton(l10n, isLoading, isDark),

                  const Gap(16),

                  // 4. Subtle OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.white12 : Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.white12 : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),

                  const Gap(16),

                  // 5. Segmented Tab Switch (Sign In / Create Account)
                  _buildSegmentedSwitch(l10n, themeState, isDark),

                  const Gap(16),

                  // 6. Auth Form (Sign In or Sign Up)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _selectedTabIndex == 0
                        ? _buildSignInForm(l10n, themeState, isDark, isLoading)
                        : _buildSignUpForm(l10n, themeState, isDark, isLoading),
                  ),

                  const Gap(14),

                  // 7. Continue as Guest (with clean button design)
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        side: BorderSide(
                          color: isDark ? Colors.white12 : Colors.grey.shade300,
                          width: 1.1,
                        ),
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.02)
                            : Colors.white,
                      ),
                      onPressed: isLoading
                          ? null
                          : () => context.read<AuthCubit>().signInAnonymously(),
                      icon: Icon(
                        FluentIcons.person_question_mark_24_regular,
                        size: 17,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade700,
                      ),
                      label: Text(
                        "${l10n.continueAsGuest} (Local storage only)",
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),

                  const Gap(12),

                  // 8. Privacy Policy notice
                  InkWell(
                    onTap: _openPrivacyPolicy,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        l10n.privacyPolicyNotice,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: themeState.primary,
                          decoration: TextDecoration.underline,
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

  Widget _buildCompactHeader(
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade200,
          width: 1.1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeState.primary,
                  themeState.primary.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: themeState.primary.withValues(alpha: 0.32),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              FluentIcons.cloud_sync_24_filled,
              size: 23,
              color: Colors.white,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.syncedCloudBackup,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5,
                        color: isDark ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: themeState.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: themeState.primary.withValues(alpha: 0.22),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FluentIcons.checkmark_12_filled,
                            size: 11,
                            color: themeState.primary,
                          ),
                          const Gap(3),
                          Text(
                            "FREE",
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: themeState.primary,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  "Never lose your notes, bookmarks, streaks, or reading plans. Access everything seamlessly across all your devices.",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.38,
                    color: isDark ? Colors.grey.shade400 : const Color(0xFF4B5563),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChips(
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
  ) {
    final chips = [
      (FluentIcons.notepad_24_filled, l10n.notes),
      (FluentIcons.pin_24_filled, l10n.pinned),
      (FluentIcons.history_24_filled, l10n.history),
      (Icons.local_fire_department_rounded, "Streaks"),
      (FluentIcons.book_star_24_filled, "Khatam"),
      (FluentIcons.flash_24_filled, l10n.quickAccess),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 16) / 3;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: chips.map((chip) {
            return SizedBox(
              width: cardWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                  ),
                  boxShadow: isDark
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      chip.$1,
                      size: 20,
                      color: themeState.primary,
                    ),
                    const Gap(5),
                    Text(
                      chip.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildGoogleSignInButton(
    AppLocalizations l10n,
    bool isLoading,
    bool isDark,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(
            color: isDark ? Colors.white24 : Colors.grey.shade300,
            width: 1.1,
          ),
          backgroundColor: isDark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          elevation: isDark ? 0 : 0.5,
          shadowColor: Colors.black.withValues(alpha: 0.1),
        ),
        onPressed: isLoading
            ? null
            : () => context.read<AuthCubit>().signInWithGoogle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/google.png",
              height: 22,
              width: 22,
              errorBuilder: (ctx, err, stack) =>
                  const Icon(Icons.g_mobiledata_rounded, size: 26),
            ),
            const Gap(12),
            Text(
              l10n.googleSignIn,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedSwitch(
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
  ) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade300,
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTabIndex = 0),
              borderRadius: BorderRadius.circular(11),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? themeState.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: _selectedTabIndex == 0
                      ? [
                          BoxShadow(
                            color: themeState.primary.withValues(alpha: 0.28),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  l10n.signIn,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: _selectedTabIndex == 0
                        ? FontWeight.bold
                        : FontWeight.w600,
                    color: _selectedTabIndex == 0
                        ? Colors.white
                        : (isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade700),
                  ),
                ),
              ),
            ),
          ),
          const Gap(4),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedTabIndex = 1),
              borderRadius: BorderRadius.circular(11),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? themeState.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: _selectedTabIndex == 1
                      ? [
                          BoxShadow(
                            color: themeState.primary.withValues(alpha: 0.28),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  l10n.signUp,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: _selectedTabIndex == 1
                        ? FontWeight.bold
                        : FontWeight.w600,
                    color: _selectedTabIndex == 1
                        ? Colors.white
                        : (isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForm(
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
    bool isLoading,
  ) {
    return Column(
      key: const ValueKey("sign_in_form"),
      children: [
        TextField(
          controller: _signInEmailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: l10n.email,
            isDense: true,
            prefixIcon: const Icon(FluentIcons.mail_24_regular, size: 20),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: themeState.primary, width: 1.6),
            ),
          ),
        ),
        const Gap(12),
        TextField(
          controller: _signInPasswordController,
          obscureText: _obscureSignInPassword,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: l10n.password,
            isDense: true,
            prefixIcon: const Icon(
              FluentIcons.lock_closed_24_regular,
              size: 20,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureSignInPassword
                    ? FluentIcons.eye_24_regular
                    : FluentIcons.eye_off_24_regular,
                size: 20,
              ),
              onPressed: () => setState(
                () => _obscureSignInPassword = !_obscureSignInPassword,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: themeState.primary, width: 1.6),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => _showForgotPasswordDialog(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              minimumSize: const Size(0, 32),
            ),
            child: Text(
              l10n.forgotPassword,
              style: TextStyle(
                fontSize: 12.5,
                color: themeState.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Gap(4),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    final email = _signInEmailController.text.trim();
                    final pass = _signInPasswordController.text;
                    if (email.isNotEmpty && pass.isNotEmpty) {
                      context.read<AuthCubit>().signInWithEmail(
                            email: email,
                            password: pass,
                          );
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    l10n.signIn,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm(
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
    bool isLoading,
  ) {
    return Column(
      key: const ValueKey("sign_up_form"),
      children: [
        TextField(
          controller: _signUpNameController,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: l10n.fullName,
            isDense: true,
            prefixIcon: const Icon(FluentIcons.person_24_regular, size: 20),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: themeState.primary, width: 1.6),
            ),
          ),
        ),
        const Gap(12),
        TextField(
          controller: _signUpEmailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: l10n.email,
            isDense: true,
            prefixIcon: const Icon(FluentIcons.mail_24_regular, size: 20),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: themeState.primary, width: 1.6),
            ),
          ),
        ),
        const Gap(12),
        TextField(
          controller: _signUpPasswordController,
          obscureText: _obscureSignUpPassword,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: l10n.password,
            isDense: true,
            prefixIcon: const Icon(
              FluentIcons.lock_closed_24_regular,
              size: 20,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureSignUpPassword
                    ? FluentIcons.eye_24_regular
                    : FluentIcons.eye_off_24_regular,
                size: 20,
              ),
              onPressed: () => setState(
                () => _obscureSignUpPassword = !_obscureSignUpPassword,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: isDark ? Colors.white10 : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: themeState.primary, width: 1.6),
            ),
          ),
        ),
        const Gap(16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: isLoading
                ? null
                : () {
                    final name = _signUpNameController.text.trim();
                    final email = _signUpEmailController.text.trim();
                    final pass = _signUpPasswordController.text;
                    if (email.isNotEmpty && pass.isNotEmpty) {
                      context.read<AuthCubit>().signUpWithEmail(
                            email: email,
                            password: pass,
                            displayName: name,
                          );
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    l10n.signUp,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
