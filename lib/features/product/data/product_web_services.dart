import '../../../core/imports/common_imports.dart';

class ProductWebServices {
  final Dio dio;
  ProductWebServices(this.dio);

  Future<ProductResponse> getProductsByCategory(String categoryName) async {
    final cleanCategory = categoryName.toLowerCase().trim().replaceAll(
      ' ',
      '-',
    );

    final url = "$productsByCategory$cleanCategory";
    AppLogger.i("🌐 API Request: Fetching products from $url");

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        AppLogger.i("✅ API Success: Retrieved products for $cleanCategory");
        return ProductResponse.fromJson(response.data);
      } else {
        AppLogger.w(
          "⚠️ API Warning: Received status code ${response.statusCode}",
        );
        throw Exception("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      AppLogger.e("❌ API Error for category: $categoryName", e, stackTrace);
      rethrow;
    }
  }
}
