import '/core/imports/common_imports.dart';

class RegisterSecurityFooter extends StatelessWidget {
  const RegisterSecurityFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            size: 16,
            color: AppColors.textToAskAboutTheExistenceOfAnAccount,
          ),
          AppSizes.w8,
          PrimaryText(
            'SECURED BY PIXELVAULT™',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textToAskAboutTheExistenceOfAnAccount,
            letterSpacing: 1.0,
          ),
        ],
      ),
    );
  }
}
