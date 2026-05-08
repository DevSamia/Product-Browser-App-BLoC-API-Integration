import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/core/errors/exceptions.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testUser = AppUser(id: '1', email: testEmail, username: 'testuser');

  group('LoginUseCase Unit Tests', () {
    test('should return AppUser when login is successful', () async {
      // Arrange
      when(
        () => mockAuthRepository.login(testEmail, testPassword),
      ).thenAnswer((_) async => testUser);

      // Act
      final result = await loginUseCase.execute(testEmail, testPassword);

      // Assert
      expect(result, testUser);
      verify(() => mockAuthRepository.login(testEmail, testPassword)).called(1);
    });

    test(
      'should throw AuthException when credentials are wrong (null user)',
      () async {
        // Arrange
        when(
          () => mockAuthRepository.login(testEmail, testPassword),
        ).thenAnswer((_) async => null);

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, testPassword),
          throwsA(isA<AuthException>()),
        );
      },
    );

    test('should throw ValidationException when email is empty', () async {
      // Act & Assert
      expect(
        () => loginUseCase.execute('', testPassword),
        throwsA(isA<ValidationException>()),
      );
      verifyNever(() => mockAuthRepository.login(any(), any()));
    });

    test(
      'should throw AuthException when repository throws unexpected error',
      () async {
        // Arrange
        when(
          () => mockAuthRepository.login(any(), any()),
        ).thenThrow(Exception('Network Error'));

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, testPassword),
          throwsA(isA<AuthException>()),
        );
      },
    );
  });
}
