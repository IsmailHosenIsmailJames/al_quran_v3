import "dart:async";
import "package:al_quran_v3/src/features/auth/data/datasources/firebase_auth_datasource.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthDataSource _authDataSource;
  StreamSubscription? _authSubscription;

  AuthCubit({required FirebaseAuthDataSource authDataSource})
      : _authDataSource = authDataSource,
        super(const AuthInitial()) {
    _init();
  }

  void _init() {
    final current = _authDataSource.currentUser;
    if (current != null) {
      emit(Authenticated(current));
    } else {
      emit(const Unauthenticated());
    }

    _authSubscription = _authDataSource.authStateChanges.listen((user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthLoading(message: "Connecting to Google..."));
    try {
      final user = await _authDataSource.signInWithGoogle();
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(message: "Signing in..."));
    try {
      final user = await _authDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(const AuthLoading(message: "Creating your account..."));
    try {
      final user = await _authDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
    }
  }

  Future<void> signInAnonymously() async {
    emit(const AuthLoading(message: "Starting guest session..."));
    try {
      final user = await _authDataSource.signInAnonymously();
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authDataSource.sendPasswordResetEmail(email);
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
      rethrow;
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading(message: "Signing out..."));
    try {
      await _authDataSource.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(const AuthLoading(message: "Deleting account & data..."));
    try {
      await _authDataSource.deleteAccount();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(_cleanErrorMessage(e)));
      rethrow;
    }
  }

  String _cleanErrorMessage(dynamic error) {
    final str = error.toString();
    if (str.contains("user-not-found")) {
      return "No account found with this email.";
    } else if (str.contains("wrong-password") || str.contains("invalid-credential")) {
      return "Incorrect password or email.";
    } else if (str.contains("email-already-in-use")) {
      return "An account with this email already exists.";
    } else if (str.contains("weak-password")) {
      return "Password is too weak (min 6 characters).";
    } else if (str.contains("invalid-email")) {
      return "Please enter a valid email address.";
    } else if (str.contains("network-request-failed")) {
      return "Network error. Please check your internet connection.";
    }
    return str.replaceAll("Exception: ", "").replaceAll("[firebase_auth/", "").replaceAll("]", "");
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
