import 'package:product_browser_app/features/product_detail/bloc/product_detail_event.dart';
import 'package:product_browser_app/features/product_detail/bloc/product_detail_state.dart';

import '../../../core/imports/common_imports.dart';
import '../data/product_detail_service.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailService service;

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
