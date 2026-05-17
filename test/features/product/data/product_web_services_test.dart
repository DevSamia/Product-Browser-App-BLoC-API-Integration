import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product/data/product_web_services.dart';
import 'package:product_browser_app/features/product/models/product_model.dart';

/// Mock Dio للاختبار
class MockDio extends Mock implements Dio {}

void main() {
  late ProductWebServices webServices;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    webServices = ProductWebServices(mockDio);

    // تسجيل fallback values لـ mocktail
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('ProductWebServices', () {
    const testCategoryName = 'electronics';

    group('getProductsByCategory Success Cases', () {
      test('يجب أن يعيد ProductResponse عند نجاح الاتصال', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {
              'products': [
                {
                  'id': 1,
                  'title': 'Laptop',
                  'description': 'A high-performance laptop',
                  'category': 'electronics',
                  'price': 999.99,
                  'rating': 4.5,
                  'stock': 10,
                  'images': [],
                },
              ],
              'total': 1,
              'skip': 0,
              'limit': 10,
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await webServices.getProductsByCategory(
          testCategoryName,
        );

        // Assert
        expect(result, isA<ProductResponse>());
        expect(result.products.length, equals(1));
        expect(result.products[0].title, equals('Laptop'));
      });

      test('يجب أن ينظف اسم الفئة بالشكل الصحيح', () async {
        // Arrange
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: {'products': [], 'total': 0, 'skip': 0, 'limit': 0},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        await webServices.getProductsByCategory('  Electronics  ');

        // Assert
        verify(() => mockDio.get(any(that: contains('electronics')))).called(1);
      });

      test(
        'يجب أن يتعامل مع المنتجات ذات البيانات الناقصة بمرونة (Resilience)',
        () async {
          // Arrange: بيانات ناقصة تماماً ما عدا الـ ID
          when(() => mockDio.get(any())).thenAnswer(
            (_) async => Response(
              data: {
                'products': [
                  {'id': 101},
                ],
                'total': 1,
              },
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          // Act
          final result = await webServices.getProductsByCategory(
            testCategoryName,
          );

          // Assert: بفضل @Default في Freezed، لن يفشل الـ Parsing
          expect(result.products[0].id, equals(101));
          expect(result.products[0].title, equals('')); // القيمة الافتراضية
        },
      );
    });

    group('getProductsByCategory Error Cases', () {
      test(
        'يجب أن ترمي استثناء عند فشل الـ Parsing (نوع بيانات خاطئ)',
        () async {
          // Arrange: نرسل نصاً بدلاً من قائمة منتجات
          when(() => mockDio.get(any())).thenAnswer(
            (_) async => Response(
              data: {'products': 'this should be a list'},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          // Act & Assert
          expect(
            () => webServices.getProductsByCategory(testCategoryName),
            throwsA(isA<TypeError>()),
          );
        },
      );

      test('يجب أن ترمي استثناء عند استلام Status Code غير 200', () async {
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
          () => webServices.getProductsByCategory(testCategoryName),
          throwsException,
        );
      });

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
            () => webServices.getProductsByCategory(testCategoryName),
            throwsA(isA<DioException>()),
          );
        },
      );
    });
  });
}
