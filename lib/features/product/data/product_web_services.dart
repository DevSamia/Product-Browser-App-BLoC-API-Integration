import '../../../core/imports/common_imports.dart';

class ProductWebServices {
  final Dio dio;
  ProductWebServices(this.dio);

  Future<List<dynamic>> getProductsByCategory(String categoryName) async {
    AppLogger.d(
      "🌐 API Request: Fetching products for category: $categoryName",
    );

    try {
      Response response = await dio.get('products/category/$categoryName');

      AppLogger.i(
        "✅ API Success: Retrieved products for category: $categoryName",
      );

      return response.data['products'];
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ API Error: Failed to fetch products for category: $categoryName",
        e,
        stackTrace,
      );

      return [];
    }
  }
}
