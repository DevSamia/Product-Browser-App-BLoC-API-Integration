import '/core/imports/common_imports.dart';
import '../../../../../../l10n/app_localizations.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: Size(double.infinity, 56.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: PrimaryText(
        l10n.registerAccount,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textSignInButton,
      ),
    );
  }
}
