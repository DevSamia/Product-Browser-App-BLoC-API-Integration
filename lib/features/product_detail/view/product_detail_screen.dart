import '../../../../core/imports/common_imports.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().add(FetchProductDetailEvent(productId));

    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,

          body: state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(color: AppColors.textMain),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.textMain),
            ),
            error: (message) => buildErrorWidget(
              context,
              message: message,
              productId: productId,
            ),
            loaded: (product) => ProductDetailBody(product: product),
          ),

          bottomNavigationBar: state.maybeWhen(
            loaded: (product) => ProductDetailBody(
              product: product,
            ).buildBottomBar(context, product),
            orElse: () => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
