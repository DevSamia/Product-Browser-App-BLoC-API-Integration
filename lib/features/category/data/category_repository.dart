import '../models/category_model.dart';
import 'category_web_services.dart';

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
