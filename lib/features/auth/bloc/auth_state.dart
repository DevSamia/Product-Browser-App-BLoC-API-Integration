import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/app_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;

  // حالة النجاح مع بيانات المستخدم [cite: 15, 18]
  const factory AuthState.authenticated(AppUser user) = AuthAuthenticated;

  // حالة عدم تسجيل الدخول
  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  // حالة الخطأ [cite: 11, 18]
  const factory AuthState.error(String message) = AuthError;
}
