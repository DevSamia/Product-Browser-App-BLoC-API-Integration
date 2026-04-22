import '../../../../core/imports/common_imports.dart';

class OrderSummarySection extends StatelessWidget {
  final double totalPrice;

  const OrderSummarySection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        children: [
          _summaryRow('Subtotal', '$totalPrice RS'),
          const SizedBox(height: 12),
          _summaryRow('Shipping fees', '0.00 RS'),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                '$totalPrice RS',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.secondary,
              ),
              PrimaryText(
                'Grand total',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(value, fontWeight: FontWeight.bold),
        PrimaryText(label, color: AppColors.gray),
      ],
    );
  }
}
