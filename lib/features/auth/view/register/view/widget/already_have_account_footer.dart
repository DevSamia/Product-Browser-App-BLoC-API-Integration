import '/core/imports/common_imports.dart';

class AlreadyHaveAccountFooter extends StatelessWidget {
  const AlreadyHaveAccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.fillColorStyleFromTextField,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineInputBorderStyleFromTextField.withValues(
              alpha: 0.5,
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(
                context.l10n.alreadyHaveAccount,
                fontSize: 16.sp,
                color: AppColors.textToAskAboutTheExistenceOfAnAccount,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: PrimaryText(
                  context.l10n.login,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          AppSizes.h12,
          PrimaryText(
            context.l10n.consentText,
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            color: AppColors.hintStyleFromTextField,
          ),
        ],
      ),
    );
  }
}
