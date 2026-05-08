import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:product_browser_app/features/chat/domain/usecases/send_message_usecase.dart';

// Mock ChatRepository
class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  group('SendMessageUseCase', () {
    late SendMessageUseCase sendMessageUseCase;
    late MockChatRepository mockChatRepository;

    setUp(() {
      mockChatRepository = MockChatRepository();
      sendMessageUseCase = SendMessageUseCase(mockChatRepository);
    });

    const testProductId = 'prod_123';
    const testUsername = 'testuser';
    const testMessage = 'Hello, this is a test message';

    group('call', () {
      test('should call repository.sendMessage with correct parameters',
          () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: testMessage,
            )).thenAnswer((_) async {});

        // Act
        await sendMessageUseCase(
          productId: testProductId,
          senderUsername: testUsername,
          text: testMessage,
        );

        // Assert
        verify(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: testMessage,
            )).called(1);
      });

      test('should successfully send message', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: any(named: 'productId'),
              senderUsername: any(named: 'senderUsername'),
              text: any(named: 'text'),
            )).thenAnswer((_) async {});

        // Act & Assert
        expect(
          sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: testMessage,
          ),
          completes,
        );
      });

      test('should throw exception when repository fails', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: any(named: 'productId'),
              senderUsername: any(named: 'senderUsername'),
              text: any(named: 'text'),
            )).thenThrow(Exception('Failed to send message'));

        // Act & Assert
        expect(
          () => sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: testMessage,
          ),
          throwsException,
        );
      });

      test('should handle empty message text', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: '',
            )).thenAnswer((_) async {});

        // Act & Assert
        expect(
          sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: '',
          ),
          completes,
        );
      });

      test('should handle empty product ID', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: '',
              senderUsername: testUsername,
              text: testMessage,
            )).thenThrow(Exception('Invalid product ID'));

        // Act & Assert
        expect(
          () => sendMessageUseCase(
            productId: '',
            senderUsername: testUsername,
            text: testMessage,
          ),
          throwsException,
        );
      });

      test('should handle Firestore connection errors', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: any(named: 'productId'),
              senderUsername: any(named: 'senderUsername'),
              text: any(named: 'text'),
            )).thenThrow(Exception('Connection timeout'));

        // Act & Assert
        expect(
          () => sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: testMessage,
          ),
          throwsException,
        );
      });

      test('should handle very long message text', () async {
        // Arrange
        final longMessage = 'a' * 5000;
        when(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: longMessage,
            )).thenAnswer((_) async {});

        // Act & Assert
        expect(
          sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: longMessage,
          ),
          completes,
        );
      });

      test('should handle special characters in message', () async {
        // Arrange
        const specialMessage = 'Hello! @#\$%^&*()_+-=[]{}|;:,.<>?/~`';
        when(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: specialMessage,
            )).thenAnswer((_) async {});

        // Act & Assert
        expect(
          sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: specialMessage,
          ),
          completes,
        );
      });

      test('should handle unicode characters in message', () async {
        // Arrange
        const unicodeMessage = 'مرحبا 你好 こんにちは';
        when(() => mockChatRepository.sendMessage(
              productId: testProductId,
              senderUsername: testUsername,
              text: unicodeMessage,
            )).thenAnswer((_) async {});

        // Act & Assert
        expect(
          sendMessageUseCase(
            productId: testProductId,
            senderUsername: testUsername,
            text: unicodeMessage,
          ),
          completes,
        );
      });

      test('should not call repository more than once per request', () async {
        // Arrange
        when(() => mockChatRepository.sendMessage(
              productId: any(named: 'productId'),
              senderUsername: any(named: 'senderUsername'),
              text: any(named: 'text'),
            )).thenAnswer((_) async {});

        // Act
        await sendMessageUseCase(
          productId: testProductId,
          senderUsername: testUsername,
          text: testMessage,
        );

        // Assert
        verify(() => mockChatRepository.sendMessage(
              productId: any(named: 'productId'),
              senderUsername: any(named: 'senderUsername'),
              text: any(named: 'text'),
            )).called(1);
        verifyNoMoreInteractions(mockChatRepository);
      });
    });
  });
}

