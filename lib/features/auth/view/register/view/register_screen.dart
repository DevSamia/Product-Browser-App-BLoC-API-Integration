import '/core/imports/common_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  'Welcome RegisterScreen',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D1F22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
