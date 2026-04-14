import 'package:product_browser_app/features/cart/view/widget/checkout_bottom_bar.dart';
import 'package:product_browser_app/features/cart/view/widget/order_summary_section.dart';
import 'package:product_browser_app/features/cart/view/widget/promo_code_section.dart';

import '../../../core/imports/common_imports.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../models/cart_item_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.notifications_none, color: Color(0xFF1D1E20)),
        title: PrimaryText(
          'Shopping bag',
          color: Color(0xFF1D1E20),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF1D1E20)),
          ),
          const SizedBox(width: 8),
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
                        const SizedBox(height: 16),
                        ...state.cartItems.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _CartItemCard(item: item),
                          ),
                        ),
                        const SizedBox(height: 32),
                        OrderSummarySection(totalPrice: state.totalPrice),
                        const SizedBox(height: 16),
                        const PromoCodeSection(),
                        const SizedBox(height: 24),
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

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF3F3F3)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.read<CartBloc>().add(
              RemoveFromCartEvent(item.product.id),
            ),
            icon: Icon(Icons.delete_outline, color: AppColors.gray2),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  item.product.title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              IncrementQuantityEvent(item.product.id),
                            ),
                            icon: const Icon(Icons.add, size: 14),
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              DecrementQuantityEvent(item.product.id),
                            ),
                            icon: const Icon(Icons.remove, size: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: PrimaryText(
                        '${item.product.price} RS',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.move,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              width: 80.w,
              height: 80.h,
              color: AppColors.white,
              child: Image.network(item.product.thumbnail, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
