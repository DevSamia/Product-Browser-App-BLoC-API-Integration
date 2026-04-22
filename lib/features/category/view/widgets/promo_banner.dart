import '../../../../core/imports/common_imports.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3F51B5), Color(0xFF283593)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3F51B5).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            'Season discount',
            color: AppColors.scaffoldBackground,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
          AppSizes.h10,
          const PrimaryText(
            'Get up to 40% off on the fashion department',
            color: Color(0xFFE0E0E0),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            heightText: 1.4,
          ),
          AppSizes.h20,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD54F),
              foregroundColor: const Color(0xFF1A1A1A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: PrimaryText('Shop now', fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
