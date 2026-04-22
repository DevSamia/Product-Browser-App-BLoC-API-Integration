import '../../../core/imports/common_imports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.gray),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) =>
                    Center(child: PrimaryText(message, color: AppColors.error)),
                loaded: (cartItems, totalPrice) {
                  if (cartItems.isEmpty) {
                    return Center(
                      child: PrimaryText(
                        'Your shopping cart is empty',
                        fontSize: 16.sp,
                        color: AppColors.gray,
                      ),
                    );
                  }

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
                                  onPressed: () => context.read<CartBloc>().add(
                                    ClearCartEvent(),
                                  ),
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
      ),
    );
  }
}
