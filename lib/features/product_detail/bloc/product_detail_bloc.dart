import '../../../../core/imports/common_imports.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailWebService service;

  ProductDetailBloc(this.service) : super(const ProductDetailState.initial()) {
    on<FetchProductDetailEvent>((event, emit) async {
      emit(const ProductDetailState.loading());

      try {
        final product = await service.getProductDetails(event.productId);

        emit(ProductDetailState.loaded(product));
      } catch (e) {
        emit(ProductDetailState.error(e.toString()));
      }
    });
  }
}
