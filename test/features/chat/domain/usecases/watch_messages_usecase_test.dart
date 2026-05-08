import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:product_browser_app/features/chat/domain/usecases/watch_messages_usecase.dart';

// Mock ChatRepository
class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  group('WatchMessagesUseCase', () {
    late WatchMessagesUseCase watchMessagesUseCase;
    late MockChatRepository mockChatRepository;

    setUp(() {
      mockChatRepository = MockChatRepository();
      watchMessagesUseCase = WatchMessagesUseCase(mockChatRepository);
    });

    const testProductId = 'prod_123';

    final testMessages = [
      const Message(
        id: '1',
        productId: testProductId,
        senderUsername: 'user1',
        text: 'Hello',
        createdAt: null,
      ),
      const Message(
        id: '2',
        productId: testProductId,
        senderUsername: 'user2',
        text: 'Hi there',
        createdAt: null,
      ),
    ];

    group('call', () {
      test('should return a Stream<List<Message>>', () {
        // Arrange
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value(testMessages));

        // Act
        final result = watchMessagesUseCase(testProductId);

        // Assert
        expect(result, isA<Stream<List<Message>>>());
      });

      test('should emit messages when repository emits data', () async {
        // Arrange
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value(testMessages));

        // Act & Assert
        expect(
          watchMessagesUseCase(testProductId),
          emits(testMessages),
        );
      });

      test('should emit empty list initially', () async {
        // Arrange
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value([]));

        // Act & Assert
        expect(
          watchMessagesUseCase(testProductId),
          emits([]),
        );
      });

      test('should emit multiple message updates', () async {
        // Arrange
        final messageUpdates = [
          [],
          [testMessages[0]],
          testMessages,
        ];

        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.fromIterable(messageUpdates));

        // Act & Assert
        expect(
          watchMessagesUseCase(testProductId),
          emitsInOrder(messageUpdates),
        );
      });

      test('should handle stream errors gracefully', () async {
        // Arrange
        final error = Exception('Stream error');
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.error(error));

        // Act & Assert
        expect(
          watchMessagesUseCase(testProductId),
          emitsError(error),
        );
      });

      test('should handle empty product ID', () {
        // Arrange
        when(() => mockChatRepository.watchMessages(''))
            .thenAnswer((_) => Stream.value([]));

        // Act
        final result = watchMessagesUseCase('');

        // Assert
        expect(result, emits([]));
      });

      test('should call repository with correct product ID', () {
        // Arrange
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value([]));

        // Act
        watchMessagesUseCase(testProductId);

        // Assert
        verify(() => mockChatRepository.watchMessages(testProductId)).called(1);
      });

      test('should emit messages with correct properties', () async {
        // Arrange
        final messageWithAllProps = const Message(
          id: 'msg_1',
          productId: testProductId,
          senderUsername: 'testuser',
          text: 'Test message',
          createdAt: null,
        );

        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value([messageWithAllProps]));

        // Act & Assert
        await expectLater(
          watchMessagesUseCase(testProductId),
          emits([messageWithAllProps]),
        );
      });

      test('should maintain message order from repository', () async {
        // Arrange
        final orderedMessages = [
          const Message(
            id: '1',
            productId: testProductId,
            senderUsername: 'user1',
            text: 'First',
            createdAt: null,
          ),
          const Message(
            id: '2',
            productId: testProductId,
            senderUsername: 'user2',
            text: 'Second',
            createdAt: null,
          ),
          const Message(
            id: '3',
            productId: testProductId,
            senderUsername: 'user3',
            text: 'Third',
            createdAt: null,
          ),
        ];

        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value(orderedMessages));

        // Act & Assert
        final result = watchMessagesUseCase(testProductId);
        final messages = await result.first;

        expect(messages[0].text, equals('First'));
        expect(messages[1].text, equals('Second'));
        expect(messages[2].text, equals('Third'));
      });

      test('should handle large number of messages', () async {
        // Arrange
        final largeMessageList = List.generate(
          1000,
          (index) => Message(
            id: 'msg_$index',
            productId: testProductId,
            senderUsername: 'user_$index',
            text: 'Message $index',
            createdAt: null,
          ),
        );

        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value(largeMessageList));

        // Act & Assert
        final result = watchMessagesUseCase(testProductId);
        final messages = await result.first;

        expect(messages.length, equals(1000));
      });

      test('should handle Firestore disconnection errors', () async {
        // Arrange
        final error = Exception('Firestore disconnected');
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.error(error));

        // Act & Assert
        expect(
          watchMessagesUseCase(testProductId),
          emitsError(error),
        );
      });

      test('should not call repository more than once per stream creation',
          () async {
        // Arrange
        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => Stream.value(testMessages));

        // Act
        final stream1 = watchMessagesUseCase(testProductId);
        final stream2 = watchMessagesUseCase(testProductId);

        // Assert - Each call should create a new stream
        expect(stream1, isNot(stream2));
        verify(() => mockChatRepository.watchMessages(testProductId))
            .called(2);
      });

      test('should handle multiple emissions from stream', () async {
        // Arrange
        final controller = StreamController<List<Message>>();

        when(() => mockChatRepository.watchMessages(testProductId))
            .thenAnswer((_) => controller.stream);

        // Act
        final stream = watchMessagesUseCase(testProductId);

        controller.add([]);
        controller.add([testMessages[0]]);
        controller.add(testMessages);

        // Assert
        expect(
          stream,
          emitsInOrder([
            [],
            [testMessages[0]],
            testMessages,
          ]),
        );

        await controller.close();
      });
    });
  });
}

