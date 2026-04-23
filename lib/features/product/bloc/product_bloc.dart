import '../../../core/imports/common_imports.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProductsByCategoryEvent>((event, emit) async {
      AppLogger.i(
        "🚀 Bloc Event: LoadProductsByCategoryEvent -> Category: ${event.categorySlug}",
      );
      emit(ProductLoading());

      try {
        final products = await productRepository.getProductsByCategory(
          event.categorySlug,
        );

        AppLogger.i(
          "🟢 Bloc State: ProductLoaded -> تم تحميل ${products.length} منتج",
        );
        emit(ProductLoaded(allProducts: products, filteredProducts: products));
      } catch (e, stackTrace) {
        AppLogger.e("🔴 Bloc State: ProductError", e, stackTrace);
        emit(ProductError("فشل تحميل المنتجات: ${e.toString()}"));
      }
    });

    on<SearchProductsEvent>((event, emit) {
      AppLogger.d(
        "🔍 Bloc Event: SearchProductsEvent -> Query: '${event.query}'",
      );

      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        if (event.query.isEmpty) {
          AppLogger.d("🧹 Search: Query empty, resetting list.");
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

          AppLogger.i(
            "🎯 Search Result: Found ${filtered.length} products for '${event.query}'",
          );

          emit(
            ProductLoaded(
              allProducts: currentState.allProducts,
              filteredProducts: filtered,
            ),
          );
        }
      } else {
        AppLogger.w(
          "⚠️ Search Warning: Attempted to search while state was not Loaded.",
        );
      }
    });
  }
}
