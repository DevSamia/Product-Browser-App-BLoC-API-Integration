import '../../../core/imports/common_imports.dart';

class ProductWebServices {
  late Dio dio;

  ProductWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

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
