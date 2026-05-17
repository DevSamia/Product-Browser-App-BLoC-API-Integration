import '../../../../core/imports/common_imports.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, productDetailScreen, arguments: product),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            _buildInfoSection(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Hero(
          tag: 'product_image_${product.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              height: 140.h,
              width: double.infinity,
              color: colorScheme.surfaceContainerHighest,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  color: colorScheme.outline,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: _FavoriteButton(productId: product.id),
        ),
        if (product.discountPercentage > 0)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: _DiscountBadge(discount: product.discountPercentage),
          ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            product.title,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            color: colorScheme.onSurface,
          ),
          AppSizes.h4,
          PrimaryText(
            product.category.toUpperCase(),
            fontSize: 10.sp,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          AppSizes.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryText(
                  '${product.price} ${l10n.currency}',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.primary,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              AppSizes.w4,
              _RatingWidget(rating: product.rating),
            ],
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final int productId;
  const _FavoriteButton({required this.productId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: colorScheme.surface.withValues(alpha: 0.9),
      radius: 14.r,
      child: Icon(
        Icons.favorite_border_rounded,
        size: 16.sp,
        color: colorScheme.primary,
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final double discount;
  const _DiscountBadge({required this.discount});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: PrimaryText(
        '-${discount.round()}%',
        color: colorScheme.onErrorContainer,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _RatingWidget extends StatelessWidget {
  final double rating;
  const _RatingWidget({required this.rating});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: colorScheme.secondary, size: 14.sp),
        AppSizes.w2,
        PrimaryText(
          rating.toString(),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ],
    );
  }
}
