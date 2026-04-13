import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_browser_app/features/product/bloc/product_event.dart';
import 'package:product_browser_app/features/product/bloc/product_state.dart';

import '../data/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProductsByCategoryEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.getProductsByCategory(
          event.categorySlug,
        );

        emit(ProductLoaded(allProducts: products, filteredProducts: products));
      } catch (e) {
        emit(ProductError("فشل تحميل المنتجات: ${e.toString()}"));
      }
    });

    on<SearchProductsEvent>((event, emit) {
      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        if (event.query.isEmpty) {
          emit(
            ProductLoaded(
              allProducts: currentState.allProducts,
              filteredProducts: currentState.allProducts,
            ),
          );
        } else {
          final filtered = currentState.allProducts.where((product) {
            return product.title.toLowerCase().contains(
              event.query.toLowerCase(),
            );
          }).toList();

          emit(
            ProductLoaded(
              allProducts: currentState.allProducts,
              filteredProducts: filtered,
            ),
          );
        }
      }
    });
  }
}
