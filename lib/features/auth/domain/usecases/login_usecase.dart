import '../../../../core/imports/common_imports.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AppUser?> execute(String email, String password) async {
    AppLogger.i("LoginUseCase: Executing login for email: $email");

    try {
      final user = await repository.login(email, password);

      if (user != null) {
        AppLogger.d("LoginUseCase: Success for user ID: ${user.id}");
      } else {
        AppLogger.w("LoginUseCase: Repository returned a null user");
      }

      return user;
    } catch (e) {
      AppLogger.e("LoginUseCase: Execution error", e);
      rethrow;
    }
  }
}
