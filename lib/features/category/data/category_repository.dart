import '../../../core/imports/common_imports.dart';

class CategoryRepository {
  late final CategoryWebServices categoryWebServices;

  CategoryRepository(this.categoryWebServices);

  Future<List<dynamic>> getAllCategory() async {
    final categories = await categoryWebServices.getAllCategory();
    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }
}
