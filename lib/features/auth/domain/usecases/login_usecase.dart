import '../../../../core/errors/exceptions.dart';
import '../../../../core/imports/common_imports.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AppUser?> execute(String email, String password) async {
    AppLogger.i("LoginUseCase: Executing login for email: $email");

    if (email.isEmpty) {
      throw ValidationException("Email cannot be empty");
    }

    try {
      final user = await repository.login(email, password);

      if (user != null) {
        AppLogger.d("LoginUseCase: Success for user ID: ${user.id}");
      } else {
        AppLogger.w("LoginUseCase: Repository returned a null user");
        throw AuthException("Invalid credentials");
      }

      return user;
    } on AuthException {
      rethrow;
    } catch (e) {
      AppLogger.e("LoginUseCase: Execution error", e);
      throw AuthException(e.toString());
    }
  }
}
