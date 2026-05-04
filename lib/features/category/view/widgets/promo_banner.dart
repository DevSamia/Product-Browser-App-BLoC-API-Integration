import '../../../../core/imports/common_imports.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.promoGradientStart, AppColors.promoGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.promoGradientStart.withValues(alpha: 0.3),
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
            color: AppColors.scaffoldBackground,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
          AppSizes.h10,
          PrimaryText(
            context.l10n.promoSubtitle,
            color: AppColors.promoSubtitle,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            heightText: 1.4,
          ),
          AppSizes.h20,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.promoBtnBackground,
              foregroundColor: AppColors.textDark,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: PrimaryText(context.l10n.shopNow, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
