import '../../../../../core/imports/common_imports.dart';
import '../../../../../l10n/app_localizations.dart';

class ProductPriceSection extends StatelessWidget {
  final ProductDetailModel product;
  const ProductPriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          "${product.price} ${l10n.currency}",
          fontSize: 24.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.textMain,
        ),
        if (product.availabilityStatus.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: PrimaryText(
              product.availabilityStatus,
              fontSize: 12.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
