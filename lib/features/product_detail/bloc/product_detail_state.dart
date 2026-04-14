import '../models/product_detail_model.dart';

sealed class ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailModel product;
  ProductDetailLoaded(this.product);
}

final class ProductDetailError extends ProductDetailState {
  final String message;
  ProductDetailError(this.message);
}
