import '../../../core/imports/common_imports.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(const ProductState.initial()) {
    on<ProductEvent>((event, emit) async {
      await event.map(
        loadByCategory: (e) async =>
            await _onLoadByCategory(e.categorySlug, emit),
        search: (e) async => _onSearch(e.query, emit),
      );
    });
  }

  Future<void> _onLoadByCategory(
    String categorySlug,
    Emitter<ProductState> emit,
  ) async {
    AppLogger.i("🚀 Bloc Event: LoadByCategory for: $categorySlug");
    emit(const ProductState.loading());

    try {
      final products = await productRepository.getProductsByCategory(
        categorySlug,
      );

      AppLogger.i("🟢 Bloc Success: Loaded ${products.length} products");

      emit(
        ProductState.loaded(allProducts: products, filteredProducts: products),
      );
    } catch (e, stackTrace) {
      AppLogger.e("🔴 Bloc Error: Failed to load products", e, stackTrace);
      emit(
        ProductState.error(message: "Failed to load products: ${e.toString()}"),
      );
    }
  }

  void _onSearch(String query, Emitter<ProductState> emit) {
    state.maybeWhen(
      loaded: (allProducts, _) {
        if (query.isEmpty) {
          emit(
            ProductState.loaded(
              allProducts: allProducts,
              filteredProducts: allProducts,
            ),
          );
        } else {
          final filtered = allProducts
              .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
              .toList();

          AppLogger.d(
            "🔍 Bloc Search: Found ${filtered.length} matches for '$query'",
          );

          emit(
            ProductState.loaded(
              allProducts: allProducts,
              filteredProducts: filtered,
            ),
          );
        }
      },
      orElse: () {
        AppLogger.w(
          "⚠️ Bloc Warning: Search attempted while state is not 'loaded'",
        );
      },
    );
  }
}
