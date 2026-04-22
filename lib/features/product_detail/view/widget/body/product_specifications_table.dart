import '../../../../../core/imports/common_imports.dart';

class ProductSpecificationsTable extends StatelessWidget {
  final ProductDetailModel product;
  const ProductSpecificationsTable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputBorder,
        borderRadius: BorderRadius.circular(12.r),
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
          PrimaryText(label, color: AppColors.textMuted, fontSize: 13.sp),
          PrimaryText(value, fontWeight: FontWeight.bold, fontSize: 13.sp),
        ],
      ),
    );
  }
}
