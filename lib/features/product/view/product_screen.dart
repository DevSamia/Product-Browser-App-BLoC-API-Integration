import '../../../core/imports/common_imports.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadProductsByCategoryEvent(categoryName));
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              SearchAndFilterSection(categoryName: categoryName),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.gray),
                      );
                    } else if (state is ProductLoaded) {
                      return _buildProductList(state.filteredProducts);
                    } else if (state is ProductError) {
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
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: 18.sp,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: PrimaryText(
        categoryName,
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: AppColors.black,
            size: 22.sp,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProductList(List<dynamic> products) {
    if (products.isEmpty) {
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
          Icon(Icons.error_outline, color: AppColors.red, size: 40.sp),
          AppSizes.h8,
          PrimaryText(message, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
