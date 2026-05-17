import '../../../../core/imports/common_imports.dart';

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(Icons.add_circle, color: colorScheme.primary),
          const Spacer(),
          Icon(Icons.confirmation_number_outlined, color: colorScheme.primary),
          SizedBox(width: 12.w),
          PrimaryText(
            ' ? Do you have a discount code ',
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
