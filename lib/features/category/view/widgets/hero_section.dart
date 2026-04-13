import '../../../../core/imports/common_imports.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Cairo',
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Welcome to ',
                style: TextStyle(color: AppColors.gray, fontSize: 25.sp),
              ),
              TextSpan(
                text: 'IndigoShop',
                style: TextStyle(color: AppColors.move, fontSize: 25.sp),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Choose a category to browse the latest carefully selected products.',
          style: TextStyle(
            color: AppColors.gray2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
