import '../../../core/imports/common_imports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.d("🎨 UI: Building CartScreen...");
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.notifications_none, color: AppColors.gray),
        title: PrimaryText(
          'Shopping bag',
          color: AppColors.textMain,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppLogger.d("🔍 UI: Search button clicked in CartScreen");
            },
            icon: const Icon(Icons.search, color: AppColors.gray),
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) {
                AppLogger.w("⚠️ UI: Displaying Cart Error: $message");
                return Center(
                  child: PrimaryText(message, color: AppColors.error),
                );
              },
              loaded: (cartItems, totalPrice) {
                if (cartItems.isEmpty) {
                  AppLogger.i("ℹ️ UI: Rendering Empty Cart Screen");
                  return Center(
                    child: PrimaryText(
                      'Your shopping cart is empty',
                      fontSize: 16.sp,
                      color: AppColors.gray,
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
                                  color: AppColors.error,
                                  fontSize: 14.sp,
                                ),
                              ),
                              PrimaryText(
                                'Varieties (${cartItems.length})',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.secondary,
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
