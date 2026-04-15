import '../../../core/imports/common_imports.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;

  ProductLoaded({required this.allProducts, required this.filteredProducts});
}

final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
