import '../../../../core/imports/common_imports.dart';
import '../../../cart/bloc/cart_bloc.dart';
import '../../../cart/bloc/cart_event.dart';
import '../../../cart/bloc/cart_state.dart';
import '../../models/product_detail_model.dart';

class ProductDetailBody extends StatelessWidget {
  final ProductDetailModel product;
  const ProductDetailBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 350.h,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                _buildCartBadge(),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.black),
                  onPressed: () {},
                ),
                AppSizes.w10,
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'product_${product.id}',
                  child: Image.network(product.thumbnail, fit: BoxFit.contain),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizes.h20,
                    _buildHeaderSection(),
                    AppSizes.h20,
                    _buildPriceSection(),
                    AppSizes.h20,
                    _buildFeaturesRow(),
                    AppSizes.h20,
                    const PrimaryText(
                      "Description",
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    AppSizes.h20,
                    PrimaryText(
                      product.description,
                      color: AppColors.gray,
                      heightText: 1.7,
                    ),
                    AppSizes.h20,
                    const PrimaryText(
                      "Specifications",
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    AppSizes.h16,
                    _buildSpecsTable(),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildCartBadge() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Badge(
          isLabelVisible: state.cartItems.isNotEmpty,
          label: Text(state.cartItems.length.toString()),
          backgroundColor: const Color(0xFFFFC107),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PrimaryText(
            product.title,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              PrimaryText(
                product.rating.toString(),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFFFC107),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          "${product.price} RAS",
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppColors.black,
        ),
        PrimaryText(
          product.stockStatus,
          fontSize: 12,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildFeaturesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _featureIcon(Icons.local_shipping_outlined, "Fast shipping"),
        _featureIcon(Icons.verified_user_outlined, "Original guarantee"),
        _featureIcon(Icons.history_rounded, "Easy returns"),
      ],
    );
  }

  Widget _featureIcon(IconData icon, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFFF0F2FF),
          child: Icon(icon, color: AppColors.black),
        ),
        AppSizes.h8,
        PrimaryText(text, fontSize: 11, color: AppColors.gray),
      ],
    );
  }

  Widget _buildSpecsTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _specRow("Section", product.category),
          const Divider(),
          _specRow("Brand", product.sku),
          const Divider(),
          _specRow("Return Policy", product.returnPolicy),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(label, color: AppColors.gray, fontSize: 13),
          PrimaryText(value, fontWeight: FontWeight.bold, fontSize: 13),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final bool isInCart = state.cartItems.any(
              (item) => item.product.id == product.id,
            );

            return Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PrimaryText(
                      "الإجمالي",
                      color: AppColors.gray,
                      fontSize: 12,
                    ),
                    PrimaryText(
                      "${product.price}",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ],
                ),
                AppSizes.w20,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isInCart) {
                        context.read<CartBloc>().add(
                          RemoveFromCartEvent(product.id),
                        );
                      } else {
                        context.read<CartBloc>().add(AddToCartEvent(product));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const PrimaryText(
                              "The product has been successfully added to the cart.",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            backgroundColor: const Color(0xFF2F45BD),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            action: SnackBarAction(
                              label: "View cart",
                              textColor: const Color(0xFFFFC107),
                              onPressed: () {
                                Navigator.pushNamed(context, '/cart_screen');
                              },
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInCart
                          ? Colors.red.shade400
                          : const Color(0xFFFFC107),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: PrimaryText(
                      isInCart ? "حذف من السلة" : "أضف إلى السلة",
                      fontWeight: FontWeight.bold,
                      color: isInCart ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
