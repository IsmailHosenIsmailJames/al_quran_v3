import "dart:async";
import "package:al_quran_v3/src/features/auth/domain/entities/user_entity.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/foundation.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
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
  FirebaseAuth? get _firebaseAuth =>
      Firebase.apps.isNotEmpty ? FirebaseAuth.instance : null;
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;
  FirebaseDatabase? get _database =>
      Firebase.apps.isNotEmpty ? FirebaseDatabase.instance : null;

  bool _isGoogleSignInInitialized = false;
  StreamController<UserEntity?>? _combinedAuthStreamController;

  FirebaseAuthDataSourceImpl();

  FirebaseAuth _getRequiredAuth() {
    final auth = _firebaseAuth;
    if (auth == null) {
      throw Exception("Authentication service is currently unavailable.");
    }
    return auth;
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _googleSignIn.initialize(
        serverClientId:
            "562324718404-qcit8fhnjk81cvgj1b6k8sbargh5ohdm.apps.googleusercontent.com",
      );
      _isGoogleSignInInitialized = true;
    }
  }

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth?.currentUser;
    if (user != null) return UserEntity.fromFirebaseUser(user);

    try {
      final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
      if (userBox?.get("is_local_guest_session", defaultValue: false) == true) {
        return const UserEntity(
          uid: "guest_local",
          displayName: "Guest User",
          isAnonymous: true,
        );
      }
    } catch (_) {}

    return null;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    if (_combinedAuthStreamController != null &&
        !_combinedAuthStreamController!.isClosed) {
      return _combinedAuthStreamController!.stream;
    }
    _combinedAuthStreamController = StreamController<UserEntity?>.broadcast();
    final auth = _firebaseAuth;
    if (auth != null) {
      auth.authStateChanges().listen((user) {
        if (user != null) {
          _combinedAuthStreamController?.add(UserEntity.fromFirebaseUser(user));
        } else {
          final guest = currentUser;
          _combinedAuthStreamController?.add(guest);
        }
      });
    }
    return _combinedAuthStreamController!.stream;
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      final auth = _getRequiredAuth();
      await _ensureGoogleSignInInitialized();
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final currentUser = auth.currentUser;
      UserCredential userCredential;

      // If currently an anonymous guest, seamlessly upgrade/link account
      if (currentUser != null && currentUser.isAnonymous) {
        try {
          userCredential = await currentUser.linkWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          if (e.code == "credential-already-in-use" ||
              e.code == "provider-already-linked") {
            userCredential =
                await auth.signInWithCredential(credential);
          } else {
            rethrow;
          }
        }
      } else {
        userCredential =
            await auth.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user == null) {
        throw Exception("Failed to sign in with Google.");
      }

      try {
        final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
        await userBox?.delete("is_local_guest_session");
      } catch (_) {}

      // Record profile in Realtime Database
      final db = _database;
      if (db != null) {
        try {
          await db.ref("users/${user.uid}/profile").update({
            "uid": user.uid,
            "email": user.email,
            "displayName": user.displayName,
            "photoUrl": user.photoURL,
            "lastLoginAt": ServerValue.timestamp,
          });
        } catch (_) {}
      }

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
      final auth = _getRequiredAuth();
      final UserCredential credential = await auth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      final user = credential.user;
      if (user == null) {
        throw Exception("Sign in failed. No user found.");
      }

      try {
        final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
        await userBox?.delete("is_local_guest_session");
      } catch (_) {}

      final db = _database;
      if (db != null) {
        try {
          await db.ref("users/${user.uid}/profile").update({
            "lastLoginAt": ServerValue.timestamp,
          });
        } catch (_) {}
      }

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
      final auth = _getRequiredAuth();
      final currentUser = auth.currentUser;
      UserCredential credential;

      if (currentUser != null && currentUser.isAnonymous) {
        try {
          final emailCred = EmailAuthProvider.credential(
            email: email.trim(),
            password: password,
          );
          credential = await currentUser.linkWithCredential(emailCred);
        } on FirebaseAuthException catch (e) {
          if (e.code == "credential-already-in-use" ||
              e.code == "email-already-in-use" ||
              e.code == "provider-already-linked") {
            credential = await auth.createUserWithEmailAndPassword(
              email: email.trim(),
              password: password,
            );
          } else {
            rethrow;
          }
        }
      } else {
        credential = await auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
      }

      final user = credential.user;
      if (user == null) {
        throw Exception("Failed to create account.");
      }

      try {
        final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
        await userBox?.delete("is_local_guest_session");
      } catch (_) {}

      if (displayName.trim().isNotEmpty) {
        await user.updateDisplayName(displayName.trim());
      }

      final db = _database;
      if (db != null) {
        try {
          await db.ref("users/${user.uid}/profile").update({
            "uid": user.uid,
            "email": user.email,
            "displayName": displayName.trim(),
            "createdAt": ServerValue.timestamp,
            "lastLoginAt": ServerValue.timestamp,
          });
        } catch (_) {}
      }

      await user.reload();
      final updatedUser = auth.currentUser ?? user;
      return UserEntity.fromFirebaseUser(updatedUser);
    } catch (e) {
      debugPrint("Error signing up: $e");
      rethrow;
    }
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      final auth = _firebaseAuth;
      if (auth != null) {
        final UserCredential credential = await auth.signInAnonymously();
        final user = credential.user;
        if (user != null) {
          try {
            final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
            await userBox?.delete("is_local_guest_session");
          } catch (_) {}
          final entity = UserEntity.fromFirebaseUser(user);
          _combinedAuthStreamController?.add(entity);
          return entity;
        }
      }
    } catch (e) {
      debugPrint(
        "Firebase anonymous auth unavailable, falling back to local guest: $e",
      );
    }

    // Resilient local guest fallback - 100% offline & never crashes
    try {
      final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
      await userBox?.put("is_local_guest_session", true);
    } catch (_) {}

    const guestUser = UserEntity(
      uid: "guest_local",
      displayName: "Guest User",
      isAnonymous: true,
    );
    _combinedAuthStreamController?.add(guestUser);
    return guestUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final auth = _getRequiredAuth();
      await auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      debugPrint("Error sending password reset: $e");
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
      await userBox?.delete("is_local_guest_session");
      _combinedAuthStreamController?.add(null);
    } catch (_) {}
    try {
      await _firebaseAuth?.signOut();
      try {
        await _ensureGoogleSignInInitialized();
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
      final userBox = Hive.isBoxOpen("user") ? Hive.box("user") : null;
      await userBox?.delete("is_local_guest_session");
      _combinedAuthStreamController?.add(null);
    } catch (_) {}
    try {
      final auth = _firebaseAuth;
      final user = auth?.currentUser;
      if (user == null) return;

      final uid = user.uid;

      // 1. Wipe all Realtime Database user data to satisfy GDPR / Google Play compliance
      final db = _database;
      if (db != null) {
        try {
          final userRef = db.ref("users/$uid");
          await userRef.remove();
        } catch (e) {
          debugPrint("Error removing user database tree: $e");
        }
      }

      // 2. Clear user-specific Hive cache
      try {
        final userBox = Hive.box("user");
        await userBox.delete("last_cloud_sync_timestamp");
      } catch (_) {}

      // 3. Delete the Firebase Auth User
      await user.delete();

      // 4. Google Sign in disconnect
      try {
        await _ensureGoogleSignInInitialized();
        await _googleSignIn.disconnect();
      } catch (_) {}
    } catch (e) {
      debugPrint("Error deleting account: $e");
      rethrow;
    }
  }
}
