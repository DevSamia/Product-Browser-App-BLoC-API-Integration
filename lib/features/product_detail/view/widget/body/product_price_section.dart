import '../../../../../core/imports/common_imports.dart';

class ProductPriceSection extends StatelessWidget {
  final ProductDetailModel product;
  const ProductPriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          "${product.price} RAS",
          fontSize: 24.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.textMain,
        ),
        PrimaryText(
          product.stockStatus,
          fontSize: 12.sp,
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
