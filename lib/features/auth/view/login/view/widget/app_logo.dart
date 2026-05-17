import '../../../../../../core/imports/common_imports.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.shopping_bag_outlined,
          color: AppColors.logoColor,
          size: 42,
        ),
      ),
    );
  }
}
