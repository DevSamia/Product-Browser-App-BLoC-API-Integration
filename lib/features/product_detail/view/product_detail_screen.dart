import '../../../../core/imports/common_imports.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().add(FetchProductDetailEvent(productId));
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading || state is ProductDetailInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.black),
            );
          } else if (state is ProductDetailError) {
            return buildErrorWidget(
              context,
              message: state.message,
              productId: productId,
            );
          } else if (state is ProductDetailLoaded) {
            return ProductDetailBody(product: state.product);
          }
          return const Center(child: Text("No Data Available"));
        },
      ),
    );
  }
}
