import '../../../core/imports/common_imports.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailWebService service;

  ProductDetailBloc(this.service) : super(ProductDetailInitial()) {
    on<FetchProductDetailEvent>((event, emit) async {
      emit(ProductDetailLoading());
      try {
        final product = await service.getProductDetails(event.productId);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        emit(ProductDetailError(e.toString()));
      }
    });
  }
}
