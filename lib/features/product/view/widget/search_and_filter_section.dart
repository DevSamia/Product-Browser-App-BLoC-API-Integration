import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/imports/common_imports.dart';
import '../../bloc/product_bloc.dart';
import '../../bloc/product_event.dart';

class SearchAndFilterSection extends StatelessWidget {
  final String categoryName;
  const SearchAndFilterSection({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          _buildFilterIcon(),
          AppSizes.w12,
          Expanded(
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  context.read<ProductBloc>().add(SearchProductsEvent(value));
                },
                decoration: InputDecoration(
                  hintText: 'Search in $categoryName...',
                  isDense: true,
                  hintStyle: TextStyle(
                    height: 1.2,
                    color: AppColors.gray,
                    fontSize: 13.sp,
                    fontFamily: 'Cairo',
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.gray,
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      height: 48.h,
      width: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.white),
      ),
      child: Icon(Icons.tune_rounded, color: AppColors.move, size: 22.sp),
    );
  }
}
