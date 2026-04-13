import '../../../core/imports/common_imports.dart';

@immutable
sealed class ProductEvent {}

class LoadProductsByCategoryEvent extends ProductEvent {
  final String categorySlug;
  LoadProductsByCategoryEvent(this.categorySlug);
}

class SearchProductsEvent extends ProductEvent {
  final String query;
  SearchProductsEvent(this.query);
}
