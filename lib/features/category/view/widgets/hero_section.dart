import '../../../../core/imports/common_imports.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              color: colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                text: "${context.l10n.welcomeTo} ",
                style: TextStyle(fontSize: 25.sp, color: colorScheme.onSurface),
              ),
              TextSpan(
                text: context.l10n.indigoShop,
                style: TextStyle(color: colorScheme.secondary, fontSize: 25.sp),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        PrimaryText(
          context.l10n.chooseCategorySubtitle,
          color: colorScheme.onSurfaceVariant,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
