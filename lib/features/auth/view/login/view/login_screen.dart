import '/core/errors/error_mapper.dart';
import '../../../../../../core/imports/common_imports.dart';

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
            success: (message) {
              if (message == "RESET_EMAIL_SENT") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: PrimaryText(
                      context.l10n.passwordResetEmailSent,
                      color: AppColors.textSignInButton,
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            error: (message) {
              AppLogger.e("UI: Login Error received: $message");

              final displayMessage = ErrorMapper.mapFirebaseError(
                context,
                message,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: PrimaryText(
                    displayMessage,
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
                      context.l10n.welcome,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMain,
                    ),
                    AppSizes.h12,
                    PrimaryText(
                      context.l10n.discoverTrends,
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
