import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';

// Mock LoginRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockAuthRepository);
    });

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testUser = AppUser(
      id: '1',
      email: testEmail,
      username: 'testuser',
      profileImageUrl: null,
    );

    group('execute', () {
      test('should return AppUser when login is successful', () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, testPassword))
            .thenAnswer((_) async => testUser);

        // Act
        final result = await loginUseCase.execute(testEmail, testPassword);

        // Assert
        expect(result, equals(testUser));
        verify(() => mockAuthRepository.login(testEmail, testPassword))
            .called(1);
      });

      test('should return null when user is not found', () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, testPassword))
            .thenAnswer((_) async => null);

        // Act
        final result = await loginUseCase.execute(testEmail, testPassword);

        // Assert
        expect(result, isNull);
        verify(() => mockAuthRepository.login(testEmail, testPassword))
            .called(1);
      });

      test('should throw exception when repository throws an error', () async {
        // Arrange
        final exception = Exception('Authentication failed');
        when(() => mockAuthRepository.login(testEmail, testPassword))
            .thenThrow(exception);

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, testPassword),
          throwsException,
        );
        verify(() => mockAuthRepository.login(testEmail, testPassword))
            .called(1);
      });

      test('should throw FirebaseAuthException for invalid credentials',
          () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, 'wrongPassword'))
            .thenThrow(Exception('Invalid credentials'));

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, 'wrongPassword'),
          throwsException,
        );
      });

      test('should handle empty email gracefully', () async {
        // Arrange
        when(() => mockAuthRepository.login('', testPassword))
            .thenThrow(Exception('Email cannot be empty'));

        // Act & Assert
        expect(
          () => loginUseCase.execute('', testPassword),
          throwsException,
        );
      });

      test('should handle empty password gracefully', () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, ''))
            .thenThrow(Exception('Password cannot be empty'));

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, ''),
          throwsException,
        );
      });

      test('should handle network errors', () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, testPassword))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => loginUseCase.execute(testEmail, testPassword),
          throwsException,
        );
      });

      test('should call repository with correct parameters', () async {
        // Arrange
        when(() => mockAuthRepository.login(testEmail, testPassword))
            .thenAnswer((_) async => testUser);

        // Act
        await loginUseCase.execute(testEmail, testPassword);

        // Assert
        verify(() => mockAuthRepository.login(testEmail, testPassword))
            .called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      });

      test('should return user with all properties intact', () async {
        // Arrange
        const userWithAllProperties = AppUser(
          id: '123',
          email: 'user@example.com',
          username: 'johndoe',
          profileImageUrl: 'https://example.com/image.jpg',
        );

        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => userWithAllProperties);

        // Act
        final result = await loginUseCase.execute(testEmail, testPassword);

        // Assert
        expect(result?.id, equals('123'));
        expect(result?.email, equals('user@example.com'));
        expect(result?.username, equals('johndoe'));
        expect(result?.profileImageUrl, equals('https://example.com/image.jpg'));
      });
    });
  });
}

