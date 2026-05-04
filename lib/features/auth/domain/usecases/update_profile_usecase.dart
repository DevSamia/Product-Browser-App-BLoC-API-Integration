import '../../../../core/imports/common_imports.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> execute(String newDisplayName) async {
    AppLogger.i(
      "UpdateProfileUseCase: Attempting to update display name to: $newDisplayName",
    );

    try {
      await repository.updateDisplayName(newDisplayName);
      AppLogger.d(
        "UpdateProfileUseCase: Display name updated successfully in the repository.",
      );
    } catch (e) {
      AppLogger.e("UpdateProfileUseCase: Failed to update display name", e);
      rethrow;
    }
  }
}
