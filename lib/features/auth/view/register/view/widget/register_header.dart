import '/core/imports/common_imports.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.h32,
        PrimaryText(
          'Join IndigoShop',
          fontSize: 28.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.textMain,
        ),
        AppSizes.h8,
        PrimaryText(
          'Start your premium shopping journey today.',
          fontSize: 15.sp,
          color: AppColors.textToAskAboutTheExistenceOfAnAccount,
        ),
      ],
    );
  }
}
