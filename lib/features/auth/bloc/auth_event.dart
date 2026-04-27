import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  // فحص حالة المستخدم عند تشغيل التطبيق [cite: 13, 24]
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;

  // حدث تسجيل الدخول [cite: 10, 15]
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = LoginRequested;

  // حدث إنشاء حساب جديد [cite: 10, 15]
  const factory AuthEvent.registerRequested({
    required String email,
    required String username,
    required String password,
  }) = RegisterRequested;

  // حدث تسجيل الخروج (Bonus) [cite: 31]
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
