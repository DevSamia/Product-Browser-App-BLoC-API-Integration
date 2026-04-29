import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> login(String email, String password);
  Future<AppUser?> register(String email, String username, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<void> updateDisplayName(String name);
  Future<AppUser?> signInWithGoogle();
}
