import 'dart:convert';
import 'dart:io';

import 'package:al_quran_v3/src/api/models/user_profile_model.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart';
import 'package:al_quran_v3/src/api/quran_profile_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../theme/controller/theme_cubit.dart';
import '../../theme/controller/theme_state.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _countryController;

  File? _imageFile;
  String? _base64Image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _usernameController = TextEditingController(text: widget.profile.username);
    _bioController = TextEditingController(text: widget.profile.bio);
    _countryController = TextEditingController(text: widget.profile.country);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final extension = path.extension(pickedFile.path).replaceAll('.', '');
      
      setState(() {
        _imageFile = file;
        _base64Image = 'data:image/$extension;base64,${base64Encode(bytes)}';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await QuranProfileApi.updateProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        country: _countryController.text,
        avatar: _base64Image,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, true);
      }
    } on QuranApiException catch (e) {
      if (mounted) {
        _showErrorDialog(e.message, e.type);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
        title: const Text('Update Failed'),
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
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions: [
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                IconButton(
                  onPressed: _saveProfile,
                  icon: const Icon(FluentIcons.checkmark_24_regular),
                  tooltip: 'Save',
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAvatarPicker(themeState),
                  const Gap(32),
                  _buildTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    icon: FluentIcons.person_24_regular,
                    themeState: themeState,
                  ),
                  const Gap(16),
                  _buildTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    icon: FluentIcons.person_24_regular,
                    themeState: themeState,
                  ),
                  const Gap(16),
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                    icon: FluentIcons.mention_24_regular,
                    themeState: themeState,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      if (value.length < 3) {
                        return 'Username too short';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  _buildTextField(
                    controller: _countryController,
                    label: 'Country',
                    icon: FluentIcons.globe_24_regular,
                    themeState: themeState,
                  ),
                  const Gap(16),
                  _buildTextField(
                    controller: _bioController,
                    label: 'Bio',
                    icon: FluentIcons.text_description_24_regular,
                    themeState: themeState,
                    maxLines: 3,
                  ),
                  const Gap(40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeState.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildAvatarPicker(ThemeState themeState) {
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
            child: CircleAvatar(
              radius: 60,
              backgroundColor: themeState.primary.withValues(alpha: 0.1),
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : (widget.profile.avatarUrls?.medium != null
                      ? CachedNetworkImageProvider(
                          widget.profile.avatarUrls!.medium!)
                      : null) as ImageProvider?,
              child: _imageFile == null &&
                      widget.profile.avatarUrls?.medium == null
                  ? Icon(
                      FluentIcons.person_24_regular,
                      size: 60,
                      color: themeState.primary,
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeState.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  FluentIcons.camera_24_regular,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ThemeState themeState,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: themeState.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: themeState.mutedGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: themeState.mutedGray.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: themeState.primary, width: 2),
        ),
        filled: true,
        fillColor: themeState.mutedGray.withValues(alpha: 0.05),
      ),
    );
  }
}
