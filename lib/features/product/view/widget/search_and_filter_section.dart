import '../../../../core/imports/common_imports.dart';

class SearchAndFilterSection extends StatelessWidget {
  final String categoryName;
  const SearchAndFilterSection({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(
                Icons.tune_rounded,
                color: colorScheme.secondary,
                size: 22.sp,
              ),
              onPressed: () {
                // Future: Add Filter Logic
              },
            ),
          ),
          AppSizes.w12,
          Expanded(child: _buildSearchField(context)),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: colorScheme.onSurface, fontSize: 14.sp),
        onChanged: (value) {
          context.read<ProductBloc>().add(ProductEvent.search(value));
        },
        decoration: InputDecoration(
          hintText: l10n.searchInCategory(categoryName),
          hintStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 20.sp,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          fillColor: Colors.transparent, // Overriding the theme's fillColor
        ),
      ),
    );
  }
}
