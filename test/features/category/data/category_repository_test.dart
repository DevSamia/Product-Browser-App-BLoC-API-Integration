import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/category/data/category_repository.dart';
import 'package:product_browser_app/features/category/data/category_web_services.dart';
import 'package:product_browser_app/features/category/models/category_model.dart';

class MockCategoryWebServices extends Mock implements CategoryWebServices {}

void main() {
  late CategoryRepository repository;
  late MockCategoryWebServices mockWebServices;

  setUp(() {
    mockWebServices = MockCategoryWebServices();
    repository = CategoryRepository(mockWebServices);
  });

  final tRawCategories = [
    {'slug': 'beauty', 'name': 'Beauty', 'url': 'url1'},
    {'slug': 'fragrances', 'name': 'Fragrances', 'url': 'url2'},
  ];

  final tCategoryModels = [
    const CategoryModel(slug: 'beauty', name: 'Beauty', url: 'url1'),
    const CategoryModel(slug: 'fragrances', name: 'Fragrances', url: 'url2'),
  ];

  group('getAllCategory', () {
    test(
      'يجب أن يعيد قائمة من CategoryModel عند نجاح الطلب من WebServices',
      () async {
        // Arrange
        when(
          () => mockWebServices.getAllCategory(),
        ).thenAnswer((_) async => tRawCategories);

        // Act
        final result = await repository.getAllCategory();

        // Assert
        expect(result, equals(tCategoryModels));
        verify(() => mockWebServices.getAllCategory()).called(1);
      },
    );

    test('يجب أن يرمي استثناء عند فشل الطلب من WebServices', () async {
      // Arrange
      when(() => mockWebServices.getAllCategory()).thenThrow(Exception());

      // Act
      final call = repository.getAllCategory;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
