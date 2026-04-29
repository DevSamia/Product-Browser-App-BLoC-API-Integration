import '../../../../../../core/imports/common_imports.dart';
import '../../../../bloc/auth_event.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: "Email Address",
            hintText: "name@example.com",
            prefixIcon: Icons.email_outlined,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) return "Email is required";
              if (!value.contains('@')) return "Enter a valid email";
              return null;
            },
          ),
          AppSizes.h24,
          CustomTextField(
            label: "Password",
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            controller: passwordController,
            validator: (value) => (value == null || value.length < 6)
                ? "Password too short"
                : null,
          ),
          AppSizes.h16,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: PrimaryText(
                'Forgot Password?',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          AppSizes.h32,
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  AppLogger.i("UI: Sign In button tapped");
                  if (_formKey.currentState!.validate()) {
                    AppLogger.d(
                      "UI: Form validation passed. Sending LoginRequested event.",
                    );
                    context.read<AuthBloc>().add(
                      AuthEvent.loginRequested(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                  } else {
                    AppLogger.w(
                      "UI: Form validation failed. User inputs are invalid.",
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                      'Sign In',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSignInButton,
                    ),
                    AppSizes.w8,
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.arrowForwardRounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
