import '/core/imports/common_imports.dart';
import '../../../bloc/auth_state.dart';
import 'widget/already_have_account_footer.dart';
import 'widget/register_button.dart';
import 'widget/register_form.dart';
import 'widget/register_header.dart';
import 'widget/register_security_footer.dart';
import 'widget/register_terms_and_conditions.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: PrimaryText(
          'Create New Account',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (user) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                bottomNavigationBarScreen,
                (route) => false,
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: PrimaryText(
                    message,
                    color: Colors.white,
                    fontSize: 14.sp,
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RegisterHeader(),
                          AppSizes.h40,
                          const RegisterForm(),
                          AppSizes.h24,
                          const RegisterTermsAndConditions(),
                          AppSizes.h32,
                          RegisterButton(
                            onPressed: () {
                              // TODO: Implement registration logic
                            },
                          ),
                          AppSizes.h32,
                          const RegisterSecurityFooter(),
                          AppSizes.h40,
                        ],
                      ),
                    ),
                  ),
                ),
                const AlreadyHaveAccountFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
