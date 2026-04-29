import '../../../../../../core/imports/common_imports.dart';
import '../../../../bloc/auth_event.dart';

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
          onTap: () {
            AppLogger.i("UI: Google Sign In tapped from RegisterScreen");
            context.read<AuthBloc>().add(
              const AuthEvent.googleSignInRequested(),
            );
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImagesConstants.googleIcon, height: 24.h),
              SizedBox(width: 12.w),
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
