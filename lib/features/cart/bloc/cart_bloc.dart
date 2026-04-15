import '../../../core/imports/common_imports.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);

    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncrementQuantityEvent>(_onIncrement);
    on<DecrementQuantityEvent>(_onDecrement);
    on<ClearCartEvent>(_onClearCart);

    on<CompletePurchaseEvent>(_onCompletePurchase);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    try {
      final List<ProductModel> savedProducts = cartRepository.loadCart();

      final List<CartItemModel> loadedItems = savedProducts
          .map((product) => CartItemModel(product: product))
          .toList();

      emit(
        CartLoaded(
          cartItems: loadedItems,
          totalPrice: _calculateTotal(loadedItems),
        ),
      );
    } catch (e) {
      emit(const CartLoaded(cartItems: [], totalPrice: 0.0));
    }
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final state = this.state as CartLoaded;
      final List<CartItemModel> updatedList = List.from(state.cartItems);

      int index = updatedList.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (index != -1) {
        updatedList[index].quantity++;
      } else {
        updatedList.add(CartItemModel(product: event.product));
      }

      // حفظ التعديل في SharedPreferences
      await _persistCart(updatedList);

      emit(
        CartLoaded(
          cartItems: updatedList,
          totalPrice: _calculateTotal(updatedList),
        ),
      );
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final state = this.state as CartLoaded;
      final List<CartItemModel> updatedList = List.from(state.cartItems)
        ..removeWhere((item) => item.product.id == event.productId);

      await _persistCart(updatedList);

      emit(
        CartLoaded(
          cartItems: updatedList,
          totalPrice: _calculateTotal(updatedList),
        ),
      );
    }
  }

  Future<void> _onIncrement(
    IncrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final state = this.state as CartLoaded;
      final List<CartItemModel> updatedList = List.from(state.cartItems);
      int index = updatedList.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (index != -1) {
        updatedList[index].quantity++;
        await _persistCart(updatedList);
        emit(
          CartLoaded(
            cartItems: updatedList,
            totalPrice: _calculateTotal(updatedList),
          ),
        );
      }
    }
  }

  Future<void> _onDecrement(
    DecrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final state = this.state as CartLoaded;
      final List<CartItemModel> updatedList = List.from(state.cartItems);
      int index = updatedList.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (index != -1 && updatedList[index].quantity > 1) {
        updatedList[index].quantity--;
        await _persistCart(updatedList);
        emit(
          CartLoaded(
            cartItems: updatedList,
            totalPrice: _calculateTotal(updatedList),
          ),
        );
      }
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    await cartRepository.saveCart([]);
    emit(const CartLoaded(cartItems: [], totalPrice: 0.0));
  }

  Future<void> _onCompletePurchase(
    CompletePurchaseEvent event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      await cartRepository.saveCart([]);
      emit(const CartLoaded(cartItems: [], totalPrice: 0.0));
    }
  }

  Future<void> _persistCart(List<CartItemModel> items) async {
    final List<ProductModel> productsToSave = items
        .map((e) => e.product)
        .toList();
    await cartRepository.saveCart(productsToSave);
  }

  double _calculateTotal(List<CartItemModel> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
