import 'package:equatable/equatable.dart';

import '../../product/models/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  RemoveFromCartEvent(this.productId);
}

class IncrementQuantityEvent extends CartEvent {
  final int productId;
  IncrementQuantityEvent(this.productId);
}

class DecrementQuantityEvent extends CartEvent {
  final int productId;
  DecrementQuantityEvent(this.productId);
}

class ClearCartEvent extends CartEvent {}
