import "package:al_quran_v3/src/features/auth/domain/entities/user_entity.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/foundation.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:injectable/injectable.dart";

abstract class FirebaseAuthDataSource {
  UserEntity? get currentUser;
  Stream<UserEntity?> get authStateChanges;
  Future<UserEntity> signInWithGoogle();
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });
  Future<UserEntity> signInAnonymously();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> deleteAccount();
}

@LazySingleton(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: "562324718404-qcit8fhnjk81cvgj1b6k8sbargh5ohdm.apps.googleusercontent.com",
    scopes: ["email", "profile"],
  );
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  FirebaseAuthDataSourceImpl();

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserEntity.fromFirebaseUser(user) : null;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(
          (user) => user != null ? UserEntity.fromFirebaseUser(user) : null,
        );
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google sign in was cancelled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        throw Exception("Failed to sign in with Google.");
      }

      // Record profile in Realtime Database
      try {
        await _database.ref("users/${user.uid}/profile").update({
          "uid": user.uid,
          "email": user.email,
          "displayName": user.displayName,
          "photoUrl": user.photoURL,
          "lastLoginAt": ServerValue.timestamp,
        });
      } catch (_) {}

      return UserEntity.fromFirebaseUser(user);
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception("Sign in failed. No user found.");
      }

      try {
        await _database.ref("users/${user.uid}/profile").update({
          "lastLoginAt": ServerValue.timestamp,
        });
      } catch (_) {}

      return UserEntity.fromFirebaseUser(user);
    } catch (e) {
      debugPrint("Error signing in with email: $e");
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception("Failed to create account.");
      }

      if (displayName.trim().isNotEmpty) {
        await user.updateDisplayName(displayName.trim());
      }

      try {
        await _database.ref("users/${user.uid}/profile").update({
          "uid": user.uid,
          "email": user.email,
          "displayName": displayName.trim(),
          "createdAt": ServerValue.timestamp,
          "lastLoginAt": ServerValue.timestamp,
        });
      } catch (_) {}

      await user.reload();
      final updatedUser = _firebaseAuth.currentUser ?? user;
      return UserEntity.fromFirebaseUser(updatedUser);
    } catch (e) {
      debugPrint("Error signing up: $e");
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInAnonymously();
      final user = credential.user;
      if (user == null) {
        throw Exception("Failed to sign in anonymously.");
      }
      return UserEntity.fromFirebaseUser(user);
    } catch (e) {
      debugPrint("Error signing in anonymously: $e");
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      debugPrint("Error sending password reset: $e");
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
    } catch (e) {
      debugPrint("Error signing out: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return;

      final uid = user.uid;

      // 1. Wipe all Realtime Database user data to satisfy GDPR / Google Play compliance
      try {
        final userRef = _database.ref("users/$uid");
        await userRef.remove();
      } catch (e) {
        debugPrint("Error removing user database tree: $e");
      }

      // 2. Delete the Firebase Auth User
      await user.delete();

      // 3. Google Sign in disconnect
      try {
        await _googleSignIn.disconnect();
      } catch (_) {}
    } catch (e) {
      debugPrint("Error deleting account: $e");
      rethrow;
    }
  }
}
