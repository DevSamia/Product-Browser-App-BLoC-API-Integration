import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/category/bloc/category_bloc.dart';
import 'package:product_browser_app/features/category/bloc/category_event.dart';
import 'package:product_browser_app/features/category/bloc/category_state.dart';
import 'package:product_browser_app/features/category/models/category_model.dart';
import 'package:product_browser_app/features/category/view/category_screen.dart';
import 'package:product_browser_app/features/category/view/widgets/category_item.dart';
import 'package:product_browser_app/l10n/app_localizations.dart';

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

class FakeCategoryEvent extends Fake implements CategoryEvent {}

void main() {
  late MockCategoryBloc mockCategoryBloc;

  setUpAll(() {
    registerFallbackValue(FakeCategoryEvent());
  });

  setUp(() {
    mockCategoryBloc = MockCategoryBloc();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          home: BlocProvider<CategoryBloc>.value(
            value: mockCategoryBloc,
            child: const CategoryScreen(),
          ),
        );
      },
    );
  }

  final tCategories = [
    const CategoryModel(slug: 'beauty', name: 'Beauty', url: 'url1'),
    const CategoryModel(slug: 'fragrances', name: 'Fragrances', url: 'url2'),
  ];

  testWidgets('يجب عرض مؤشر التحميل عند بدئ جلب البيانات', (tester) async {
    when(
      () => mockCategoryBloc.state,
    ).thenReturn(const CategoryState.loading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('يجب عرض قائمة التصنيفات عند نجاح جلب البيانات', (tester) async {
    when(
      () => mockCategoryBloc.state,
    ).thenReturn(CategoryState.success(categories: tCategories));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(CategoryItem), findsNWidgets(2));
    expect(find.text('BEAUTY'), findsOneWidget);
    expect(find.text('FRAGRANCES'), findsOneWidget);
  });

  testWidgets('يجب عرض رسالة خطأ وزر إعادة المحاولة عند فشل جلب البيانات', (
    tester,
  ) async {
    when(
      () => mockCategoryBloc.state,
    ).thenReturn(const CategoryState.error(message: 'failedToLoadCategories'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed to load categories'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets(
    'يجب إرسال حدث GetCategoriesEvent عند الضغط على زر إعادة المحاولة',
    (tester) async {
      // 1. إعداد حالة الخطأ
      when(() => mockCategoryBloc.state).thenReturn(
        const CategoryState.error(message: 'failedToLoadCategories'),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // 2. الضغط على زر "Try Again"
      final retryButton = find.byType(TextButton);
      expect(retryButton, findsOneWidget);
      await tester.tap(retryButton);

      // مهم: الانتظار قليلاً ليتمكن الـ Bloc من استلام الحدث
      await tester.pump();

      // 3. التأكد من إرسال الحدث الصحيح
      verify(
        () => mockCategoryBloc.add(any(that: isA<GetCategoriesEvent>())),
      ).called(1);
    },
  );
}
