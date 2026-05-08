import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:product_browser_app/features/chat/domain/usecases/watch_messages_usecase.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockWatchMessagesUseCase extends Mock implements WatchMessagesUseCase {}

class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ChatBloc chatBloc;
  late MockWatchMessagesUseCase mockWatchMessagesUseCase;
  late MockSendMessageUseCase mockSendMessageUseCase;
  late MockSharedPreferences mockSharedPreferences;

  const testProductId = 'prod_123';
  final testMessages = [
    Message(
      id: '1',
      productId: testProductId,
      senderUsername: 'u1',
      text: 'hi',
      createdAt: DateTime.now(),
    ),
  ];

  setUp(() {
    mockWatchMessagesUseCase = MockWatchMessagesUseCase();
    mockSendMessageUseCase = MockSendMessageUseCase();
    mockSharedPreferences = MockSharedPreferences();

    when(() => mockSharedPreferences.getString(any())).thenReturn('testuser');
    when(
      () => mockSharedPreferences.setString(any(), any()),
    ).thenAnswer((_) async => true);

    chatBloc = ChatBloc(
      watchMessagesUseCase: mockWatchMessagesUseCase,
      sendMessageUseCase: mockSendMessageUseCase,
      prefs: mockSharedPreferences,
    );
  });

  tearDown(() => chatBloc.close());

  group('ChatBloc Tests', () {
    blocTest<ChatBloc, ChatState>(
      'emits [loading, loaded] when messages flow from stream',
      setUp: () {
        when(
          () => mockWatchMessagesUseCase(testProductId),
        ).thenAnswer((_) => Stream.value(testMessages));
      },
      build: () => chatBloc,
      act: (bloc) => bloc.add(const ChatEvent.watchMessages(testProductId)),
      expect: () => [const ChatState.loading(), ChatState.loaded(testMessages)],
    );

    test(
      'should close message stream subscription when bloc is closed',
      () async {
        final controller = StreamController<List<Message>>();
        when(
          () => mockWatchMessagesUseCase(testProductId),
        ).thenAnswer((_) => controller.stream);

        chatBloc.add(const ChatEvent.watchMessages(testProductId));

        // ننتظر قليلاً للتأكد من بدء الاشتراك
        await Future.delayed(Duration.zero);
        expect(controller.hasListener, true);

        await chatBloc.close();

        // نتحقق أن الاشتراك قد تم إلغاؤه (إغلاق الـ stream)
        expect(controller.hasListener, false);
        await controller.close();
      },
    );
  });
}
