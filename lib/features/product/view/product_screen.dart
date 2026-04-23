import '../../../core/imports/common_imports.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    AppLogger.d(
      "🎨 UI: Building ProductListScreen for category: $categoryName",
    );
    context.read<ProductBloc>().add(LoadProductsByCategoryEvent(categoryName));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              SearchAndFilterSection(categoryName: categoryName),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    AppLogger.d(
                      "📺 UI: Current ProductState is ${state.runtimeType}",
                    );

                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.textMuted,
                        ),
                      );
                    } else if (state is ProductLoaded) {
                      AppLogger.i(
                        "✨ UI: Rendering ${state.filteredProducts.length} products",
                      );
                      return _buildProductList(state.filteredProducts);
                    } else if (state is ProductError) {
                      AppLogger.w(
                        "⚠️ UI: Displaying error in ProductList: ${state.message}",
                      );
                      return _buildErrorWidget(state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
        onPressed: () {
          AppLogger.d("🔙 UI: User pressed back button from ProductList");
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: PrimaryText(
        categoryName,
        color: AppColors.textMain,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.notificationIcon,
            size: 22.sp,
          ),
          onPressed: () {
            AppLogger.d("🔔 UI: User clicked notifications in ProductList");
          },
        ),
      ],
    );
  }

  Widget _buildProductList(List<dynamic> products) {
    if (products.isEmpty) {
      AppLogger.i("ℹ️ UI: List is empty after search/filter");
      return Center(
        child: PrimaryText('No products match your search', fontSize: 14.sp),
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

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 40.sp),
          AppSizes.h8,
          PrimaryText(message, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
