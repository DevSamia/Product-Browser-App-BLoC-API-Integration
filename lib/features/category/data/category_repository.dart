import '../../../core/imports/common_imports.dart';

class CategoryRepository {
  final CategoryWebServices categoryWebServices;
  CategoryRepository(this.categoryWebServices);

  Future<List<CategoryModel>> getAllCategory() async {
    AppLogger.i("📦 Repository: Fetching and mapping all categories");

    try {
      final List<dynamic> response = await categoryWebServices.getAllCategory();
      AppLogger.d(
        "📥 Repository: Received ${response.length} raw categories from WebServices",
      );

      final categories = response
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      AppLogger.i(
        "✅ Repository: Successfully mapped ${categories.length} categories to Models",
      );

      return categories;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository Error: Failed to fetch or map categories",
        e,
        stackTrace,
      );
      throw Exception("Failed to load categories: $e");
    }
  }
}
