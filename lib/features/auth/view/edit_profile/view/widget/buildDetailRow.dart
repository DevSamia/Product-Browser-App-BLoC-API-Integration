import '../../../../../../core/imports/common_imports.dart';

Widget buildDetailRow({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.detailCardShadow,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        AppSizes.w16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              label,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.accountDetailsLabel,
              letterSpacing: 0.5,
            ),
            PrimaryText(
              value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.accountDetailsValue,
            ),
          ],
        ),
      ],
    ),
  );
}
