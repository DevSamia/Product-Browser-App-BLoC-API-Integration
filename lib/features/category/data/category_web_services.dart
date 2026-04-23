import '../../../core/imports/common_imports.dart';

class CategoryWebServices {
  final Dio dio;
  CategoryWebServices(this.dio);

  Future<List<dynamic>> getAllCategory() async {
    AppLogger.d("🌐 API Request: Fetching all categories");

    try {
      Response response = await dio.get(categories);

      AppLogger.i(
        "✅ API Success: Retrieved ${response.data.length} categories",
      );

      return response.data;
    } catch (e, stackTrace) {
      AppLogger.e("❌ API Error: Failed to fetch categories", e, stackTrace);
      rethrow;
    }
  }

  Future<List<dynamic>> getCategoryDetails(String categoryName) async {
    AppLogger.d("🌐 API Request: Fetching details for category: $categoryName");

    try {
      Response response = await dio.get('products/category/$categoryName');
      AppLogger.i("✅ API Success: Retrieved details for $categoryName");

      return response.data is List ? response.data : response.data['products'];
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ API Error: Failed to fetch category details for $categoryName",
        e,
        stackTrace,
      );
      return [];
    }
  }
}
