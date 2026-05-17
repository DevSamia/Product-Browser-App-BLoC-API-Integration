import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product_detail/data/product_detail_web_service.dart';
import 'package:product_browser_app/features/product_detail/models/product_detail_model.dart';

/// Mock Dio للاختبار
class MockDio extends Mock implements Dio {}

void main() {
  late ProductDetailWebService webService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    webService = ProductDetailWebService(mockDio);

    // تسجيل Fallback Values لـ Mocktail
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('ProductDetailWebService', () {
    const testProductId = 1;

    group('getProductDetails Success Cases', () {
      test('يجب أن يعيد ProductDetailModel عند نجاح الاتصال', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {
              'id': 1,
              'title': 'iPhone 15',
              'price': 999.99,
              'description': 'Latest iPhone model',
              'thumbnail': 'https://example.com/iphone.jpg',
              'category': 'smartphones',
              'discountPercentage': 10.0,
              'rating': 4.8,
              'stock': 50,
              'images': [],
              'reviews': [],
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await webService.getProductDetails(testProductId);

        // Assert
        expect(result, isA<ProductDetailModel>());
        expect(result.id, equals(1));
        expect(result.title, equals('iPhone 15'));
      });

      test('يجب أن يستخدم الـ ID الصحيح في الاتصال', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {'id': 1, 'title': 'Product', 'images': [], 'reviews': []},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        await webService.getProductDetails(testProductId);

        // Assert
        // في mocktail نستخدم any(that: matcher) بدلاً من argThat
        verify(
          () => mockDio.get(any(that: contains('products/$testProductId'))),
        ).called(1);
      });

      test('يجب أن يتعامل مع المنتجات ذات البيانات الناقصة بمرونة', () async {
        // Arrange: بيانات ناقصة جداً
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {'id': 1}, // فقط الـ ID موجود
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await webService.getProductDetails(testProductId);

        // Assert: التأكد أن الموديل استخدم الـ Defaults ولم ينفجر الكود
        expect(result.id, equals(1));
        expect(result.title, equals(''));
        expect(result.reviews, isEmpty);
      });
    });

    group('getProductDetails Error Cases', () {
      test('يجب أن ترمي استثناء عند استلام Status Code 404', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {},
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act & Assert
        expect(
          () => webService.getProductDetails(testProductId),
          throwsException,
        );
      });

      test(
        'يجب أن ترمي استثناء (TypeError) عند فشل الـ Parsing القاتل',
        () async {
          // Arrange: نرسل نصاً بدلاً من Map ليتسبب بـ TypeError حقيقي
          when(() => mockDio.get(any())).thenAnswer(
            (_) async => Response(
              data: "This string will cause TypeError when casting to Map",
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          // Act & Assert
          expect(
            () => webService.getProductDetails(testProductId),
            throwsA(
              isA<Exception>(),
            ), // الـ WebService يغلف أي خطأ بـ Exception
          );
        },
      );

      test(
        'يجب أن ترمي استثناء عند حدوث خطأ في الشبكة (DioException)',
        () async {
          // Arrange
          when(() => mockDio.get(any())).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.connectionError,
            ),
          );

          // Act & Assert
          expect(
            () => webService.getProductDetails(testProductId),
            throwsException,
          );
        },
      );
    });
  });
}
