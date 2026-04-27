import '../../../core/imports/common_imports.dart';

class ProductWebServices {
  final Dio dio;
  ProductWebServices(this.dio);

  Future<List<dynamic>> getProductsByCategory(String categoryName) async {
    if (categoryName.trim().isEmpty) {
      AppLogger.e(
        "❌ Error: categoryName is empty! Check your UI/Bloc navigation.",
      );
      return [];
    }

    final cleanCategory = categoryName.toLowerCase().trim().replaceAll(
      ' ',
      '-',
    );

    try {
      final response = await dio.get("$productsByCategory$cleanCategory");

      AppLogger.i("✅ API Success: Retrieved products for $cleanCategory");
      return response.data['products'];
    } catch (e, stackTrace) {
      AppLogger.e("❌ API Error for category: $categoryName", e, stackTrace);
      return [];
    }
  }
}
