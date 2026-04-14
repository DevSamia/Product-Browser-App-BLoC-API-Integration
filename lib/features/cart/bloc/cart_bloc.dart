import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncrementQuantityEvent>(_onIncrement);
    on<DecrementQuantityEvent>(_onDecrement);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final List<CartItemModel> updatedList = List.from(state.cartItems);

    int index = updatedList.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index != -1) {
      updatedList[index].quantity++;
    } else {
      updatedList.add(CartItemModel(product: event.product));
    }

    emit(
      CartLoaded(
        cartItems: updatedList,
        totalPrice: _calculateTotal(updatedList),
      ),
    );
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final List<CartItemModel> updatedList = List.from(state.cartItems)
      ..removeWhere((item) => item.product.id == event.productId);

    emit(
      CartLoaded(
        cartItems: updatedList,
        totalPrice: _calculateTotal(updatedList),
      ),
    );
  }

  void _onIncrement(IncrementQuantityEvent event, Emitter<CartState> emit) {
    final List<CartItemModel> updatedList = List.from(state.cartItems);
    int index = updatedList.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index != -1) {
      updatedList[index].quantity++;
      emit(
        CartLoaded(
          cartItems: updatedList,
          totalPrice: _calculateTotal(updatedList),
        ),
      );
    }
  }

  void _onDecrement(DecrementQuantityEvent event, Emitter<CartState> emit) {
    final List<CartItemModel> updatedList = List.from(state.cartItems);
    int index = updatedList.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index != -1 && updatedList[index].quantity > 1) {
      updatedList[index].quantity--;
      emit(
        CartLoaded(
          cartItems: updatedList,
          totalPrice: _calculateTotal(updatedList),
        ),
      );
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartLoaded(cartItems: [], totalPrice: 0.0));
  }

  double _calculateTotal(List<CartItemModel> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
