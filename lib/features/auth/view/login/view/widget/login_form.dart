import '../../../../../../core/imports/common_imports.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      AppLogger.d("UI: Login Form validated. Sending event.");
      context.read<AuthBloc>().add(
        AuthEvent.loginRequested(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: context.l10n.emailAddress,
              hintText: context.l10n.emailHint,
              prefixIcon: Icons.email_outlined,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.emailRequired;
                }
                if (!value.contains('@')) return context.l10n.enterValidEmail;
                return null;
              },
            ),
            AppSizes.h24,
            CustomTextField(
              label: context.l10n.password,
              hintText: context.l10n.passwordHint,
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: passwordController,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: (_) => _submit(),
              validator: (value) => (value == null || value.length < 6)
                  ? context.l10n.passwordTooShort
                  : null,
            ),
            AppSizes.h16,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isEmpty || !email.contains('@')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: PrimaryText(
                          context.l10n.enterEmailToResetPassword,
                          color: AppColors.textSignInButton,
                        ),
                        backgroundColor: AppColors.error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    context.read<AuthBloc>().add(
                      AuthEvent.passwordResetRequested(email: email),
                    );
                  }
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: PrimaryText(
                  context.l10n.forgotPassword,
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
                  onTap: _submit,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryText(
                        context.l10n.signIn,
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
      ),
    );
  }
}
