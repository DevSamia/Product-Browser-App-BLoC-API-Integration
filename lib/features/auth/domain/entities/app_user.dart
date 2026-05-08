import '../../../../core/imports/common_imports.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? profileImageUrl;

  const AppUser({
    required this.id,
    required this.email,
    required this.username,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id, email, username, profileImageUrl];
}
