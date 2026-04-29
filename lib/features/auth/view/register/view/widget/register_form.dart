import '/core/imports/common_imports.dart';
import '../../../../../widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextField(
          label: 'Username',
          hintText: 'e.g. alex_shopper',
          prefixIcon: Icons.person_outline,
        ),
        AppSizes.h8,
        PrimaryText(
          'Your unique handle in the PixelCart community.',
          fontSize: 12.sp,
          color: AppColors.hintStyleFromTextField,
        ),
        AppSizes.h24,
        const CustomTextField(
          label: 'Email Address',
          hintText: 'you@example.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        AppSizes.h24,
        const CustomTextField(
          label: 'Password',
          hintText: 'Min. 8 characters',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
        ),
        AppSizes.h8,
        Align(
          alignment: Alignment.centerRight,
          child: PrimaryText(
            'STRONG',
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
            color: const Color(
              0xFF10B981,
            ), // This looks like a status color, might not be in AppColors yet, but let's check if there's a success color.
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
