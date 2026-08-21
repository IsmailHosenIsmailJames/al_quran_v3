import "package:firebase_auth/firebase_auth.dart";

/// Domain entity representing the authenticated user.
class UserEntity {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;

  const UserEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.isAnonymous = false,
  });

  factory UserEntity.fromFirebaseUser(User user) {
    return UserEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "isAnonymous": isAnonymous,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map["uid"] as String,
      email: map["email"] as String?,
      displayName: map["displayName"] as String?,
      photoUrl: map["photoUrl"] as String?,
      isAnonymous: map["isAnonymous"] as bool? ?? false,
    );
  }
}
