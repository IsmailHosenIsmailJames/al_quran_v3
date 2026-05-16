class UserProfile {
  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? photoUrl;
  final String? bio;
  final String? country;
  final String? gender;
  final AvatarUrls? avatarUrls;
  final int postsCount;
  final int followersCount;
  final int followingsCount;
  final int likesCount;
  final bool isAdmin;
  final bool isPasswordSet;
  final UserSettings? settings;
  final DateTime? createdAt;

  UserProfile({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.bio,
    this.country,
    this.gender,
    this.avatarUrls,
    this.postsCount = 0,
    this.followersCount = 0,
    this.followingsCount = 0,
    this.likesCount = 0,
    this.isAdmin = false,
    this.isPasswordSet = false,
    this.settings,
    this.createdAt,
  });

  String get displayName {
    if (firstName != null && lastName != null && firstName!.isNotEmpty) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName ?? username ?? 'User';
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString() ?? '',
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      avatarUrls: json['avatarUrls'] != null
          ? AvatarUrls.fromJson(json['avatarUrls'] as Map<String, dynamic>)
          : null,
      postsCount: _toInt(json['postsCount']) ?? 0,
      followersCount: _toInt(json['followersCount']) ?? 0,
      followingsCount: _toInt(json['followingsCount']) ?? 0,
      likesCount: _toInt(json['likesCount']) ?? 0,
      isAdmin: json['isAdmin'] as bool? ?? false,
      isPasswordSet: json['isPasswordSet'] as bool? ?? false,
      settings: json['settings'] != null
          ? UserSettings.fromJson(json['settings'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'photoUrl': photoUrl,
      'bio': bio,
      'country': country,
      'gender': gender,
      'avatarUrls': avatarUrls?.toJson(),
      'postsCount': postsCount,
      'followersCount': followersCount,
      'followingsCount': followingsCount,
      'likesCount': likesCount,
      'isAdmin': isAdmin,
      'isPasswordSet': isPasswordSet,
      'settings': settings?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class AvatarUrls {
  final String? original;
  final String? medium;
  final String? small;

  AvatarUrls({this.original, this.medium, this.small});

  factory AvatarUrls.fromJson(Map<String, dynamic> json) {
    return AvatarUrls(
      original: json['original'] as String?,
      medium: json['medium'] as String?,
      small: json['small'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original': original,
      'medium': medium,
      'small': small,
    };
  }
}

class UserSettings {
  final int? languageId;
  final bool? notifications;
  final String? theme;

  UserSettings({this.languageId, this.notifications, this.theme});

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      languageId: json['languageId'] as int?,
      notifications: json['notifications'] as bool?,
      theme: json['theme'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageId': languageId,
      'notifications': notifications,
      'theme': theme,
    };
  }
}
