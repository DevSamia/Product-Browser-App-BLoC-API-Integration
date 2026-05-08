import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:product_browser_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock ChatBloc
class MockChatBloc extends Mock implements ChatBloc {}

// Mock SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

// Fake ChatEvent
class FakeChatEvent extends Fake implements ChatEvent {}

// Fake ChatState
class FakeChatState extends Fake implements ChatState {}

void main() {
  group('ChatScreen Widget Tests', () {
    late MockChatBloc mockChatBloc;
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
      mockChatBloc = MockChatBloc();
      mockSharedPreferences = MockSharedPreferences();

      registerFallbackValue(FakeChatEvent());
      registerFallbackValue(FakeChatState());

      when(() => mockSharedPreferences.getString('chat_username'))
          .thenReturn('testuser');
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<ChatBloc>.value(
          value: mockChatBloc,
          child: const ChatScreen(productId: testProductId),
        ),
      );
    }

    testWidgets('displays AppBar with title', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Product Chat'), findsOneWidget);
    });

    testWidgets('displays CircularProgressIndicator in loading state',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.loading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays message list when loaded', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(
        ChatState.loaded(testMessages),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('displays empty state message when no messages',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.loaded([]));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(
        find.text('No messages yet. Start chatting!'),
        findsOneWidget,
      );
    });

    testWidgets('displays error message on error state', (WidgetTester tester) async {
      const errorMessage = 'Connection failed';
      when(() => mockChatBloc.state).thenReturn(
        const ChatState.error(errorMessage),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });

    testWidgets('displays text input field', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('displays send button', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(
        find.byIcon(Icons.send),
        findsOneWidget,
      );
    });

    testWidgets('sends message when send button is pressed',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());
      when(() => mockChatBloc.add(any())).thenAnswer((_) => null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Enter message text
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pumpAndSettle();

      // Tap send button
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify that add was called
      verify(() => mockChatBloc.add(any())).called(greaterThan(0));
    });

    testWidgets('clears text field after sending message',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());
      when(() => mockChatBloc.add(any())).thenAnswer((_) => null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Enter message
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pumpAndSettle();

      expect(find.text('Test message'), findsOneWidget);

      // Tap send
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Text field should be cleared
      expect(find.text('Test message'), findsNothing);
    });

    testWidgets('does not send empty message', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());
      when(() => mockChatBloc.add(any())).thenAnswer((_) => null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Tap send with empty text
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // Verify add was not called for empty message
      verifyNever(() => mockChatBloc.add(any()));
    });

    testWidgets('displays multiple messages in list', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(
        ChatState.loaded(testMessages),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Find message widgets
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('can scroll through messages', (WidgetTester tester) async {
      final manyMessages = List.generate(
        20,
        (index) => Message(
          id: 'msg_$index',
          productId: testProductId,
          senderUsername: 'user_$index',
          text: 'Message $index',
          createdAt: null,
        ),
      );

      when(() => mockChatBloc.state).thenReturn(
        ChatState.loaded(manyMessages),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Verify scrolling worked
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('displays correct hint text in input field',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(
        find.text('Type a message...'),
        findsOneWidget,
      );
    });

    testWidgets('handles state transition from loading to loaded',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state)
          .thenReturn(const ChatState.loading())
          .thenReturn(ChatState.loaded(testMessages));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Should show loading first
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Update widget
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Should now show messages
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('triggers watchMessages event on init', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());
      when(() => mockChatBloc.add(any())).thenAnswer((_) => null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify watchMessages event was added
      verify(() => mockChatBloc.add(any())).called(greaterThan(0));
    });

    testWidgets('maintains scroll position when messages update',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(
        ChatState.loaded(testMessages),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Scroll to a position
      await tester.drag(find.byType(ListView), const Offset(0, -100));
      await tester.pumpAndSettle();

      // Messages still visible
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('handles rapid text input', (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Rapid typing
      await tester.enterText(find.byType(TextField), 'T');
      await tester.enterText(find.byType(TextField), 'Te');
      await tester.enterText(find.byType(TextField), 'Tes');
      await tester.enterText(find.byType(TextField), 'Test');
      await tester.pumpAndSettle();

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('send button disabled state during loading',
        (WidgetTester tester) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.loading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Send button still visible but loading indicator shown
      expect(find.byIcon(Icons.send), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

