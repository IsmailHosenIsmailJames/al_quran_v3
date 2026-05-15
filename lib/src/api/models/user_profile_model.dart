class UserProfile {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? bio;
  final String? country;
  final String? gender;
  final AvatarUrls? avatarUrls;
  final int postsCount;
  final int followersCount;
  final int followingsCount;
  final int likesCount;
  final UserSettings? settings;

  UserProfile({
    required this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.bio,
    this.country,
    this.gender,
    this.avatarUrls,
    this.postsCount = 0,
    this.followersCount = 0,
    this.followingsCount = 0,
    this.likesCount = 0,
    this.settings,
  });

  String get displayName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName ?? username ?? 'User';
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      bio: json['bio'] as String?,
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      avatarUrls: json['avatarUrls'] != null
          ? AvatarUrls.fromJson(json['avatarUrls'] as Map<String, dynamic>)
          : null,
      postsCount: json['postsCount'] as int? ?? 0,
      followersCount: json['followersCount'] as int? ?? 0,
      followingsCount: json['followingsCount'] as int? ?? 0,
      likesCount: json['likesCount'] as int? ?? 0,
      settings: json['settings'] != null
          ? UserSettings.fromJson(json['settings'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'bio': bio,
      'country': country,
      'gender': gender,
      'avatarUrls': avatarUrls?.toJson(),
      'postsCount': postsCount,
      'followersCount': followersCount,
      'followingsCount': followingsCount,
      'likesCount': likesCount,
      'settings': settings?.toJson(),
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
