import 'package:product_browser_app/features/product_detail/view/widget/build_error_widget.dart';

import '../../../../core/imports/common_imports.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _LoadingWidget(),
            loading: () => const _LoadingWidget(),
            error: (message) => buildErrorWidget(
              context,
              message: message,
              productId: productId,
            ),
            loaded: (product) => ProductDetailBody(product: product),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (product) => ProductDetailBottomBar(product: product),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(child: CircularProgressIndicator(color: colorScheme.primary));
  }
}
