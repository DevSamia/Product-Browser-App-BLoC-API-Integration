import '/core/imports/common_imports.dart';

class RegisterTermsAndConditions extends StatelessWidget {
  const RegisterTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(
              color: AppColors.outlineInputBorderStyleFromTextField,
              width: 1.5,
            ),
          ),
        ),
        AppSizes.w12,
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                color: AppColors.textColorForSignInWithGoogle,
              ),
              children: [
                TextSpan(text: context.l10n.iAgreeTo),
                TextSpan(
                  text: context.l10n.termsOfService,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: context.l10n.and),
                TextSpan(
                  text: context.l10n.privacyPolicy,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
