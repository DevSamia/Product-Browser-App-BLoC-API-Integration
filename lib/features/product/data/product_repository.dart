import 'package:product_browser_app/features/product/data/product_web_services.dart';

import '../models/product_model.dart'; // تأكدي من المسار الصحيح للمودل

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
