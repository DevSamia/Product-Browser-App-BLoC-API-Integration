import '../../../../core/imports/common_imports.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<AppUser?> execute() async {
    AppLogger.d(
      "GetCurrentUserUseCase: Checking for an active user session...",
    );

    try {
      final user = await repository.getCurrentUser();

      if (user != null) {
        AppLogger.i(
          "GetCurrentUserUseCase: Active session found for user: ${user.email}",
        );
      } else {
        AppLogger.w("GetCurrentUserUseCase: No active session detected.");
      }

      return user;
    } catch (e) {
      AppLogger.e(
        "GetCurrentUserUseCase: Error while fetching current user",
        e,
      );
      rethrow;
    }
  }
}
