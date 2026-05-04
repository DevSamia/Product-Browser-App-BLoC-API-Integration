import 'dart:io';
import '../../../../core/imports/common_imports.dart';

abstract class AuthRepository {
  Future<AppUser?> login(String email, String password);
  Future<AppUser?> register(String email, String username, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<void> updateDisplayName(String name);
  Future<AppUser?> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateProfileImage(File imageFile);
}
