import '../../../core/imports/common_imports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    AppLogger.d("🎨 UI: Building CartScreen...");

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        leading: Icon(
          Icons.notifications_none,
          color: colorScheme.onSurfaceVariant,
        ),
        title: PrimaryText(
          'Shopping bag',
          color: colorScheme.onSurface,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppLogger.d("🔍 UI: Search button clicked in CartScreen");
            },
            icon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            AppLogger.d("📺 UI: Current CartState is ${state.runtimeType}");

            return state.when(
              initial: () {
                AppLogger.i("ℹ️ UI: Cart is in Initial State");
                return const SizedBox.shrink();
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
              error: (message) {
                AppLogger.w("⚠️ UI: Displaying Cart Error: $message");
                return Center(
                  child: PrimaryText(message, color: colorScheme.error),
                );
              },
              loaded: (cartItems, totalPrice) {
                if (cartItems.isEmpty) {
                  AppLogger.i("ℹ️ UI: Rendering Empty Cart Screen");
                  return Center(
                    child: PrimaryText(
                      'Your shopping cart is empty',
                      fontSize: 16.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  );
                }
                AppLogger.i(
                  "✨ UI: Rendering ${cartItems.length} items in Cart. Total: \$$totalPrice",
                );
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  AppLogger.w(
                                    "🗑️ UI: User clicked 'Delete all' in Cart",
                                  );
                                  context.read<CartBloc>().add(
                                    ClearCartEvent(),
                                  );
                                },
                                child: PrimaryText(
                                  'Delete all',
                                  color: colorScheme.error,
                                  fontSize: 14.sp,
                                ),
                              ),
                              PrimaryText(
                                'Varieties (${cartItems.length})',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.secondary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...cartItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CartItemCard(item: item),
                            ),
                          ),
                          AppSizes.h32,
                          OrderSummarySection(totalPrice: totalPrice),
                          AppSizes.h16,
                          const PromoCodeSection(),
                          AppSizes.h25,
                        ],
                      ),
                    ),
                    CheckoutBottomBar(totalPrice: totalPrice),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
