import '../../../core/imports/common_imports.dart';

class ProductRepository {
  final ProductWebServices productWebServices;

  ProductRepository(this.productWebServices);

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    AppLogger.i(
      "📦 Repository: Fetching and mapping products for category: $categoryName",
    );

    try {
      final List<dynamic> productsData = await productWebServices
          .getProductsByCategory(categoryName);

      AppLogger.d(
        "📥 Repository: Received ${productsData.length} raw products from WebService",
      );

      final products = productsData
          .map((productMap) => ProductModel.fromJson(productMap))
          .toList();

      AppLogger.i(
        "✅ Repository: Successfully mapped ${products.length} products to Models",
      );

      return products;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository Error: Failed to map products for category: $categoryName",
        e,
        stackTrace,
      );

      return [];
    }
  }
}
