import '../../../../core/imports/common_imports.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Cairo',
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: context.l10n.welcomeTo,
                style: TextStyle(color: AppColors.textMuted, fontSize: 25.sp),
              ),
              TextSpan(
                text: context.l10n.indigoShop,
                style: TextStyle(color: AppColors.secondary, fontSize: 25.sp),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          context.l10n.chooseCategorySubtitle,
          style: TextStyle(
            color: AppColors.gray,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
