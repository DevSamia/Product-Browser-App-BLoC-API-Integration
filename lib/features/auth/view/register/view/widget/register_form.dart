import '/core/imports/common_imports.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      AppLogger.d("UI: Register form validated. Dispatching event.");
      context.read<AuthBloc>().add(
        AuthEvent.registerRequested(
          email: emailController.text.trim(),
          username: usernameController.text.trim(),
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
              label: context.l10n.username,
              hintText: context.l10n.usernameHint,
              prefixIcon: Icons.person_outline,
              controller: usernameController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.usernameRequired;
                }
                return null;
              },
            ),
            AppSizes.h8,
            PrimaryText(
              context.l10n.usernameHelper,
              fontSize: 12.sp,
              color: AppColors.hintStyleFromTextField,
            ),
            AppSizes.h24,
            CustomTextField(
              label: context.l10n.emailAddress,
              hintText: context.l10n.emailHint,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.emailRequired;
                }
                if (!value.contains('@')) {
                  return context.l10n.enterValidEmail;
                }
                return null;
              },
            ),
            AppSizes.h24,
            CustomTextField(
              label: context.l10n.password,
              hintText: context.l10n.passwordRegisterHint,
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.passwordRequired;
                }
                if (value.length < 6) {
                  return context.l10n.passwordMustBeAtLeast6Chars;
                }
                // Regex: At least one uppercase letter and one number
                final regex = RegExp(r'^(?=.*[A-Z])(?=.*\d).+$');
                if (!regex.hasMatch(value)) {
                  return context.l10n.passwordComplexity;
                }
                return null;
              },
            ),
            AppSizes.h24,
            CustomTextField(
              label: context.l10n.confirmPassword,
              hintText: context.l10n.confirmPasswordHint,
              prefixIcon: Icons.lock_clock_outlined,
              isPassword: true,
              controller: confirmPasswordController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.passwordRequired;
                }
                if (value != passwordController.text) {
                  return context.l10n.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            AppSizes.h8,
            Align(
              alignment: Alignment.centerRight,
              child: PrimaryText(
                context.l10n.strong,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.passwordStrengthStrong,
                letterSpacing: 0.5,
              ),
            ),
            AppSizes.h32,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  orElse: () => RegisterButton(onPressed: _submit),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
