import '../../../core/imports/common_imports.dart';

class ProductDetailWebService {
  final Dio _dio;
  ProductDetailWebService(this._dio);

  Future<ProductDetailModel> getProductDetails(int productId) async {
    AppLogger.i("🌐 API Request: Fetching product details for ID: $productId");

    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/$productId',
      );

      if (response.statusCode == 200) {
        AppLogger.i(
          "✅ API Success: Product data retrieved for: ${response.data['title']}",
        );
        return ProductDetailModel.fromJson(response.data);
      } else {
        AppLogger.w(
          "⚠️ API Warning: Request failed with status code: ${response.statusCode}",
        );
        throw Exception("Failed to fetch product details");
      }
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ API Error: Exceptional error while fetching product $productId",
        e,
        stackTrace,
      );
      throw Exception("Connection error: $e");
    }
  }
}
