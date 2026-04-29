import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/app_logger.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_current_user_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository,
  }) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      AppLogger.i("AuthBloc Event Received: ${event.runtimeType}");

      await event.map(
        authCheckRequested: (e) async {
          AppLogger.d("Processing AuthCheckRequested...");
          final user = await getCurrentUserUseCase.execute();
          if (user != null) {
            AppLogger.i("User session found: ${user.email}");
            emit(AuthState.authenticated(user));
          } else {
            AppLogger.w("No active session found.");
            emit(const AuthState.unauthenticated());
          }
        },

        loginRequested: (e) async {
          AppLogger.i("Processing LoginRequested for: ${e.email}");
          emit(const AuthState.loading());
          try {
            final user = await loginUseCase.execute(e.email, e.password);
            if (user != null) {
              AppLogger.d("LoginUseCase returned user: ${user.id}");
              emit(AuthState.authenticated(user));
            } else {
              AppLogger.w("Login failed: User object is null");
              emit(const AuthState.unauthenticated());
            }
          } catch (error) {
            AppLogger.e("AuthBloc Login Error", error);
            emit(AuthState.error(error.toString()));
          }
        },

        registerRequested: (e) async {
          AppLogger.i("Processing RegisterRequested for: ${e.email}");
          emit(const AuthState.loading());
          try {
            final user = await registerUseCase.execute(
              e.email,
              e.username,
              e.password,
            );
            if (user != null) {
              AppLogger.d("RegisterUseCase returned user: ${user.id}");
              emit(AuthState.authenticated(user));
            } else {
              AppLogger.w("Registration failed: User object is null");
              emit(const AuthState.unauthenticated());
            }
          } catch (error) {
            AppLogger.e("AuthBloc Registration Error", error);
            emit(AuthState.error(error.toString()));
          }
        },

        logoutRequested: (e) async {
          AppLogger.i("Processing LogoutRequested...");
          try {
            await authRepository.logout();
            AppLogger.d("User logged out, emitting Unauthenticated.");
            emit(const AuthState.unauthenticated());
          } catch (error) {
            AppLogger.e("AuthBloc Logout Error", error);
            emit(AuthState.error("Logout failed: ${error.toString()}"));
          }
        },

        googleSignInRequested: (e) async {
          AppLogger.i("AuthBloc: Processing GoogleSignInRequested...");
          emit(const AuthState.loading());
          try {
            final user = await authRepository.signInWithGoogle();

            if (user != null) {
              AppLogger.i(
                "AuthBloc: Google Sign-In successful for: ${user.email}",
              );
              emit(AuthState.authenticated(user));
            } else {
              AppLogger.w("AuthBloc: Google Sign-In cancelled by user.");
              emit(const AuthState.unauthenticated());
            }
          } catch (error) {
            AppLogger.e("AuthBloc: Google Sign-In Error", error);
            emit(AuthState.error(error.toString()));
          }
        },
      );
    });
  }
}
