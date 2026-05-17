import '../../../../core/imports/common_imports.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 32.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.secondary, colorScheme.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            context.l10n.seasonDiscount,
            color: colorScheme.onSecondary,
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
          ),
          AppSizes.h10,
          PrimaryText(
            context.l10n.promoSubtitle,
            color: colorScheme.onSecondary.withValues(alpha: 0.8),
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            heightText: 1.4,
          ),
          AppSizes.h20,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: PrimaryText(
              context.l10n.shopNow,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
