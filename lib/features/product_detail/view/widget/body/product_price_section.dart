import '../../../../../core/imports/common_imports.dart';

class ProductPriceSection extends StatelessWidget {
  final ProductDetailModel product;
  const ProductPriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PrimaryText(
            "${product.price} ${l10n.currency}",
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: colorScheme.onSurface,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        AppSizes.w10,
        if (product.availabilityStatus.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: PrimaryText(
              product.availabilityStatus,
              fontSize: 12.sp,
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
