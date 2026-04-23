import '../../../core/imports/common_imports.dart';

class ProductRepository {
  final ProductWebServices productWebServices;

  ProductRepository(this.productWebServices);

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    AppLogger.i(
      "📦 Repository: البدء في جلب وتحويل منتجات القسم: $categoryName",
    );

    try {
      final List<dynamic> productsData = await productWebServices
          .getProductsByCategory(categoryName);

      AppLogger.d(
        "📥 Repository: تم استلام ${productsData.length} منتج خام من السيرفس",
      );

      final products = productsData
          .map((productMap) => ProductModel.fromJson(productMap))
          .toList();

      AppLogger.i(
        "✅ Repository: تم تحويل المنتجات لـ Models بنجاح (العدد: ${products.length})",
      );

      return products;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository Error: فشل في تحويل بيانات القسم $categoryName",
        e,
        stackTrace,
      );

      return [];
    }
  }
}
