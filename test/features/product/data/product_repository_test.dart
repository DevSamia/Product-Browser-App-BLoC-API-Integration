import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product/data/product_repository.dart';
import 'package:product_browser_app/features/product/data/product_web_services.dart';
import 'package:product_browser_app/features/product/models/product_model.dart';

class MockProductWebServices extends Mock implements ProductWebServices {}

void main() {
  late ProductRepository repository;
  late MockProductWebServices mockWebServices;

  setUp(() {
    mockWebServices = MockProductWebServices();
    repository = ProductRepository(mockWebServices);
  });

  final tProductResponse = ProductResponse(
    products: [
      const ProductModel(id: 1, title: 'Test Product', category: 'beauty'),
    ],
    total: 1,
    skip: 0,
    limit: 10,
  );

  group('ProductRepository Tests', () {
    test('يجب أن يعيد قائمة منتجات عند نجاح طلب الـ WebService', () async {
      // Arrange
      when(
        () => mockWebServices.getProductsByCategory(any()),
      ).thenAnswer((_) async => tProductResponse);

      // Act
      final result = await repository.getProductsByCategory('beauty');

      // Assert
      expect(result, equals(tProductResponse.products));
      verify(() => mockWebServices.getProductsByCategory('beauty')).called(1);
    });

    test('يجب أن يرمي Exception عند فشل الـ WebService', () async {
      // Arrange
      when(
        () => mockWebServices.getProductsByCategory(any()),
      ).thenThrow(Exception('Server Error'));

      // Act & Assert
      expect(() => repository.getProductsByCategory('beauty'), throwsException);
    });
  });
}
