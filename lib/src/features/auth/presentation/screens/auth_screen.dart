import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
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
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();

  bool _obscureSignInPassword = true;
  bool _obscureSignUpPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your email address and we will send you a link to reset your password.",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const Gap(14),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  prefixIcon: const Icon(FluentIcons.mail_24_regular),
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
          context.read<SyncCubit>().sync(state.user.uid);
          Fluttertoast.showToast(
            msg:
                "Welcome, ${state.user.displayName ?? state.user.email ?? 'User'}!",
          );
          Navigator.pop(context);
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Top Islamic Branding Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? themeState.primary.withValues(alpha: 0.12)
                        : themeState.primaryShade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: themeState.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FluentIcons.cloud_sync_24_filled,
                        size: 48,
                        color: themeState.primary,
                      ),
                      const Gap(10),
                      Text(
                        l10n.syncedCloudBackup,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: themeState.primary,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        l10n.syncedCloudBackupDesc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(20),

                // Google Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(
                        color: isDark ? Colors.white24 : Colors.grey.shade300,
                      ),
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
                              const Icon(Icons.g_mobiledata_rounded, size: 28),
                        ),
                        const Gap(12),
                        Text(
                          l10n.googleSignIn,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(16),

                // Divider
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
                          fontSize: 12,
                          color: Colors.grey.shade500,
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

                // Tab Bar for Sign In / Sign Up
                TabBar(
                  controller: _tabController,
                  indicatorColor: themeState.primary,
                  labelColor: themeState.primary,
                  unselectedLabelColor: isDark
                      ? Colors.grey.shade400
                      : Colors.grey.shade600,
                  tabs: [
                    Tab(text: l10n.signIn),
                    Tab(text: l10n.signUp),
                  ],
                ),

                const Gap(16),

                // Tab View
                SizedBox(
                  height: 280,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Sign In Tab
                      Column(
                        children: [
                          TextField(
                            controller: _signInEmailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              prefixIcon: const Icon(
                                FluentIcons.mail_24_regular,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const Gap(12),
                          TextField(
                            controller: _signInPasswordController,
                            obscureText: _obscureSignInPassword,
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              prefixIcon: const Icon(
                                FluentIcons.lock_closed_24_regular,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureSignInPassword
                                      ? FluentIcons.eye_24_regular
                                      : FluentIcons.eye_off_24_regular,
                                ),
                                onPressed: () => setState(
                                  () => _obscureSignInPassword =
                                      !_obscureSignInPassword,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  _showForgotPasswordDialog(context),
                              child: Text(
                                l10n.forgotPassword,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                          const Gap(6),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final email = _signInEmailController.text
                                          .trim();
                                      final pass =
                                          _signInPasswordController.text;
                                      if (email.isNotEmpty && pass.isNotEmpty) {
                                        context
                                            .read<AuthCubit>()
                                            .signInWithEmail(
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
                      ),

                      // Sign Up Tab
                      Column(
                        children: [
                          TextField(
                            controller: _signUpNameController,
                            decoration: InputDecoration(
                              labelText: l10n.fullName,
                              prefixIcon: const Icon(
                                FluentIcons.person_24_regular,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const Gap(10),
                          TextField(
                            controller: _signUpEmailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              prefixIcon: const Icon(
                                FluentIcons.mail_24_regular,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const Gap(10),
                          TextField(
                            controller: _signUpPasswordController,
                            obscureText: _obscureSignUpPassword,
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              prefixIcon: const Icon(
                                FluentIcons.lock_closed_24_regular,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureSignUpPassword
                                      ? FluentIcons.eye_24_regular
                                      : FluentIcons.eye_off_24_regular,
                                ),
                                onPressed: () => setState(
                                  () => _obscureSignUpPassword =
                                      !_obscureSignUpPassword,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const Gap(14),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final name = _signUpNameController.text
                                          .trim();
                                      final email = _signUpEmailController.text
                                          .trim();
                                      final pass =
                                          _signUpPasswordController.text;
                                      if (email.isNotEmpty && pass.isNotEmpty) {
                                        context
                                            .read<AuthCubit>()
                                            .signUpWithEmail(
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
                      ),
                    ],
                  ),
                ),

                const Gap(10),

                // Continue as Guest Option
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<AuthCubit>().signInAnonymously();
                        },
                  child: Text(
                    l10n.continueAsGuest,
                    style: TextStyle(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
                  ),
                ),

                const Gap(8),

                // Privacy Policy / Play Store Compliance Notice
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
        );
      },
    );
  }
}
