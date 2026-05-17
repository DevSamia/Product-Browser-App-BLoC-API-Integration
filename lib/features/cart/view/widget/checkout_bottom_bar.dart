import '../../../../core/imports/common_imports.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double totalPrice;

  const CheckoutBottomBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [BoxShadow(color: colorScheme.surface, blurRadius: 10)],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          minimumSize: Size(double.infinity, 60.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.2),
          ),
        ),
        child: PrimaryText(
          'Complete your purchase',
          color: Color(0xFF1D1E20),
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
