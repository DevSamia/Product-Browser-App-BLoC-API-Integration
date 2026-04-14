sealed class ProductDetailEvent {}

final class FetchProductDetailEvent extends ProductDetailEvent {
  final int productId;
  FetchProductDetailEvent(this.productId);
}
