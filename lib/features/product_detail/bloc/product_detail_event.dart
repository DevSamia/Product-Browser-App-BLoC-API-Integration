sealed class ProductDetailEvent {
  const ProductDetailEvent();
}

final class FetchProductDetailEvent extends ProductDetailEvent {
  final int productId;
  const FetchProductDetailEvent(this.productId);
}
