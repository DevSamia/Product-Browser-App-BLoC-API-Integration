import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/core/errors/exceptions.dart';
import 'package:product_browser_app/features/auth/bloc/auth_bloc.dart';
import 'package:product_browser_app/features/auth/bloc/auth_event.dart';
import 'package:product_browser_app/features/auth/bloc/auth_state.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_browser_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:product_browser_app/features/auth/domain/usecases/update_profile_usecase.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockAuthRepository mockAuthRepository;

  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testUser = AppUser(id: '1', email: testEmail, username: 'test');

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

  group('AuthBloc - Login Flow', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when login succeeds',
      setUp: () {
        when(
          () => mockLoginUseCase.execute(testEmail, testPassword),
        ).thenAnswer((_) async => testUser);
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(
        const AuthEvent.loginRequested(
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.authenticated(testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] when login fails with AuthException',
      setUp: () {
        when(
          () => mockLoginUseCase.execute(any(), any()),
        ).thenThrow(AuthException('Invalid credentials'));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(
        const AuthEvent.loginRequested(
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Invalid credentials'),
      ],
    );
  });
}
