import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_browser_app/features/cart/bloc/cart_event.dart';
import 'package:product_browser_app/features/cart/bloc/cart_state.dart';
import 'package:product_browser_app/features/product_detail/bloc/product_detail_bloc.dart';
import 'package:product_browser_app/features/product_detail/bloc/product_detail_event.dart';
import 'package:product_browser_app/features/product_detail/bloc/product_detail_state.dart';
import 'package:product_browser_app/features/product_detail/models/product_detail_model.dart';
import 'package:product_browser_app/features/product_detail/view/product_detail_screen.dart';
import 'package:product_browser_app/features/product_detail/view/widget/product_detail_body.dart';
import 'package:product_browser_app/l10n/app_localizations.dart';

/// Mock Blocs
class MockProductDetailBloc
    extends MockBloc<ProductDetailEvent, ProductDetailState>
    implements ProductDetailBloc {}

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

void main() {
  late MockProductDetailBloc mockProductDetailBloc;
  late MockCartBloc mockCartBloc;

  setUpAll(() {
    registerFallbackValue(const ProductDetailState.initial());
    registerFallbackValue(const FetchProductDetailEvent(1));
  });

  setUp(() {
    mockProductDetailBloc = MockProductDetailBloc();
    mockCartBloc = MockCartBloc();

    when(() => mockCartBloc.state).thenReturn(const CartState.initial());
  });

  Future<void> loadProductDetailScreen(
    WidgetTester tester, {
    required int productId,
  }) async {
    tester.view.physicalSize = const Size(1284, 2778);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            home: MultiBlocProvider(
              providers: [
                BlocProvider<ProductDetailBloc>.value(
                  value: mockProductDetailBloc,
                ),
                BlocProvider<CartBloc>.value(value: mockCartBloc),
              ],
              child: ProductDetailScreen(productId: productId),
            ),
          );
        },
      ),
    );
    await tester.pump();
  }

  const testProductDetail = ProductDetailModel(
    id: 1,
    title: 'iPhone 15 Pro',
    price: 999.99,
    description:
        'The latest iPhone with a powerful A17 Pro chip and Titanium design.',
    thumbnail: '',
    category: 'smartphones',
    availabilityStatus: 'In Stock',
  );

  group('ProductDetailScreen Final Stable Tests', () {
    testWidgets('يجب عرض مؤشر التحميل عند حالة loading', (tester) async {
      when(
        () => mockProductDetailBloc.state,
      ).thenReturn(const ProductDetailState.loading());

      await loadProductDetailScreen(tester, productId: 1);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'يجب عرض محتوى المنتج والـ BottomBar بالكامل عند نجاح التحميل',
      (tester) async {
        when(
          () => mockProductDetailBloc.state,
        ).thenReturn(const ProductDetailState.loaded(testProductDetail));

        await loadProductDetailScreen(tester, productId: 1);
        await tester.pumpAndSettle();

        expect(find.text('iPhone 15 Pro'), findsOneWidget);
        expect(find.byType(ProductDetailBody), findsOneWidget);
        expect(find.byType(ProductDetailBottomBar), findsOneWidget);

        // تم التعديل ي سينيور: السعر يظهر مرتين (في الجسم وفي البار السفلي)
        expect(find.textContaining('999.99'), findsNWidgets(2));
      },
    );

    testWidgets('يجب عرض رسالة خطأ المحددة من السيرفر عند الفشل', (
      tester,
    ) async {
      const errorMsg = 'Failed to fetch data';
      when(
        () => mockProductDetailBloc.state,
      ).thenReturn(const ProductDetailState.error(errorMsg));

      await loadProductDetailScreen(tester, productId: 1);
      await tester.pumpAndSettle();

      expect(find.text(errorMsg), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('يجب التحقق من وجود أزرار التفاعل في الـ AppBar', (
      tester,
    ) async {
      when(
        () => mockProductDetailBloc.state,
      ).thenReturn(const ProductDetailState.loaded(testProductDetail));

      await loadProductDetailScreen(tester, productId: 1);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
    });
  });
}
