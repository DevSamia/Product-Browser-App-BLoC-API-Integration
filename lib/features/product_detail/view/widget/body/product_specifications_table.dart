import '../../../../../core/imports/common_imports.dart';

class ProductSpecificationsTable extends StatelessWidget {
  final ProductDetailModel product;
  const ProductSpecificationsTable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
      ),
      child: Column(
        children: [
          _specRow(context, l10n.categories, product.category),
          Divider(height: 20, color: colorScheme.outlineVariant),
          _specRow(
            context,
            l10n.brand,
            product.sku.isEmpty ? "N/A" : product.sku,
          ),
          Divider(height: 20, color: colorScheme.outlineVariant),
          _specRow(context, l10n.weight, "${product.weight} g"),
          if (product.dimensions != null) ...[
            Divider(height: 20, color: colorScheme.outlineVariant),
            _specRow(
              context,
              l10n.dimensions,
              "${product.dimensions!.width} x ${product.dimensions!.height} x ${product.dimensions!.depth}",
            ),
          ],
        ],
      ),
    );
  }

  Widget _specRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
            label,
            color: colorScheme.onSurfaceVariant,
            fontSize: 13.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: PrimaryText(
              value,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
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
