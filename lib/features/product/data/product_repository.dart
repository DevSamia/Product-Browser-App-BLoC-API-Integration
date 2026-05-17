import '../../../core/imports/common_imports.dart';

class ProductRepository {
  final ProductWebServices _webServices;

  ProductRepository(this._webServices);

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    AppLogger.d("📂 Repository: Getting products for category: $categoryName");

    try {
      final response = await _webServices.getProductsByCategory(categoryName);

      AppLogger.d(
        "✅ Repository: Successfully fetched ${response.products.length} products",
      );
      return response.products;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository Error: Failed to fetch products by category",
        e,
        stackTrace,
      );
      // هنا يمكن مستقبلاً استخدام ErrorMapper لتحويل الخطأ لـ Failure object
      rethrow;
    }
  }
}
