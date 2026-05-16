import 'dart:ui';
import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/api/models/user_profile_model.dart';
import 'package:al_quran_v3/src/api/quran_auth_service.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart';
import 'package:al_quran_v3/src/api/quran_profile_api.dart';
import 'package:al_quran_v3/src/screen/about/about_the_app.dart';
import 'package:al_quran_v3/src/screen/profile/edit_profile_page.dart';
import 'package:al_quran_v3/src/screen/settings/settings_page.dart';
import 'package:al_quran_v3/src/widget/theme/theme_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/controller/theme_cubit.dart';
import '../../theme/controller/theme_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  UserProfile? _profile;
  String? _error;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = QuranAuthSession.isLoggedIn;
    if (_isLoggedIn) {
      // Load cached profile for instant display
      _profile = QuranAuthSession.getCachedUserProfile();
      _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading =
          _profile ==
          null; // Only show loading if we don't have a cached profile
      _error = null;
    });

    try {
      final profile = await QuranProfileApi.getProfile();
      // Cache the profile for offline use
      await QuranAuthSession.saveUserProfile(profile);

      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } on QuranApiException catch (e) {
      setState(() {
        _error = e.message;
      });
      _showErrorDialog(e.message, e.type);
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch profile: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message, String? errorType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(
          FluentIcons.error_circle_24_regular,
          size: 40,
          color: Colors.red.shade400,
        ),
        title: const Text('Profile Error'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(message),
            if (errorType != null) ...[
              const Gap(8),
              Text(
                'Error type: $errorType',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await QuranAuthService.login();
      if (result != null) {
        setState(() {
          _isLoggedIn = true;
        });
        await _fetchProfile();
      } else {
        setState(() {
          _error = 'Login cancelled or failed.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    await QuranAuthService.logout();
    setState(() {
      _isLoggedIn = false;
      _profile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(appLocalizations.profile),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: themeState.mutedGray),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Theme.brightnessOf(context) == Brightness.dark
                ? Colors.grey.shade900.withValues(alpha: 0.5)
                : Colors.grey.shade200.withValues(alpha: 0.5),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  _buildProfileHeader(themeState),
                  const Gap(30),
                  if (!_isLoggedIn) ...[
                    const Text(
                      'Welcome to Al-Quran',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(12),
                    const Text(
                      'Connect with the Quran Foundation to sync your bookmarks, notes, and reading progress across all your devices.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    const Gap(40),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _handleLogin,
                          icon: const Icon(FluentIcons.person_board_24_regular),
                          label: const Text('Login with Quran Foundation'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeState.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                  ] else ...[
                    if (_isLoading && _profile == null)
                      const Center(child: CircularProgressIndicator())
                    else if (_profile != null)
                      _buildProfileInfo(themeState)
                    else if (_error != null)
                      Column(
                        children: [
                          const Icon(
                            FluentIcons.error_circle_24_regular,
                            size: 48,
                            color: Colors.red,
                          ),
                          const Gap(16),
                          Text(_error!, textAlign: TextAlign.center),
                          const Gap(16),
                          ElevatedButton(
                            onPressed: _fetchProfile,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    const Gap(30),
                    _buildSettingsList(themeState),
                    const Gap(30),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _handleLogout,
                        icon: const Icon(FluentIcons.power_24_regular),
                        label: const Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(ThemeState themeState) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: themeState.primary.withValues(alpha: 0.2),
                width: 4,
              ),
            ),
            child: Hero(
              tag: 'profile_avatar',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: themeState.primary.withValues(alpha: 0.1),
                backgroundImage: _profile?.avatarUrls?.medium != null
                    ? CachedNetworkImageProvider(_profile!.avatarUrls!.medium!)
                    : null,
                child: _profile?.avatarUrls?.medium == null
                    ? Icon(
                        FluentIcons.person_24_regular,
                        size: 60,
                        color: themeState.primary,
                      )
                    : null,
              ),
            ),
          ),
          if (_isLoggedIn)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: themeState.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FluentIcons.checkmark_24_filled,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(ThemeState themeState) {
    return Column(
      children: [
        Text(
          _profile!.displayName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        if (_profile!.username != null) ...[
          const Gap(4),
          Text(
            '@${_profile!.username}',
            style: TextStyle(
              fontSize: 16,
              color: themeState.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        if (_profile!.bio != null && _profile!.bio!.isNotEmpty) ...[
          const Gap(16),
          Text(
            _profile!.bio!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
        /*
        const Gap(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem('Followers', _profile!.followersCount.toString()),
            _buildStatSeparator(themeState),
            _buildStatItem('Following', _profile!.followingsCount.toString()),
            _buildStatSeparator(themeState),
            _buildStatItem('Likes', _profile!.likesCount.toString()),
          ],
        ),
        */
        /*
        const Gap(32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              final updated = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(profile: _profile!),
                ),
              );
              if (updated == true) {
                _fetchProfile();
              }
            },
            icon: const Icon(FluentIcons.edit_24_regular),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
        ),
        */
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Gap(4),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatSeparator(ThemeState themeState) {
    return Container(
      height: 24,
      width: 1,
      color: themeState.mutedGray.withValues(alpha: 0.3),
    );
  }

  Widget _buildSettingsList(ThemeState themeState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GENERAL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
        const Gap(12),
        _buildSettingsItem(
          icon: FluentIcons.settings_24_regular,
          title: 'App Settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          themeState: themeState,
        ),
        _buildSettingsItem(
          icon: FluentIcons.lock_closed_24_regular,
          title: 'Privacy Policy',
          onTap: () {
            launchUrl(
              Uri.parse(
                "https://github.com/IsmailHosenIsmailJames/al_quran_v3/blob/main/PRIVACY_POLICY.md",
              ),
              mode: LaunchMode.externalApplication,
            );
          },
          themeState: themeState,
        ),
        _buildSettingsItem(
          icon: FluentIcons.question_circle_24_regular,
          title: 'About & Help',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutAppPage()),
            );
          },
          themeState: themeState,
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeState themeState,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: themeState.mutedGray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: themeState.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(FluentIcons.chevron_right_24_regular, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
