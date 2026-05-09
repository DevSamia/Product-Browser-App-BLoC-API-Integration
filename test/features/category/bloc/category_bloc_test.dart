import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/category/bloc/category_bloc.dart';
import 'package:product_browser_app/features/category/bloc/category_event.dart';
import 'package:product_browser_app/features/category/bloc/category_state.dart';
import 'package:product_browser_app/features/category/data/category_repository.dart';
import 'package:product_browser_app/features/category/models/category_model.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late CategoryBloc categoryBloc;
  late MockCategoryRepository mockCategoryRepository;

  final tCategories = [
    const CategoryModel(slug: 'beauty', name: 'Beauty', url: 'url1'),
    const CategoryModel(slug: 'fragrances', name: 'Fragrances', url: 'url2'),
  ];

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    categoryBloc = CategoryBloc(mockCategoryRepository);
  });

  tearDown(() {
    categoryBloc.close();
  });

  test('initial state should be CategoryState.initial()', () {
    expect(categoryBloc.state, const CategoryState.initial());
  });

  group('GetCategoriesEvent', () {
    blocTest<CategoryBloc, CategoryState>(
      'emits [loading, success] when data is gotten successfully',
      build: () {
        when(
          () => mockCategoryRepository.getAllCategory(),
        ).thenAnswer((_) async => tCategories);
        return categoryBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [
        const CategoryState.loading(),
        CategoryState.success(categories: tCategories),
      ],
      verify: (_) {
        verify(() => mockCategoryRepository.getAllCategory()).called(1);
      },
    );

    blocTest<CategoryBloc, CategoryState>(
      'emits [loading, error] when getting data fails',
      build: () {
        when(
          () => mockCategoryRepository.getAllCategory(),
        ).thenThrow(Exception('Server Failure'));
        return categoryBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [
        const CategoryState.loading(),
        const CategoryState.error(message: 'failedToLoadCategories'),
      ],
    );
  });
}
