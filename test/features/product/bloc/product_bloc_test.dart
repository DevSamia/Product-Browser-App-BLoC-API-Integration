import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_browser_app/features/product/bloc/product_bloc.dart';
import 'package:product_browser_app/features/product/bloc/product_event.dart';
import 'package:product_browser_app/features/product/bloc/product_state.dart';
import 'package:product_browser_app/features/product/data/product_repository.dart';
import 'package:product_browser_app/features/product/models/product_model.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductBloc productBloc;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    productBloc = ProductBloc(mockRepository);
  });

  final tProducts = [
    const ProductModel(id: 1, title: 'iPhone', price: 999.0),
    const ProductModel(id: 2, title: 'Samsung', price: 800.0),
  ];

  group('ProductBloc Logic Tests', () {
    blocTest<ProductBloc, ProductState>(
      'يجب إرسال [loading, loaded] عند جلب البيانات بنجاح',
      build: () {
        when(
          () => mockRepository.getProductsByCategory(any()),
        ).thenAnswer((_) async => tProducts);
        return productBloc;
      },
      act: (bloc) => bloc.add(const ProductEvent.loadByCategory('electronics')),
      expect: () => [
        const ProductState.loading(),
        ProductState.loaded(
          allProducts: tProducts,
          filteredProducts: tProducts,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'يجب تصفية المنتجات عند استخدام ميزة البحث',
      build: () => productBloc,
      seed: () => ProductState.loaded(
        allProducts: tProducts,
        filteredProducts: tProducts,
      ),
      act: (bloc) => bloc.add(const ProductEvent.search('iph')),
      expect: () => [
        ProductState.loaded(
          allProducts: tProducts,
          filteredProducts: [tProducts[0]],
        ),
      ],
    );
  });
}
