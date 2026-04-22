import '../../../core/imports/common_imports.dart';

class CategoryRepository {
  final CategoryWebServices categoryWebServices;

  CategoryRepository(this.categoryWebServices);

  Future<List<CategoryModel>> getAllCategory() async {
    try {
      final List<dynamic> response = await categoryWebServices.getAllCategory();

      return response.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("حدث خطأ أثناء جلب الأقسام: $e");
    }
  }
}
