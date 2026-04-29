import '../../../../../../core/imports/common_imports.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryText(
          "Don't have an account? ",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textToAskAboutTheExistenceOfAnAccount,
        ),
        GestureDetector(
          onTap: () {},
          child: PrimaryText(
            'Register',
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
