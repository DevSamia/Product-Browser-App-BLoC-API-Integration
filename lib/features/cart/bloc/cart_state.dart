import 'package:equatable/equatable.dart';

import '../models/cart_item_model.dart';

abstract class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final double totalPrice;

  const CartState({this.cartItems = const [], this.totalPrice = 0.0});

  @override
  List<Object?> get props => [cartItems, totalPrice];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  const CartLoaded({required super.cartItems, required super.totalPrice});
}

class CartError extends CartState {
  final String message;
  const CartError(this.message, {super.cartItems});
}
