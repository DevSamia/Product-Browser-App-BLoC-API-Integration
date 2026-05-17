import '../../../../core/imports/common_imports.dart';

class OrderSummarySection extends StatelessWidget {
  final double totalPrice;

  const OrderSummarySection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _summaryRow(context, 'Subtotal', '$totalPrice RS'),
          const SizedBox(height: 12),
          _summaryRow(context, 'Shipping fees', '0.00 RS'),
          Divider(height: 32, color: colorScheme.outlineVariant),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                '$totalPrice RS',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: colorScheme.secondary,
              ),
              PrimaryText(
                'Grand total',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          value,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        PrimaryText(label, color: colorScheme.onSurfaceVariant),
      ],
    );
  }
}
