import '/core/imports/common_imports.dart';
import '../../../bloc/auth_state.dart';

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
                '/home',
                (route) => false,
              );
            },
            error: (message) {
              AppLogger.e("UI: Login Error received: $message");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: PrimaryText(
                    message,
                    color: AppColors.scaffoldBackground,
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
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSizes.h40,
                    AppLogo(),
                    AppSizes.h32,
                    PrimaryText(
                      'Welcome',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D1F22),
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
                    AppSizes.h30,
                    SocialDivider(),
                    AppSizes.h20,
                    GoogleSignInButton(),
                    AppSizes.h40,
                    RegisterFooter(),
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
