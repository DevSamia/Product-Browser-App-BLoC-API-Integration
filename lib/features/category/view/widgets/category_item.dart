import '../../../../core/imports/common_imports.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final bool isSelected;

  const CategoryItem({
    required this.category,
    required this.index,
    this.isSelected = false,
    super.key,
  });

  static const List<Color> pastelColors = [
    Color(0xFFE3F2FD),
    Color(0xFFFCE4EC),
    Color(0xFFE8F5E9),
    Color(0xFFFFF3E0),
    Color(0xFFF3E5F5),
    Color(0xFFEFEBE9),
    Color(0xFFE0F2F1),
  ];

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = pastelColors[index % pastelColors.length];

    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: () {
        AppLogger.d("🎯 UI: User selected category: ${category.name}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  getIt<ProductBloc>()
                    ..add(LoadProductsByCategoryEvent(category.slug)),
              child: ProductListScreen(categoryName: category.name),
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24.r),
          border: isSelected
              ? Border.all(color: AppColors.categoryItemBorder, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.categoryItemShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              category.name.toUpperCase(),
              color: AppColors.textDark,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
              fontSize: 14.sp,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            _buildDecorativeBars(),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeBars() {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 3.h,
          decoration: BoxDecoration(
            color: AppColors.categoryDecorativeBar,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 25.w,
          height: 3.h,
          decoration: BoxDecoration(
            color: AppColors.categoryDecorativeBar,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
