import '../../../../core/imports/common_imports.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product_details', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProductImage(), _buildProductInfo()],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          child: Container(
            height: 150.h,
            width: double.infinity,
            color: AppColors.screenBackground,
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: CircleAvatar(
            backgroundColor: AppColors.scaffoldBackground,
            radius: 14.r,
            child: Icon(
              Icons.favorite_border_rounded,
              size: 16.sp,
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            product.title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          AppSizes.h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                '${product.price} SAR',
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.secondary,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  PrimaryText(
                    product.rating.toString(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
