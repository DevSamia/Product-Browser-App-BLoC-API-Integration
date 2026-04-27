import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/app_logger.dart';
import '../domain/entities/app_user.dart';
import '../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AppUser? _mapFirebaseUserToAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      username: user.displayName ?? '',
    );
  }

  @override
  Future<AppUser?> login(String email, String password) async {
    AppLogger.i("Attempting to login user with email: $email");
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final appUser = _mapFirebaseUserToAppUser(credential.user);
      AppLogger.d("Login successful for UID: ${appUser?.id}");
      return appUser;
    } catch (e) {
      AppLogger.e("Login failed", e);
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  @override
  Future<AppUser?> register(
    String email,
    String username,
    String password,
  ) async {
    AppLogger.i("Attempting to register user with email: $email");
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(username);

      final appUser = _mapFirebaseUserToAppUser(credential.user);
      AppLogger.d(
        "Registration successful. User created with UID: ${appUser?.id}",
      );
      return appUser;
    } catch (e) {
      AppLogger.e("Registration failed", e);
      throw Exception("Registration failed: ${e.toString()}");
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    AppLogger.d("Checking for currently authenticated user...");
    final user = _firebaseAuth.currentUser;
    final appUser = _mapFirebaseUserToAppUser(user);

    if (appUser != null) {
      AppLogger.i("User found: ${appUser.email}");
    } else {
      AppLogger.w("No authenticated user found.");
    }
    return appUser;
  }

  @override
  Future<void> updateDisplayName(String name) async {
    AppLogger.i("Updating display name to: $name");
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      AppLogger.d("Display name updated successfully.");
    } catch (e) {
      AppLogger.e("Failed to update display name", e);
      throw Exception("Profile update failed: ${e.toString()}");
    }
  }

  @override
  Future<void> logout() async {
    final userEmail = _firebaseAuth.currentUser?.email;
    AppLogger.i("Logging out user: $userEmail");
    await _firebaseAuth.signOut();
    AppLogger.d("User signed out successfully.");
  }
}
