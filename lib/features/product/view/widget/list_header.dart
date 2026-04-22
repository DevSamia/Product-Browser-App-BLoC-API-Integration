import '../../../../core/imports/common_imports.dart';

class ListHeader extends StatelessWidget {
  final int count;
  const ListHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                'Discover whats best',
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
              PrimaryText(
                'View all',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ],
          ),
          PrimaryText(
            'was found $count products',
            fontSize: 11.sp,
            color: AppColors.gray,
          ),
        ],
      ),
    );
  }
}
