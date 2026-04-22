import '../../../core/imports/common_imports.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(const CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncrementQuantityEvent>(_onIncrement);
    on<DecrementQuantityEvent>(_onDecrement);
    on<ClearCartEvent>(_onClearCart);
    on<CompletePurchaseEvent>(_onCompletePurchase);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    try {
      final List<CartItemModel> loadedItems = cartRepository.loadCart();
      emit(
        CartState.loaded(
          cartItems: loadedItems,
          totalPrice: _calculateTotal(loadedItems),
        ),
      );
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }

  Future<void> _updateCart(
    Emitter<CartState> emit,
    List<CartItemModel> updatedList,
  ) async {
    await cartRepository.saveCart(updatedList);
    emit(
      CartState.loaded(
        cartItems: updatedList,
        totalPrice: _calculateTotal(updatedList),
      ),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    state.maybeWhen(
      loaded: (cartItems, totalPrice) async {
        final List<CartItemModel> updatedList = List.from(cartItems);
        int index = updatedList.indexWhere(
          (item) => item.product.id == event.product.id,
        );

        if (index != -1) {
          updatedList[index] = updatedList[index].copyWith(
            quantity: updatedList[index].quantity + 1,
          );
        } else {
          updatedList.add(CartItemModel(product: event.product, quantity: 1));
        }
        await _updateCart(emit, updatedList);
      },
      orElse: () {},
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    state.maybeWhen(
      loaded: (cartItems, totalPrice) async {
        final updatedList = cartItems
            .where((item) => item.product.id != event.productId)
            .toList();
        await _updateCart(emit, updatedList);
      },
      orElse: () {},
    );
  }

  Future<void> _onIncrement(
    IncrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    state.maybeWhen(
      loaded: (cartItems, totalPrice) async {
        final List<CartItemModel> updatedList = List.from(cartItems);
        int index = updatedList.indexWhere(
          (item) => item.product.id == event.productId,
        );

        if (index != -1) {
          updatedList[index] = updatedList[index].copyWith(
            quantity: updatedList[index].quantity + 1,
          );
          await _updateCart(emit, updatedList);
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onDecrement(
    DecrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    state.maybeWhen(
      loaded: (cartItems, totalPrice) async {
        final List<CartItemModel> updatedList = List.from(cartItems);
        int index = updatedList.indexWhere(
          (item) => item.product.id == event.productId,
        );

        if (index != -1 && updatedList[index].quantity > 1) {
          updatedList[index] = updatedList[index].copyWith(
            quantity: updatedList[index].quantity - 1,
          );
          await _updateCart(emit, updatedList);
        }
      },
      orElse: () {},
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    await cartRepository.saveCart([]);
    emit(const CartState.loaded(cartItems: [], totalPrice: 0.0));
  }

  Future<void> _onCompletePurchase(
    CompletePurchaseEvent event,
    Emitter<CartState> emit,
  ) async {
    await cartRepository.saveCart([]);
    emit(const CartState.loaded(cartItems: [], totalPrice: 0.0));
  }

  double _calculateTotal(List<CartItemModel> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
