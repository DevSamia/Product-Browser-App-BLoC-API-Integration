import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/cart_item_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = CartInitial;
  const factory CartState.loading() = CartLoading;
  const factory CartState.loaded({
    required List<CartItemModel> cartItems,
    required double totalPrice,
  }) = CartLoaded;
  const factory CartState.error({required String message}) = CartError;
}
