import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/core/di/injection_container.dart';
import 'package:product_browser_app/features/chat/domain/entities/message.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:product_browser_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:product_browser_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:product_browser_app/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockChatBloc extends MockBloc<ChatEvent, ChatState> implements ChatBloc {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockChatBloc mockChatBloc;
  late MockSharedPreferences mockSharedPreferences;
  const testProductId = 'prod_123';

  setUpAll(() async {
    mockSharedPreferences = MockSharedPreferences();
    if (!getIt.isRegistered<SharedPreferences>()) {
      getIt.registerSingleton<SharedPreferences>(mockSharedPreferences);
    }

    registerFallbackValue(const ChatEvent.watchMessages(testProductId));
  });

  setUp(() {
    mockChatBloc = MockChatBloc();
    when(
      () => mockSharedPreferences.getString('chat_username'),
    ).thenReturn('testuser');
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<ChatBloc>.value(
          value: mockChatBloc,
          child: const ChatScreen(productId: testProductId),
        ),
      ),
    );
  }

  group('ChatScreen Widget Tests', () {
    testWidgets('should show CircularProgressIndicator when state is loading', (
      tester,
    ) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.loading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show messages when state is loaded', (tester) async {
      final testMessages = [
        Message(
          id: '1',
          productId: testProductId,
          senderUsername: 'u1',
          text: 'Hello',
          createdAt: DateTime.now(),
        ),
      ];
      when(() => mockChatBloc.state).thenReturn(ChatState.loaded(testMessages));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Hello'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should show error message when state is error', (
      tester,
    ) async {
      const errorMsg = 'Failed to load messages';
      when(
        () => mockChatBloc.state,
      ).thenReturn(const ChatState.error(errorMsg));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining(errorMsg), findsOneWidget);
    });

    testWidgets('should call sendMessage event when send icon is pressed', (
      tester,
    ) async {
      when(() => mockChatBloc.state).thenReturn(const ChatState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField), 'Hello world');
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      verify(() => mockChatBloc.add(any())).called(1);
    });
  });
}
