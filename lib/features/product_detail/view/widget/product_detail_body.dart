import '../../../../core/di/injection_container.dart';
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
      slivers: [_buildAppBar(context), _buildContent()],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textMain),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        const CartBadge(),
        IconButton(
          icon: const Icon(
            Icons.chat_bubble_outline_rounded,
            color: AppColors.textMain,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => getIt<ChatBloc>(),
                  child: ChatScreen(productId: product.id.toString()),
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: AppColors.textMain),
          onPressed: () {},
        ),
        AppSizes.w10,
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product_image_${product.id}',
          child: Image.network(product.thumbnail, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SliverToBoxAdapter(
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
            const ProductFeaturesRow(),
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
    );
  }
}

class ProductDetailBottomBar extends StatelessWidget {
  final ProductDetailModel product;
  const ProductDetailBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
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
            loaded: (cartItems, _) =>
                cartItems.any((item) => item.product.id == product.id),
            orElse: () => false,
          );

          return Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    "Total",
                    color: AppColors.textMuted,
                    fontSize: 12.sp,
                  ),
                  PrimaryText(
                    "${product.price.toStringAsFixed(2)} RS",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ],
              ),
              AppSizes.w20,
              Expanded(
                child: _AddToCartButton(product: product, isInCart: isInCart),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final ProductDetailModel product;
  final bool isInCart;

  const _AddToCartButton({required this.product, required this.isInCart});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _toggleCart(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: isInCart ? AppColors.error : AppColors.primary,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: PrimaryText(
        isInCart ? "Remove from Cart" : "Add to Cart",
        fontWeight: FontWeight.bold,
        color: isInCart ? Colors.white : AppColors.textMain,
      ),
    );
  }

  void _toggleCart(BuildContext context) {
    if (isInCart) {
      context.read<CartBloc>().add(RemoveFromCartEvent(product.id));
    } else {
      context.read<CartBloc>().add(AddToCartEvent(product));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.title} added to cart successfully")),
      );
    }
  }
}
