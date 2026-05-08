import 'package:product_browser_app/features/product/view/widget/list_header.dart';
import 'package:product_browser_app/features/product/view/widget/product_grid.dart';
import 'package:product_browser_app/features/product/view/widget/search_and_filter_section.dart';

import '../../../core/imports/common_imports.dart';
import '../../../l10n/app_localizations.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: _ProductListAppBar(categoryName: categoryName),
      body: SafeArea(
        child: Column(
          children: [
            SearchAndFilterSection(categoryName: categoryName),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const _LoadingWidget(),
                    loaded: (allProducts, filteredProducts) =>
                        _ProductListWidget(products: filteredProducts),
                    error: (message) => _ErrorWidget(
                      message: l10n.failedToLoadProducts,
                      onRetry: () => _handleRetry(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRetry(BuildContext context) {
    AppLogger.i("🔄 UI Retry: Reloading products for $categoryName");
    context.read<ProductBloc>().add(ProductEvent.loadByCategory(categoryName));
  }
}

class _ProductListAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String categoryName;

  const _ProductListAppBar({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.backIcon,
          size: 18.sp,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: PrimaryText(
        categoryName,
        color: AppColors.textMain,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.notificationIcon,
            size: 24.sp,
          ),
          onPressed: () {
            AppLogger.d("🔔 Notification clicked in ProductList");
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 3,
      ),
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  final List<ProductModel> products;

  const _ProductListWidget({required this.products});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: AppColors.textMuted,
            ),
            AppSizes.h16,
            PrimaryText(
              l10n.noProductsFound,
              fontSize: 16.sp,
              color: AppColors.textMuted,
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

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 50.sp,
            ),
            AppSizes.h16,
            PrimaryText(
              message,
              fontSize: 14.sp,
              textAlign: TextAlign.center,
              color: AppColors.textMain,
            ),
            AppSizes.h24,
            SizedBox(
              width: 140.w,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: PrimaryText(l10n.retry, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
