import '../../../../../core/imports/common_imports.dart';
import '../../../../../l10n/app_localizations.dart';

class ProductSpecificationsTable extends StatelessWidget {
  final ProductDetailModel product;
  const ProductSpecificationsTable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.inputBorder,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _specRow(l10n.categories, product.category),
          const Divider(height: 20),
          _specRow(l10n.brand, product.sku.isEmpty ? "N/A" : product.sku),
          const Divider(height: 20),
          _specRow(l10n.weight, "${product.weight} g"),
          const Divider(height: 20),
          // _specRow(
          //   l10n.dimensions,
          //   "${product.dimensions.width}x${product.dimensions.height}x${product.dimensions.depth}",
          // ),
        ],
      ),
    );
  }

  Widget _specRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(label, color: AppColors.textMuted, fontSize: 13.sp),
          Expanded(
            child: PrimaryText(
              value,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
