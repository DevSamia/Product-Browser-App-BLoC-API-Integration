import '../core/imports/common_imports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const PrimaryButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textMain,
          foregroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            AppSizes.w15,
            Icon(icon, size: 30.sp),
          ],
        ),
      ),
    );
  }
}
