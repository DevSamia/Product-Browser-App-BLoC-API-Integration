import '../../../../core/imports/common_imports.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.read<CartBloc>().add(
              RemoveFromCartEvent(item.product.id),
            ),
            icon: Icon(Icons.delete_outline, color: colorScheme.error),
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
                  color: colorScheme.onSurface,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              IncrementQuantityEvent(item.product.id),
                            ),
                            icon: Icon(
                              Icons.add,
                              size: 14,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '${item.quantity}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              DecrementQuantityEvent(item.product.id),
                            ),
                            icon: Icon(
                              Icons.remove,
                              size: 14,
                              color: colorScheme.onSurface,
                            ),
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
                        color: colorScheme.secondary,
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
              color: colorScheme.surfaceContainerHighest,
              child: Image.network(
                item.product.thumbnail,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
