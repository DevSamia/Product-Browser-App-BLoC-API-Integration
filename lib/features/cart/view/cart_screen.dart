import '../../../core/imports/common_imports.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: Icon(Icons.notifications_none, color: AppColors.gray2),
        title: PrimaryText(
          'Shopping bag',
          color: Color(0xFF1D1E20),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.gray2),
          ),
          AppSizes.w8,
        ],
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.cartItems.isEmpty) {
                return Center(
                  child: PrimaryText(
                    'Your shopping cart is empty',
                    fontSize: 16.sp,
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
                                color: AppColors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                            PrimaryText(
                              'Varieties (${state.cartItems.length})',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.move,
                            ),
                          ],
                        ),
                        AppSizes.h16,
                        ...state.cartItems.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CartItemCard(item: item),
                          ),
                        ),
                        AppSizes.h32,
                        OrderSummarySection(totalPrice: state.totalPrice),
                        AppSizes.h16,
                        const PromoCodeSection(),
                        AppSizes.h25,
                      ],
                    ),
                  ),
                  CheckoutBottomBar(totalPrice: state.totalPrice),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
