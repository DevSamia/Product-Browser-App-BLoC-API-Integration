import '../../../../core/imports/common_imports.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.read<CartBloc>().add(
              RemoveFromCartEvent(item.product.id),
            ),
            icon: Icon(Icons.delete_outline, color: AppColors.gray),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  item.product.title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              IncrementQuantityEvent(item.product.id),
                            ),
                            icon: const Icon(Icons.add, size: 14),
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              DecrementQuantityEvent(item.product.id),
                            ),
                            icon: const Icon(Icons.remove, size: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: PrimaryText(
                        '${item.product.price} RS',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondary,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              width: 80.w,
              height: 80.h,
              color: AppColors.scaffoldBackground,
              child: Image.network(item.product.thumbnail, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
