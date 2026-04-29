import '../../../../../../core/imports/common_imports.dart';
import '../../../bloc/auth_state.dart';
import 'widget/app_logo.dart';
import 'widget/google_sign_in_button.dart';
import 'widget/login_form.dart';
import 'widget/register_footer.dart';
import 'widget/social_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (user) {
              AppLogger.i(
                "UI: Login Success - Navigating to Home for: ${user.email}",
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                bottomNavigationBarScreen,
                (route) => false,
              );
            },
            error: (message) {
              AppLogger.e("UI: Login Error received: $message");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: PrimaryText(
                    message,
                    color: AppColors.textSignInButton,
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSizes.h40,
                    const AppLogo(),
                    AppSizes.h20,
                    PrimaryText(
                      'Welcome',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMain,
                    ),
                    AppSizes.h12,
                    PrimaryText(
                      'Discover the latest trends and shop\nyour favorites with IndigoShop',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTitleForLoginScreen,
                      textAlign: TextAlign.center,
                    ),
                    AppSizes.h40,
                    state.maybeWhen(
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      orElse: () => LoginForm(),
                    ),
                    AppSizes.h20,
                    const SocialDivider(),
                    AppSizes.h20,
                    const GoogleSignInButton(),
                    AppSizes.h20,
                    const RegisterFooter(),
                    AppSizes.h20,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
