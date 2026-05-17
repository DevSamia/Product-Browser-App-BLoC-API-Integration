import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product_detail/data/product_detail_repository.dart';
import 'package:product_browser_app/features/product_detail/data/product_detail_web_service.dart';
import 'package:product_browser_app/features/product_detail/models/product_detail_model.dart';

/// Mock ProductDetailWebService
class MockProductDetailWebService extends Mock
    implements ProductDetailWebService {}

void main() {
  late ProductDetailRepository repository;
  late MockProductDetailWebService mockWebService;

  setUp(() {
    mockWebService = MockProductDetailWebService();
    repository = ProductDetailRepository(mockWebService);
  });

  group('ProductDetailRepository - Full Cycle Logic', () {
    const testProductId = 1;
    const testProductDetail = ProductDetailModel(
      id: testProductId,
      title: 'iPhone 15',
      price: 999.99,
      description: 'Latest model',
    );

    group('fetchProductDetails - Success', () {
      test('يجب أن يعيد كائن الموديل عند نجاح الطلب من السيرفر', () async {
        // Arrange
        when(
          () => mockWebService.getProductDetails(testProductId),
        ).thenAnswer((_) async => testProductDetail);

        // Act
        final result = await repository.fetchProductDetails(testProductId);

        // Assert
        expect(result, equals(testProductDetail));
        verify(() => mockWebService.getProductDetails(testProductId)).called(1);
      });
    });

    group('fetchProductDetails - Error Handling (The Real Fix)', () {
      // سينيور نوت: الـ Repository يرمي String وليس Exception كائن
      // لذا نستخدم throwsA(isA<String>()) لنجاح التست

      test('يجب أن يرمي رسالة خطأ نصية عند فشل الـ WebService العام', () async {
        // Arrange
        when(
          () => mockWebService.getProductDetails(any()),
        ).thenThrow(Exception('Internal error'));

        // Act & Assert
        expect(
          () => repository.fetchProductDetails(testProductId),
          throwsA(isA<String>()),
        );
      });

      test(
        'يجب أن يرمي رسالة "Product not found" عند استلام خطأ 404',
        () async {
          // Arrange
          when(() => mockWebService.getProductDetails(any())).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              response: Response(
                statusCode: 404,
                requestOptions: RequestOptions(path: ''),
              ),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act & Assert
          try {
            await repository.fetchProductDetails(testProductId);
            fail('لم يرمِ خطأ نصي كما هو متوقع');
          } catch (e) {
            expect(e, contains('not found'));
          }
        },
      );

      test('يجب أن يرمي رسالة Timeout عند تأخر السيرفر', () async {
        // Arrange
        when(() => mockWebService.getProductDetails(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => repository.fetchProductDetails(testProductId),
          throwsA(contains('connection timed out')),
        );
      });

      test(
        'يجب أن يرمي رسالة "unexpected error" عند حدوث خطأ برمجي غير متوقع',
        () async {
          // Arrange
          when(
            () => mockWebService.getProductDetails(any()),
          ).thenThrow(TypeError());

          // Act & Assert
          expect(
            () => repository.fetchProductDetails(testProductId),
            throwsA(contains('unexpected error')),
          );
        },
      );
    });
  });
}
