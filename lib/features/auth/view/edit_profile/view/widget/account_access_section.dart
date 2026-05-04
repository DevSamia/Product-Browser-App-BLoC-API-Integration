import 'package:product_browser_app/core/imports/common_imports.dart';

class AccountAccessSection extends StatelessWidget {
  const AccountAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.accountAccessDivider),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: PrimaryText(
                context.l10n.accountAccess,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.accountDetailsLabel,
                letterSpacing: 1.0,
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.accountAccessDivider),
            ),
          ],
        ),
        AppSizes.h24,
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.logoutButtonBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
              Navigator.pushNamedAndRemoveUntil(
                context,
                loginScreen,
                (route) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: AppColors.logoutButtonText,
                  size: 20,
                ),
                AppSizes.w8,
                PrimaryText(
                  context.l10n.logoutFromAccount,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.logoutButtonText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
