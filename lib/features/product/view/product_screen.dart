import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;
  const ProductListScreen({super.key, required this.categoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      LoadProductsByCategoryEvent(widget.categoryName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: Column(
                children: [
                  _SearchAndFilterSection(categoryName: widget.categoryName),
                  Expanded(
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF3F51B5),
                            ),
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
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18.sp),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        widget.categoryName,
        style: TextStyle(
          color: const Color(0xFF1A1A1A),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Cairo',
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: Colors.black,
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
        child: Text(
          'No products match your search',
          style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
        ),
      );
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ListHeader(count: products.length),
          SizedBox(height: 16.h),
          _ProductGrid(products: products),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40.sp),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

class _SearchAndFilterSection extends StatelessWidget {
  final String categoryName;
  const _SearchAndFilterSection({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          _buildFilterIcon(),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              height: 45.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                textAlign: TextAlign.start,
                onChanged: (value) {
                  context.read<ProductBloc>().add(SearchProductsEvent(value));
                },
                decoration: InputDecoration(
                  hintText: 'Search in $categoryName...',
                  isDense: true,
                  hintStyle: TextStyle(
                    height: 1.2,
                    color: const Color(0xFFBDBDBD),
                    fontSize: 13.sp,
                    fontFamily: 'Cairo',
                  ),
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: const Color(0xFFBDBDBD),
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 5.h,
                  ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Icon(
        Icons.tune_rounded,
        color: const Color(0xFF3F51B5),
        size: 22.sp,
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  final int count;
  const _ListHeader({required this.count});

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
              Text(
                'Discover whats best',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                'View all',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3F51B5),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          Text(
            'was found $count products',
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF9E9E9E),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<dynamic> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 0.80,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => _ProductCard(product: products[index]),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/productDetail', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildProductImage(), _buildProductInfo()],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          child: Container(
            height: 150.h,
            width: double.infinity,
            color: const Color(0xFFF2F2F2),
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 14.r,
            child: Icon(
              Icons.favorite_border_rounded,
              size: 16.sp,
              color: const Color(0xFFEF5350),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: const Color(0xFFFFB300),
                    size: 14.sp,
                  ),
                  Text(
                    product.rating.toString(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                '${product.price} SAR',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF3F51B5),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
