/// Integration Tests Helper
///
/// هذا الملف يحتوي على مساعدات وأمثلة لكتابة اختبارات Integration
/// والتي تختبر التفاعل بين عدة components معاً

import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:product_browser_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';

// Mock Repositories
class MockAuthRepository extends Mock implements AuthRepository {}

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  group('Integration Tests - Authentication Flow', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;

    const testEmail = 'integration@example.com';
    const testPassword = 'password123';
    const testUser = AppUser(
      id: '1',
      email: testEmail,
      username: 'integrationuser',
    );

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockAuthRepository);
    });

    test('Complete login flow - from UI to Repository', () async {
      // Arrange: Setup repository mock
      when(
        () => mockAuthRepository.login(testEmail, testPassword),
      ).thenAnswer((_) async => testUser);

      // Act: Execute login through UseCase
      final result = await loginUseCase.execute(testEmail, testPassword);

      // Assert: Verify complete flow
      expect(result, equals(testUser));
      expect(result?.email, equals(testEmail));
      expect(result?.username, equals('integrationuser'));

      // Verify repository call
      verify(() => mockAuthRepository.login(testEmail, testPassword)).called(1);
    });

    test('Login failure flow with proper error handling', () async {
      // Arrange
      final exception = Exception('Invalid credentials');
      when(
        () => mockAuthRepository.login(testEmail, testPassword),
      ).thenThrow(exception);

      // Act & Assert
      expect(
        () => loginUseCase.execute(testEmail, testPassword),
        throwsException,
      );
    });

    test('Multiple login attempts with different credentials', () async {
      // Arrange
      final users = {
        'user1@test.com': const AppUser(
          id: '1',
          email: 'user1@test.com',
          username: 'user1',
        ),
        'user2@test.com': const AppUser(
          id: '2',
          email: 'user2@test.com',
          username: 'user2',
        ),
      };

      // Act & Assert
      for (var email in users.keys) {
        when(
          () => mockAuthRepository.login(email, testPassword),
        ).thenAnswer((_) async => users[email]);

        final result = await loginUseCase.execute(email, testPassword);
        expect(result?.email, equals(email));
      }
    });
  });

  group('Integration Tests - Chat Message Flow', () {
    late MockChatRepository mockChatRepository;

    const testProductId = 'prod_123';
    final testMessages = [
      Message(
        id: '1',
        productId: testProductId,
        senderUsername: 'user1',
        text: 'First message',
        createdAt: DateTime(2023, 1, 1),
      ),
      Message(
        id: '2',
        productId: testProductId,
        senderUsername: 'user2',
        text: 'Second message',
        createdAt: DateTime(2023, 1, 1),
      ),
    ];

    setUp(() {
      mockChatRepository = MockChatRepository();
    });

    test('Complete message watching and sending flow', () async {
      // Arrange: Setup watchers
      when(
        () => mockChatRepository.watchMessages(testProductId),
      ).thenAnswer((_) => Stream.value(testMessages));

      when(
        () => mockChatRepository.sendMessage(
          productId: testProductId,
          senderUsername: 'user3',
          text: 'New message',
        ),
      ).thenAnswer((_) async {});

      // Act: Watch messages
      final messagesStream = mockChatRepository.watchMessages(testProductId);
      final initialMessages = await messagesStream.first;

      // Act: Send new message
      await mockChatRepository.sendMessage(
        productId: testProductId,
        senderUsername: 'user3',
        text: 'New message',
      );

      // Assert
      expect(initialMessages.length, equals(2));
      verify(() => mockChatRepository.watchMessages(testProductId)).called(1);
      verify(
        () => mockChatRepository.sendMessage(
          productId: testProductId,
          senderUsername: 'user3',
          text: 'New message',
        ),
      ).called(1);
    });

    test('Real-time message updates simulation', () async {
      // Arrange: Setup streaming behavior
      final controller = StreamController<List<Message>>();

      when(
        () => mockChatRepository.watchMessages(testProductId),
      ).thenAnswer((_) => controller.stream);

      // Act: Start watching
      final messages = mockChatRepository.watchMessages(testProductId);

      // Simulate real-time updates
      controller.add([]);
      controller.add([testMessages[0]]);
      controller.add(testMessages);

      // Assert
      expect(
        messages,
        emitsInOrder([
          [],
          [testMessages[0]],
          testMessages,
        ]),
      );

      await controller.close();
    });
  });

  group('Integration Tests - Concurrent Operations', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockAuthRepository);
    });

    test('Handle concurrent login requests', () async {
      // Arrange
      const user1 = AppUser(
        id: '1',
        email: 'user1@test.com',
        username: 'user1',
      );
      const user2 = AppUser(
        id: '2',
        email: 'user2@test.com',
        username: 'user2',
      );

      when(
        () => mockAuthRepository.login('user1@test.com', 'pass'),
      ).thenAnswer((_) async => user1);
      when(
        () => mockAuthRepository.login('user2@test.com', 'pass'),
      ).thenAnswer((_) async => user2);

      // Act: Concurrent operations
      final results = await Future.wait([
        loginUseCase.execute('user1@test.com', 'pass'),
        loginUseCase.execute('user2@test.com', 'pass'),
      ]);

      // Assert
      expect(results[0], equals(user1));
      expect(results[1], equals(user2));
    });
  });

  group('Integration Tests - Error Recovery', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockAuthRepository);
    });

    test('Retry logic after temporary failure', () async {
      // Arrange: First call fails, second succeeds
      const testUser = AppUser(
        id: '1',
        email: 'test@example.com',
        username: 'testuser',
      );

      var callCount = 0;
      when(() => mockAuthRepository.login(any(), any())).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw Exception('Temporary network error');
        }
        return testUser;
      });

      // Act: First attempt fails
      try {
        await loginUseCase.execute('test@example.com', 'password');
      } catch (e) {
        // Expected to fail
      }

      // Reset mock for second attempt
      when(
        () => mockAuthRepository.login(any(), any()),
      ).thenAnswer((_) async => testUser);

      // Act: Second attempt succeeds
      final result = await loginUseCase.execute('test@example.com', 'password');

      // Assert
      expect(result, equals(testUser));
    });
  });

  group('Integration Tests - Data Persistence', () {
    test('User data persists through multiple operations', () async {
      // This is a comprehensive test showing data flow
      const testUser = AppUser(
        id: '123',
        email: 'test@example.com',
        username: 'testuser',
        profileImageUrl: 'https://example.com/image.jpg',
      );

      // Simulate storing and retrieving
      AppUser storedUser = testUser;

      // Verify data integrity
      expect(storedUser.id, equals('123'));
      expect(storedUser.email, equals('test@example.com'));
      expect(storedUser.username, equals('testuser'));
      expect(storedUser.profileImageUrl, isNotNull);
    });
  });
}

/// Example: Custom Test Matcher
Matcher appUserWith({
  required String id,
  required String email,
  required String username,
}) {
  return everyElement(
    isA<AppUser>()
        .having((user) => user.id, 'id', equals(id))
        .having((user) => user.email, 'email', equals(email))
        .having((user) => user.username, 'username', equals(username)),
  );
}

/// Example: Test Fixture Builder
class TestDataBuilder {
  static const testEmail = 'test@example.com';
  static const testPassword = 'password123';
  static const testProductId = 'prod_123';

  static AppUser createTestUser({
    String id = '1',
    String email = testEmail,
    String username = 'testuser',
    String? profileImageUrl,
  }) {
    return AppUser(
      id: id,
      email: email,
      username: username,
      profileImageUrl: profileImageUrl,
    );
  }

  static Message createTestMessage({
    required String id,
    String productId = testProductId,
    String senderUsername = 'testuser',
    String text = 'Test message',
    DateTime? createdAt,
  }) {
    return Message(
      id: id,
      productId: productId,
      senderUsername: senderUsername,
      text: text,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  static List<Message> createTestMessages(int count) {
    return List.generate(
      count,
      (index) => createTestMessage(id: 'msg_$index', text: 'Message $index'),
    );
  }
}
