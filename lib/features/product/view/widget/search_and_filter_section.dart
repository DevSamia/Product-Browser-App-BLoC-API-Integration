import '../../../../core/imports/common_imports.dart';
import '../../../../l10n/app_localizations.dart';

class SearchAndFilterSection extends StatelessWidget {
  final String categoryName;
  const SearchAndFilterSection({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          _buildFilterButton(),
          AppSizes.w12,
          Expanded(child: _buildSearchField(context)),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      height: 48.h,
      width: 48.h,
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton(
        icon: Icon(Icons.tune_rounded, color: AppColors.secondary, size: 22.sp),
        onPressed: () {
          // Future: Add Filter Logic
        },
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
          context.read<ProductBloc>().add(ProductEvent.search(value));
        },
        decoration: InputDecoration(
          hintText: l10n.searchInCategory(categoryName),
          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 20.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
      ),
    );
  }
}
