import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product/bloc/product_bloc.dart';
import 'package:product_browser_app/features/product/bloc/product_event.dart';
import 'package:product_browser_app/features/product/bloc/product_state.dart';
import 'package:product_browser_app/features/product/models/product_model.dart';
import 'package:product_browser_app/features/product/view/product_screen.dart';
import 'package:product_browser_app/features/product/view/widget/product_card.dart';
import 'package:product_browser_app/l10n/app_localizations.dart';

/// Mock ProductBloc
class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  // ويدجت مساعد لتهيئة البيئة (الترجمة والـ ScreenUtil)
  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          home: BlocProvider<ProductBloc>.value(
            value: mockProductBloc,
            child: const ProductListScreen(categoryName: 'Electronics'),
          ),
        );
      },
    );
  }

  group('ProductListScreen Widget Tests', () {
    final testProducts = [
      const ProductModel(
        id: 1,
        title: 'Laptop',
        description: 'High-performance laptop',
        category: 'electronics',
        price: 999.99,
        rating: 4.5,
        stock: 10,
        images: [],
      ),
      const ProductModel(
        id: 2,
        title: 'Phone',
        description: 'Smartphone',
        category: 'electronics',
        price: 599.99,
        rating: 4.2,
        stock: 20,
        images: [],
      ),
    ];

    testWidgets('يجب أن يظهر مؤشر التحميل عند حالة loading', (tester) async {
      when(
        () => mockProductBloc.state,
      ).thenReturn(const ProductState.loading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('يجب أن يعرض قائمة المنتجات عند نجاح التحميل', (tester) async {
      when(() => mockProductBloc.state).thenReturn(
        ProductState.loaded(
          allProducts: testProducts,
          filteredProducts: testProducts,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsAtLeastNWidgets(1));
      expect(find.text('Laptop'), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
    });

    testWidgets('يجب أن يعرض رسالة خطأ عند فشل جلب البيانات', (tester) async {
      when(
        () => mockProductBloc.state,
      ).thenReturn(const ProductState.error(message: 'failedToLoadProducts'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // التحقق من وجود أيقونة الخطأ أو رسالة الخطأ
      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
      expect(find.textContaining('Failed to load products'), findsOneWidget);
    });

    testWidgets('يجب أن يعرض رسالة "لا توجد منتجات" عند عودة قائمة فارغة', (
      tester,
    ) async {
      when(() => mockProductBloc.state).thenReturn(
        const ProductState.loaded(allProducts: [], filteredProducts: []),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('No products found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off_rounded), findsOneWidget);
    });

    testWidgets('يجب عرض اسم التصنيف في الـ AppBar', (tester) async {
      when(
        () => mockProductBloc.state,
      ).thenReturn(const ProductState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Electronics'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('يجب أن يحتوي على زر العودة في الـ AppBar', (tester) async {
      when(
        () => mockProductBloc.state,
      ).thenReturn(const ProductState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });
  });
}
