import '../../../../core/imports/common_imports.dart';
import 'body/cart_badge.dart';
import 'body/product_features_row.dart';
import 'body/product_header_section.dart';
import 'body/product_price_section.dart';
import 'body/product_specifications_table.dart';

class ProductDetailBody extends StatelessWidget {
  final ProductDetailModel product;
  const ProductDetailBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 350.h,
          pinned: true,
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textMain,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            CartBadge(),
            IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.textMain),
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
                ProductHeaderSection(product: product),
                AppSizes.h20,
                ProductPriceSection(product: product),
                AppSizes.h20,
                ProductFeaturesRow(),
                AppSizes.h20,
                PrimaryText(
                  "Description",
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
                AppSizes.h20,
                PrimaryText(
                  product.description,
                  color: AppColors.textMuted,
                  heightText: 1.7,
                ),
                AppSizes.h20,
                PrimaryText(
                  "Specifications",
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
                AppSizes.h16,
                ProductSpecificationsTable(product: product),
                SizedBox(height: 120.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottomBar(BuildContext context, ProductDetailModel product) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final bool isInCart = state.maybeWhen(
              loaded: (cartItems, totalPrice) =>
                  cartItems.any((item) => item.product.id == product.id),
              orElse: () => false,
            );

            return Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryText(
                      "الإجمالي",
                      color: AppColors.textMuted,
                      fontSize: 12.sp,
                    ),
                    PrimaryText(
                      "${product.price}",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
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
                            content: PrimaryText(
                              "The product has been successfully added to the cart.",
                              color: AppColors.scaffoldBackground,
                              fontSize: 14.sp,
                            ),
                            backgroundColor: AppColors.secondary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            action: SnackBarAction(
                              label: "View cart",
                              textColor: AppColors.primary,
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
                          ? AppColors.error
                          : AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: PrimaryText(
                      isInCart ? "حذف من السلة" : "أضف إلى السلة",
                      fontWeight: FontWeight.bold,
                      color: isInCart
                          ? AppColors.scaffoldBackground
                          : AppColors.textMain,
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
