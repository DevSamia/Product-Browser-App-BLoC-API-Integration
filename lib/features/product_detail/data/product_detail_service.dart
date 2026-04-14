import 'package:dio/dio.dart';

import '../models/product_detail_model.dart';

class ProductDetailService {
  final Dio _dio;
  ProductDetailService(this._dio);

  Future<ProductDetailModel> getProductDetails(int productId) async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/$productId',
      );
      if (response.statusCode == 200) {
        return ProductDetailModel.fromJson(response.data);
      } else {
        throw Exception("فشل في جلب تفاصيل المنتج");
      }
    } catch (e) {
      throw Exception("خطأ في الاتصال: $e");
    }
  }
}
