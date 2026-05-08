import '../../../../core/imports/common_imports.dart';
import '../../../../l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, productDetailScreen, arguments: product),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildInfoSection(l10n)],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Hero(
          tag: 'product_image_${product.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              height: 140.h,
              width: double.infinity,
              color: AppColors.screenBackground,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.gray,
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

  Widget _buildInfoSection(AppLocalizations l10n) {
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
          ),
          AppSizes.h4,
          PrimaryText(
            product.category.toUpperCase(),
            fontSize: 10.sp,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
          AppSizes.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    '${product.price} ${l10n.currency}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondary,
                  ),
                ],
              ),
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
    return CircleAvatar(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      radius: 14.r,
      child: Icon(
        Icons.favorite_border_rounded,
        size: 16.sp,
        color: AppColors.error,
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final double discount;
  const _DiscountBadge({required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: PrimaryText(
        '-${discount.round()}%',
        color: Colors.white,
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
    return Row(
      children: [
        Icon(Icons.star_rounded, color: AppColors.primary, size: 14.sp),
        AppSizes.w2,
        PrimaryText(
          rating.toString(),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
