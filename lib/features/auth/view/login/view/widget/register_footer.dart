import '../../../../../../core/imports/common_imports.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryText(
          context.l10n.dontHaveAccount,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textToAskAboutTheExistenceOfAnAccount,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, registerScreen);
          },
          child: PrimaryText(
            context.l10n.register,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
