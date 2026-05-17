import '../../../../core/imports/common_imports.dart';
import 'list_header.dart';
import 'product_grid.dart';

class ProductListContent extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListContent({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: colorScheme.outline,
            ),
            AppSizes.h16,
            PrimaryText(
              l10n.noProductsFound,
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListHeader(count: products.length),
          AppSizes.h16,
          ProductGrid(products: products),
          AppSizes.h20,
        ],
      ),
    );
  }
}
