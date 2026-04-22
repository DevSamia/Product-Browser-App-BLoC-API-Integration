import '../../../../../core/imports/common_imports.dart';

class ProductHeaderSection extends StatelessWidget {
  final ProductDetailModel product;
  const ProductHeaderSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PrimaryText(
            product.title,
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.inputBorder,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              PrimaryText(
                product.rating.toString(),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              const Icon(
                Icons.star_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
