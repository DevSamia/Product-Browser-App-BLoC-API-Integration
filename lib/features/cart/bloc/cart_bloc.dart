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
      emit(CartState.error(message: "Failed to load cart: ${e.toString()}"));
    }
  }

  Future<void> _updateAndEmit(
    Emitter<CartState> emit,
    List<CartItemModel> items,
  ) async {
    await cartRepository.saveCart(items);
    emit(
      CartState.loaded(cartItems: items, totalPrice: _calculateTotal(items)),
    );
  }

  List<CartItemModel> _getCurrentItems() {
    return state.maybeWhen(
      loaded: (items, _) => List<CartItemModel>.from(items),
      orElse: () => [],
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final items = _getCurrentItems();
    final index = items.indexWhere((i) => i.product.id == event.product.id);

    if (index != -1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItemModel(product: event.product, quantity: 1));
    }
    await _updateAndEmit(emit, items);
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final items = _getCurrentItems()
        .where((i) => i.product.id != event.productId)
        .toList();
    await _updateAndEmit(emit, items);
  }

  Future<void> _onIncrement(
    IncrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final items = _getCurrentItems();
    final index = items.indexWhere((i) => i.product.id == event.productId);

    if (index != -1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
      await _updateAndEmit(emit, items);
    }
  }

  Future<void> _onDecrement(
    DecrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final items = _getCurrentItems();
    final index = items.indexWhere((i) => i.product.id == event.productId);

    if (index != -1 && items[index].quantity > 1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      await _updateAndEmit(emit, items);
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async => await _updateAndEmit(emit, []);

  Future<void> _onCompletePurchase(
    CompletePurchaseEvent event,
    Emitter<CartState> emit,
  ) async => await _updateAndEmit(emit, []);

  double _calculateTotal(List<CartItemModel> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
