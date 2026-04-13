import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/imports/common_imports.dart';
import '../../../product/bloc/product_bloc.dart';
import '../../../product/data/product_repository.dart';
import '../../../product/data/product_web_services.dart';
import '../../../product/view/product_screen.dart';
import '../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final int index;

  const CategoryItem({required this.category, required this.index, super.key});
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  ProductBloc(ProductRepository(ProductWebServices())),
              child: ProductListScreen(categoryName: category.name),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryText(
              category.name,
              color: const Color(0xFF1A1A1A),
              fontWeight: FontWeight.w800,
              fontSize: 15.sp,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                Container(
                  width: 50.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                AppSizes.h5,
                Container(
                  width: 30.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
