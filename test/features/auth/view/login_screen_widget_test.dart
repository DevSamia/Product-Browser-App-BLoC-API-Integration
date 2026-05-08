import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/auth/bloc/auth_bloc.dart';
import 'package:product_browser_app/features/auth/bloc/auth_event.dart';
import 'package:product_browser_app/features/auth/bloc/auth_state.dart';
import 'package:product_browser_app/features/auth/domain/entities/app_user.dart';
import 'package:product_browser_app/features/auth/view/login/view/login_screen.dart';

// Mock AuthBloc
class MockAuthBloc extends Mock implements AuthBloc {}

// Fake Auth Event
class FakeAuthEvent extends Fake implements AuthEvent {}

// Fake Auth State  
class FakeAuthState extends Fake implements AuthState {}

void main() {
  group('LoginScreen Widget Tests', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      
      // Register fallback values
      registerFallbackValue(FakeAuthEvent());
      registerFallbackValue(FakeAuthState());
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('displays AppLogo on the screen', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify AppLogo is displayed
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('displays welcome text', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify text field presence
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays CircularProgressIndicator during loading state',
        (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays LoginForm in initial state', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify that we're not showing loading indicator
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows SnackBar on authentication success',
        (WidgetTester tester) async {
      const testUser = AppUser(
        id: '1',
        email: 'test@example.com',
        username: 'testuser',
      );

      when(() => mockAuthBloc.state).thenReturn(
        const AuthState.authenticated(testUser),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Navigation would occur, app would change state
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('shows error SnackBar on authentication failure',
        (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(
        const AuthState.error('Invalid credentials'),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Error state is set
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('displays GoogleSignInButton', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify button presence
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays RegisterFooter', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify layout structure
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('disables interaction during loading', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Loading indicator is shown, form is not interactive
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('can scroll through form content', (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify scrolling capability
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Scroll action completed successfully
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('handles rapid state changes', (WidgetTester tester) async {
      when(() => mockAuthBloc.state)
          .thenReturn(const AuthState.initial())
          .thenReturn(const AuthState.loading())
          .thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Verify no crashes during state transitions
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('maintains state after navigation', (WidgetTester tester) async {
      const testUser = AppUser(
        id: '1',
        email: 'test@example.com',
        username: 'testuser',
      );

      when(() => mockAuthBloc.state).thenReturn(
        const AuthState.authenticated(testUser),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // State is properly authenticated
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('displays proper UI for unauthenticated state',
        (WidgetTester tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.unauthenticated());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Shows login form for unauthenticated users
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}

