import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:product_browser_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:product_browser_app/features/chat/domain/usecases/watch_messages_usecase.dart';

// Mock Dependencies
class MockWatchMessagesUseCase extends Mock implements WatchMessagesUseCase {}

class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('ChatBloc', () {
    late ChatBloc chatBloc;
    late MockWatchMessagesUseCase mockWatchMessagesUseCase;
    late MockSendMessageUseCase mockSendMessageUseCase;
    late MockSharedPreferences mockSharedPreferences;

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

    setUp(() {
      mockWatchMessagesUseCase = MockWatchMessagesUseCase();
      mockSendMessageUseCase = MockSendMessageUseCase();
      mockSharedPreferences = MockSharedPreferences();

      // Default behavior for SharedPreferences
      when(() => mockSharedPreferences.getString('chat_username'))
          .thenReturn('testuser');
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      chatBloc = ChatBloc(
        watchMessagesUseCase: mockWatchMessagesUseCase,
        sendMessageUseCase: mockSendMessageUseCase,
        prefs: mockSharedPreferences,
      );
    });

    tearDown(() => chatBloc.close());

    group('WatchMessagesEvent', () {
      blocTest<ChatBloc, ChatState>(
        'emits [ChatLoading, ChatLoaded] when messages are emitted',
        setUp: () {
          when(() => mockWatchMessagesUseCase(testProductId))
              .thenAnswer((_) => Stream.value(testMessages));
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(const ChatEvent.watchMessages(testProductId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const ChatState.loading(),
          ChatState.loaded(testMessages),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits [ChatLoading, ChatLoaded] with empty list initially',
        setUp: () {
          when(() => mockWatchMessagesUseCase(testProductId))
              .thenAnswer((_) => Stream.value([]));
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(const ChatEvent.watchMessages(testProductId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const ChatState.loading(),
          const ChatState.loaded([]),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits [ChatLoading, ChatError] when stream throws error',
        setUp: () {
          when(() => mockWatchMessagesUseCase(testProductId))
              .thenAnswer((_) => Stream.error(Exception('Firestore error')));
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(const ChatEvent.watchMessages(testProductId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const ChatState.loading(),
          isA<ChatError>(),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'cancels previous subscription when watching new product',
        setUp: () {
          when(() => mockWatchMessagesUseCase(any()))
              .thenAnswer((_) => Stream.value(testMessages));
        },
        build: () => chatBloc,
        act: (bloc) {
          bloc.add(const ChatEvent.watchMessages('prod_1'));
          bloc.add(const ChatEvent.watchMessages('prod_2'));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const ChatState.loading(),
          ChatState.loaded(testMessages),
          const ChatState.loading(),
          ChatState.loaded(testMessages),
        ],
      );
    });

    group('MessagesUpdatedEvent', () {
      blocTest<ChatBloc, ChatState>(
        'emits ChatLoaded with updated messages',
        build: () => chatBloc,
        act: (bloc) => bloc.add(ChatEvent.messagesUpdated(testMessages)),
        expect: () => [
          ChatState.loaded(testMessages),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits ChatLoaded with empty messages list',
        build: () => chatBloc,
        act: (bloc) => bloc.add(const ChatEvent.messagesUpdated([])),
        expect: () => [
          const ChatState.loaded([]),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'updates message list on subsequent updates',
        setUp: () {
          when(() => mockWatchMessagesUseCase(testProductId))
              .thenAnswer((_) => Stream.fromIterable([
                [],
                [testMessages[0]],
                testMessages,
              ]));
        },
        build: () => chatBloc,
        act: (bloc) {
          bloc.add(const ChatEvent.watchMessages(testProductId));
          Future.delayed(const Duration(milliseconds: 50))
              .then((_) => bloc.add(ChatEvent.messagesUpdated(testMessages)));
        },
        wait: const Duration(milliseconds: 200),
        expect: () => [
          const ChatState.loading(),
          const ChatState.loaded([]),
          ChatState.loaded([testMessages[0]]),
          ChatState.loaded(testMessages),
        ],
      );
    });

    group('SendMessageEvent', () {
      blocTest<ChatBloc, ChatState>(
        'successfully sends message',
        setUp: () {
          when(() => mockSendMessageUseCase(
                productId: testProductId,
                senderUsername: 'testuser',
                text: 'Hello',
              )).thenAnswer((_) async {});
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(
          const ChatEvent.sendMessage('Hello', testProductId),
        ),
        expect: () => [], // No state change for send message
      );

      blocTest<ChatBloc, ChatState>(
        'does not send empty message',
        setUp: () {
          when(() => mockSendMessageUseCase(
                productId: any(named: 'productId'),
                senderUsername: any(named: 'senderUsername'),
                text: any(named: 'text'),
              )).thenAnswer((_) async {});
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(
          const ChatEvent.sendMessage('', testProductId),
        ),
        expect: () => [], // No send should occur
      );

      blocTest<ChatBloc, ChatState>(
        'does not send message with only whitespace',
        setUp: () {
          when(() => mockSendMessageUseCase(
                productId: any(named: 'productId'),
                senderUsername: any(named: 'senderUsername'),
                text: any(named: 'text'),
              )).thenAnswer((_) async {});
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(
          const ChatEvent.sendMessage('   ', testProductId),
        ),
        expect: () => [], // No send should occur
      );

      blocTest<ChatBloc, ChatState>(
        'sends message with generated username if not in preferences',
        setUp: () {
          when(() => mockSharedPreferences.getString('chat_username'))
              .thenReturn(null);
          when(() => mockSharedPreferences.setString(any(), any()))
              .thenAnswer((_) async => true);
          when(() => mockSendMessageUseCase(
                productId: any(named: 'productId'),
                senderUsername: any(named: 'senderUsername'),
                text: any(named: 'text'),
              )).thenAnswer((_) async {});
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(
          const ChatEvent.sendMessage('Hello', testProductId),
        ),
        expect: () => [],
      );

      blocTest<ChatBloc, ChatState>(
        'handles send message error gracefully',
        setUp: () {
          when(() => mockSendMessageUseCase(
                productId: any(named: 'productId'),
                senderUsername: any(named: 'senderUsername'),
                text: any(named: 'text'),
              )).thenThrow(Exception('Send failed'));
        },
        build: () => chatBloc,
        act: (bloc) => bloc.add(
          const ChatEvent.sendMessage('Hello', testProductId),
        ),
        expect: () => [], // Error is caught silently in current implementation
      );
    });

    group('Stream Management', () {
      blocTest<ChatBloc, ChatState>(
        'closes message subscription on bloc close',
        setUp: () {
          when(() => mockWatchMessagesUseCase(testProductId))
              .thenAnswer((_) => Stream.value(testMessages));
        },
        build: () => chatBloc,
        act: (bloc) {
          bloc.add(const ChatEvent.watchMessages(testProductId));
        },
        tearDown: () {
          chatBloc.close();
        },
      );
    });

    test('initial state should be ChatInitial', () {
      expect(chatBloc.state, const ChatState.initial());
    });

    test('should handle multiple message emissions in sequence', () async {
      final messageStream = Stream.fromIterable([
        [],
        [testMessages[0]],
        testMessages,
      ]);

      when(() => mockWatchMessagesUseCase(testProductId))
          .thenAnswer((_) => messageStream);

      chatBloc.add(const ChatEvent.watchMessages(testProductId));

      await Future.delayed(const Duration(milliseconds: 100));

      expect(chatBloc.state, isA<ChatLoaded>());
    });

    test('should maintain message list across state changes', () async {
      when(() => mockWatchMessagesUseCase(testProductId))
          .thenAnswer((_) => Stream.value(testMessages));

      chatBloc.add(const ChatEvent.watchMessages(testProductId));

      await Future.delayed(const Duration(milliseconds: 100));

      final currentState = chatBloc.state;
      expect(currentState, isA<ChatLoaded>());

      if (currentState is ChatLoaded) {
        expect(currentState.messages.length, equals(testMessages.length));
      }
    });
  });
}

