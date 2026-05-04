import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;

  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = LoginRequested;

  const factory AuthEvent.registerRequested({
    required String email,
    required String username,
    required String password,
  }) = RegisterRequested;

  const factory AuthEvent.logoutRequested() = LogoutRequested;
  const factory AuthEvent.googleSignInRequested() = GoogleSignInRequested;

  const factory AuthEvent.profileUpdateRequested({required String username}) =
      ProfileUpdateRequested;

  const factory AuthEvent.passwordResetRequested({required String email}) =
      PasswordResetRequested;

  const factory AuthEvent.profileImageUpdateRequested({required File image}) =
      ProfileImageUpdateRequested;
}
