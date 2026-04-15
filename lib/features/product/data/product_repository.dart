import '../../../core/imports/common_imports.dart';

class ProductRepository {
  final ProductWebServices productWebServices;

  ProductRepository(this.productWebServices);

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    final List<dynamic> productsData = await productWebServices
        .getProductsByCategory(categoryName);

    return productsData
        .map((productMap) => ProductModel.fromJson(productMap))
        .toList();
  }
}
