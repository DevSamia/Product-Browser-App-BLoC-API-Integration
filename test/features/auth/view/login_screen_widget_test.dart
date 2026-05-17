import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/auth/bloc/auth_bloc.dart';
import 'package:product_browser_app/features/auth/bloc/auth_event.dart';
import 'package:product_browser_app/features/auth/bloc/auth_state.dart';
import 'package:product_browser_app/features/auth/view/login/view/login_screen.dart';
import 'package:product_browser_app/features/auth/view/login/view/widget/login_form.dart';
import 'package:product_browser_app/l10n/app_localizations.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const LoginScreen(),
        ),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets(
      'should show CircularProgressIndicator and HIDE LoginForm when state is loading',
      (tester) async {
        // Arrange
        when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(LoginForm), findsNothing);
      },
    );

    testWidgets('should show LoginForm when state is initial', (tester) async {
      // Arrange
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show SnackBar when state is error', (tester) async {
      // Arrange
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthState.error('Invalid credentials')]),
        initialState: const AuthState.initial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
