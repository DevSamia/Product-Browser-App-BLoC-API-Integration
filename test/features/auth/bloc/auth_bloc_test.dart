import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/auth/bloc/auth_bloc.dart';
import 'package:product_browser_app/features/auth/bloc/auth_event.dart';
import 'package:product_browser_app/features/auth/bloc/auth_state.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_browser_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/update_profile_usecase.dart';

// Mock Dependencies
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockLoginUseCase mockLoginUseCase;
    late MockRegisterUseCase mockRegisterUseCase;
    late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
    late MockUpdateProfileUseCase mockUpdateProfileUseCase;
    late MockAuthRepository mockAuthRepository;

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testUsername = 'testuser';
    const testUser = AppUser(
      id: '1',
      email: testEmail,
      username: testUsername,
      profileImageUrl: null,
    );

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockRegisterUseCase = MockRegisterUseCase();
      mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
      mockUpdateProfileUseCase = MockUpdateProfileUseCase();
      mockAuthRepository = MockAuthRepository();

      authBloc = AuthBloc(
        loginUseCase: mockLoginUseCase,
        registerUseCase: mockRegisterUseCase,
        getCurrentUserUseCase: mockGetCurrentUserUseCase,
        updateProfileUseCase: mockUpdateProfileUseCase,
        authRepository: mockAuthRepository,
      );
    });

    tearDown(() => authBloc.close());

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login is successful',
        setUp: () {
          when(() => mockLoginUseCase.execute(testEmail, testPassword))
              .thenAnswer((_) async => testUser);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(email: testEmail, password: testPassword),
        ),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when login returns null user',
        setUp: () {
          when(() => mockLoginUseCase.execute(testEmail, testPassword))
              .thenAnswer((_) async => null);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(email: testEmail, password: testPassword),
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login throws exception',
        setUp: () {
          when(() => mockLoginUseCase.execute(any(), any()))
              .thenThrow(Exception('Invalid credentials'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(email: testEmail, password: testPassword),
        ),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] for invalid email',
        setUp: () {
          when(() => mockLoginUseCase.execute(any(), any()))
              .thenThrow(Exception('Invalid email format'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.loginRequested(email: 'invalid-email', password: testPassword),
        ),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );
    });

    group('RegisterRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when registration is successful',
        setUp: () {
          when(() => mockRegisterUseCase.execute(testEmail, testUsername, testPassword))
              .thenAnswer((_) async => testUser);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.registerRequested(
            email: testEmail,
            username: testUsername,
            password: testPassword,
          ),
        ),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when registration returns null',
        setUp: () {
          when(() => mockRegisterUseCase.execute(any(), any(), any()))
              .thenAnswer((_) async => null);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.registerRequested(
            email: testEmail,
            username: testUsername,
            password: testPassword,
          ),
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when registration throws exception',
        setUp: () {
          when(() => mockRegisterUseCase.execute(any(), any(), any()))
              .thenThrow(Exception('Email already registered'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.registerRequested(
            email: testEmail,
            username: testUsername,
            password: testPassword,
          ),
        ),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when logout is successful',
        setUp: () {
          when(() => mockAuthRepository.logout()).thenAnswer((_) async {});
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
        expect: () => [
          const AuthState.unauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthError] when logout throws exception',
        setUp: () {
          when(() => mockAuthRepository.logout())
              .thenThrow(Exception('Logout failed'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
        expect: () => [
          isA<AuthError>(),
        ],
      );
    });

    group('AuthCheckRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthAuthenticated] when user session exists',
        setUp: () {
          when(() => mockGetCurrentUserUseCase.execute())
              .thenAnswer((_) async => testUser);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.authCheckRequested()),
        expect: () => [
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when no user session exists',
        setUp: () {
          when(() => mockGetCurrentUserUseCase.execute())
              .thenAnswer((_) async => null);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.authCheckRequested()),
        expect: () => [
          const AuthState.unauthenticated(),
        ],
      );
    });

    group('GoogleSignInRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when Google sign-in is successful',
        setUp: () {
          when(() => mockAuthRepository.signInWithGoogle())
              .thenAnswer((_) async => testUser);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.googleSignInRequested()),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when Google sign-in is cancelled',
        setUp: () {
          when(() => mockAuthRepository.signInWithGoogle())
              .thenAnswer((_) async => null);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.googleSignInRequested()),
        expect: () => [
          const AuthState.loading(),
          const AuthState.unauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when Google sign-in throws exception',
        setUp: () {
          when(() => mockAuthRepository.signInWithGoogle())
              .thenThrow(Exception('Google sign-in failed'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(const AuthEvent.googleSignInRequested()),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );
    });

    group('ProfileUpdateRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when profile update is successful',
        setUp: () {
          when(() => mockUpdateProfileUseCase.execute(any()))
              .thenAnswer((_) async {});
          when(() => mockGetCurrentUserUseCase.execute())
              .thenAnswer((_) async => testUser);
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.profileUpdateRequested(username: 'newusername'),
        ),
        expect: () => [
          const AuthState.loading(),
          AuthState.authenticated(testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when profile update fails',
        setUp: () {
          when(() => mockUpdateProfileUseCase.execute(any()))
              .thenThrow(Exception('Update failed'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.profileUpdateRequested(username: 'newusername'),
        ),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );
    });

    group('PasswordResetRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthSuccess] when password reset email is sent',
        setUp: () {
          when(() => mockAuthRepository.sendPasswordResetEmail(any()))
              .thenAnswer((_) async {});
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.passwordResetRequested(email: testEmail),
        ),
        expect: () => [
          const AuthState.loading(),
          const AuthState.success('RESET_EMAIL_SENT'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when password reset fails',
        setUp: () {
          when(() => mockAuthRepository.sendPasswordResetEmail(any()))
              .thenThrow(Exception('Email not found'));
        },
        build: () => authBloc,
        act: (bloc) => bloc.add(
          const AuthEvent.passwordResetRequested(email: testEmail),
        ),
        expect: () => [
          const AuthState.loading(),
          isA<AuthError>(),
        ],
      );
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, const AuthState.initial());
    });
  });
}

