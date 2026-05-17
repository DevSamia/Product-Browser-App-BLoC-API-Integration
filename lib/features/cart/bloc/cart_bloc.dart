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
    AppLogger.i("🚀 Bloc Event: LoadCartEvent");
    emit(const CartLoading());
    try {
      final List<CartItemModel> loadedItems = cartRepository.loadCart();
      final total = _calculateTotal(loadedItems);

      AppLogger.i(
        "🟢 Bloc Success: Loaded ${loadedItems.length} items. Total: \$${total.toStringAsFixed(2)}",
      );
      emit(CartState.loaded(cartItems: loadedItems, totalPrice: total));
    } catch (e, stackTrace) {
      AppLogger.e("🔴 Bloc Error: Failed to load cart", e, stackTrace);
      emit(CartState.error(message: "Failed to load cart: ${e.toString()}"));
    }
  }

  Future<void> _updateAndEmit(
    Emitter<CartState> emit,
    List<CartItemModel> items,
  ) async {
    final total = _calculateTotal(items);
    AppLogger.d(
      "🔄 Bloc Action: Updating cart storage. Items: ${items.length}, Total: \$${total.toStringAsFixed(2)}",
    );

    await cartRepository.saveCart(items);
    emit(CartState.loaded(cartItems: items, totalPrice: total));
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
    AppLogger.i(
      "🚀 Bloc Event: AddToCartEvent -> Product: ${event.product.title}",
    );
    final items = _getCurrentItems();
    final index = items.indexWhere((i) => i.product.id == event.product.id);

    if (index != -1) {
      AppLogger.d(
        "➕ Product exists, incrementing quantity for: ${event.product.title}",
      );
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      AppLogger.d("🆕 New product, adding to cart: ${event.product.title}");
      items.add(CartItemModel(product: event.product, quantity: 1));
    }
    await _updateAndEmit(emit, items);
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    AppLogger.i("🚀 Bloc Event: RemoveFromCartEvent -> ID: ${event.productId}");
    final items = _getCurrentItems()
        .where((i) => i.product.id != event.productId)
        .toList();
    await _updateAndEmit(emit, items);
  }

  Future<void> _onIncrement(
    IncrementQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    AppLogger.d(
      "🚀 Bloc Event: IncrementQuantityEvent -> ID: ${event.productId}",
    );
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
    AppLogger.d(
      "🚀 Bloc Event: DecrementQuantityEvent -> ID: ${event.productId}",
    );
    final items = _getCurrentItems();
    final index = items.indexWhere((i) => i.product.id == event.productId);

    if (index != -1 && items[index].quantity > 1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
      await _updateAndEmit(emit, items);
    } else {
      AppLogger.w(
        "⚠️ Decrement blocked: Quantity is already 1 or item not found.",
      );
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    AppLogger.i("🚀 Bloc Event: ClearCartEvent");
    await _updateAndEmit(emit, []);
  }

  Future<void> _onCompletePurchase(
    CompletePurchaseEvent event,
    Emitter<CartState> emit,
  ) async {
    AppLogger.i(
      "🚀 Bloc Event: CompletePurchaseEvent - Clearing cart after success.",
    );
    await _updateAndEmit(emit, []);
  }

  double _calculateTotal(List<CartItemModel> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
