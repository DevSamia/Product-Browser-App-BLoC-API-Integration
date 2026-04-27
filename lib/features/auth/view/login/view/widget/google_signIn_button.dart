import '../../../../../../core/imports/common_imports.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.borderColorGoogleSignInButton,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/google_icon.png', height: 24.h),
              SizedBox(width: 12.sp),
              PrimaryText(
                'Sign in with Google',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColorForSignInWithGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
