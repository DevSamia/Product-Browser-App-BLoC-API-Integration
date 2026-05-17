import '../../../../../../core/imports/common_imports.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.w,
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
