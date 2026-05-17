import '../../../../core/imports/common_imports.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: ProductListAppBar(categoryName: categoryName),
      body: SafeArea(
        child: Column(
          children: [
            SearchAndFilterSection(categoryName: categoryName),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const ProductLoadingWidget(),
                    loaded: (allProducts, filteredProducts) =>
                        ProductListContent(products: filteredProducts),
                    error: (message) => ProductErrorWidget(
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
