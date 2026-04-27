import '../../../../core/errors/app_logger.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AppUser?> execute(
    String email,
    String username,
    String password,
  ) async {
    AppLogger.i(
      "RegisterUseCase: Creating account for $email with username: $username",
    );

    try {
      final user = await repository.register(email, username, password);
      AppLogger.d(
        "RegisterUseCase: Account created successfully for UID: ${user?.id}",
      );
      return user;
    } catch (e) {
      AppLogger.e("RegisterUseCase: Execution error", e);
      rethrow;
    }
  }
}
