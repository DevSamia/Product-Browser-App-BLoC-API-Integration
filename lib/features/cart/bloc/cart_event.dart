import '../../../core/imports/common_imports.dart';

@immutable
sealed class CartEvent {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  const AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  const RemoveFromCartEvent(this.productId);
}

class IncrementQuantityEvent extends CartEvent {
  final int productId;
  const IncrementQuantityEvent(this.productId);
}

class DecrementQuantityEvent extends CartEvent {
  final int productId;
  const DecrementQuantityEvent(this.productId);
}

class ClearCartEvent extends CartEvent {}

class CompletePurchaseEvent extends CartEvent {}
