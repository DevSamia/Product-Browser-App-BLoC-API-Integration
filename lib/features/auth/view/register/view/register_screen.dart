import '/core/errors/error_mapper.dart';
import '/core/imports/common_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.backIcon,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: PrimaryText(
            context.l10n.createNewAccount,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.appBarTitle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(color: AppColors.appBarDivider, height: 1),
          ),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              authenticated: (user) {
                AppLogger.i("UI: Registration Success - Navigating to Home");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  bottomNavigationBarScreen,
                  (route) => false,
                );
              },
              error: (message) {
                AppLogger.e("UI: Registration Error: $message");
                final errorMessage = ErrorMapper.mapFirebaseError(
                  context,
                  message,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: PrimaryText(
                      errorMessage,
                      color: AppColors.snackBarText,
                      fontSize: 14.sp,
                    ),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            );
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegisterHeader(),
                          AppSizes.h40,
                          RegisterForm(),
                          AppSizes.h24,
                          RegisterTermsAndConditions(),
                          AppSizes.h32,
                          RegisterSecurityFooter(),
                          AppSizes.h40,
                        ],
                      ),
                    ),
                  ),
                ),
                const AlreadyHaveAccountFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
