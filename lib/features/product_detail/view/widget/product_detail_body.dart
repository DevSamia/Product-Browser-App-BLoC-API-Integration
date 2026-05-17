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
      slivers: [_buildAppBar(context), _buildContent(context)],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        const CartBadge(),
        IconButton(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: colorScheme.onSurface,
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
          icon: Icon(Icons.share_outlined, color: colorScheme.onSurface),
          onPressed: () {},
        ),
        AppSizes.w10,
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product_image_${product.id}',
          child: Container(
            color: colorScheme.surface,
            child: product.thumbnail.isNotEmpty
                ? Image.network(product.thumbnail, fit: BoxFit.contain)
                : Icon(
                    Icons.broken_image_outlined,
                    size: 50,
                    color: colorScheme.onSurfaceVariant,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
              color: colorScheme.onSurface,
            ),
            AppSizes.h20,
            PrimaryText(
              product.description,
              color: colorScheme.onSurfaceVariant,
              heightText: 1.7,
            ),
            AppSizes.h20,
            PrimaryText(
              "Specifications",
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
              color: colorScheme.onSurface,
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
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(
              alpha: colorScheme.brightness == Brightness.dark ? 0.3 : 0.05,
            ),
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
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                      "Total",
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12.sp,
                    ),
                    PrimaryText(
                      "${product.price.toStringAsFixed(2)} ${l10n.currency}",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              AppSizes.w16,
              Expanded(
                flex: 3,
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
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: () => _toggleCart(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: isInCart ? colorScheme.error : colorScheme.primary,
        foregroundColor: isInCart ? colorScheme.onError : colorScheme.onPrimary,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: PrimaryText(
        isInCart ? "Remove" : "Add to Cart",
        fontWeight: FontWeight.bold,
        color: isInCart ? colorScheme.onError : colorScheme.onPrimary,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  void _toggleCart(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (isInCart) {
      context.read<CartBloc>().add(RemoveFromCartEvent(product.id));
    } else {
      context.read<CartBloc>().add(AddToCartEvent(product));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: PrimaryText(
            "${product.title} added successfully",
            color: colorScheme.onInverseSurface,
          ),
          backgroundColor: colorScheme.inverseSurface,
        ),
      );
    }
  }
}
