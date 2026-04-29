import '../../../../core/imports/common_imports.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailWebService service;

  ProductDetailBloc(this.service) : super(const ProductDetailState.initial()) {
    on<FetchProductDetailEvent>((event, emit) async {
      AppLogger.i(
        "🚀 Bloc Event: FetchProductDetailEvent for ID: ${event.productId}",
      );

      emit(const ProductDetailState.loading());

      try {
        final product = await service.getProductDetails(event.productId);

        AppLogger.i(
          "🟢 Bloc Success: Loaded details for product: ${product.title}",
        );

        emit(ProductDetailState.loaded(product));
      } catch (e, stackTrace) {
        AppLogger.e(
          "🔴 Bloc Error: Failed to fetch product details",
          e,
          stackTrace,
        );

        emit(
          ProductDetailState.error(
            "Failed to load product details: ${e.toString()}",
          ),
        );
      }
    });
  }
}
