import "package:al_quran_v3/src/features/auth/data/datasources/firebase_auth_datasource.dart";
import "package:al_quran_v3/src/features/auth/domain/entities/user_entity.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:flutter_test/flutter_test.dart";

class FakeFirebaseAuthDataSource implements FirebaseAuthDataSource {
  UserEntity? _user;
  final _controller = const Stream<UserEntity?>.empty();

  @override
  UserEntity? get currentUser => _user;

  @override
  Stream<UserEntity?> get authStateChanges => _controller;

  @override
  Future<UserEntity> signInWithGoogle() async {
    _user = const UserEntity(uid: "google_123", email: "google@test.com", displayName: "Google User");
    return _user!;
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({required String email, required String password}) async {
    if (password == "wrong") throw Exception("wrong-password");
    _user = UserEntity(uid: "email_123", email: email, displayName: "Email User");
    return _user!;
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({required String email, required String password, required String displayName}) async {
    _user = UserEntity(uid: "signup_123", email: email, displayName: displayName);
    return _user!;
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    _user = const UserEntity(uid: "anon_123", isAnonymous: true);
    return _user!;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> signOut() async {
    _user = null;
  }

  @override
  Future<void> deleteAccount() async {
    _user = null;
  }
}

void main() {
  group("AuthCubit Unit Tests", () {
    late FakeFirebaseAuthDataSource fakeDataSource;
    late AuthCubit cubit;

    setUp(() {
      fakeDataSource = FakeFirebaseAuthDataSource();
      cubit = AuthCubit(authDataSource: fakeDataSource);
    });

    tearDown(() {
      cubit.close();
    });

    test("Initial state is Unauthenticated when no user exists", () {
      expect(cubit.state, isA<Unauthenticated>());
    });

    test("signInWithGoogle emits Authenticated", () async {
      await cubit.signInWithGoogle();
      expect(cubit.state, isA<Authenticated>());
      final authState = cubit.state as Authenticated;
      expect(authState.user.email, "google@test.com");
    });

    test("signInWithEmail with valid credentials emits Authenticated", () async {
      await cubit.signInWithEmail(email: "test@example.com", password: "password123");
      expect(cubit.state, isA<Authenticated>());
      final authState = cubit.state as Authenticated;
      expect(authState.user.email, "test@example.com");
    });

    test("signInWithEmail with wrong password emits AuthError", () async {
      await cubit.signInWithEmail(email: "test@example.com", password: "wrong");
      expect(cubit.state, isA<AuthError>());
    });

    test("signUpWithEmail emits Authenticated with correct displayName", () async {
      await cubit.signUpWithEmail(email: "new@example.com", password: "password123", displayName: "Jane Doe");
      expect(cubit.state, isA<Authenticated>());
      final authState = cubit.state as Authenticated;
      expect(authState.user.displayName, "Jane Doe");
    });

    test("signOut emits Unauthenticated", () async {
      await cubit.signInWithGoogle();
      expect(cubit.state, isA<Authenticated>());
      await cubit.signOut();
      expect(cubit.state, isA<Unauthenticated>());
    });

    test("deleteAccount emits Unauthenticated", () async {
      await cubit.signInWithGoogle();
      expect(cubit.state, isA<Authenticated>());
      await cubit.deleteAccount();
      expect(cubit.state, isA<Unauthenticated>());
    });
  });
}
