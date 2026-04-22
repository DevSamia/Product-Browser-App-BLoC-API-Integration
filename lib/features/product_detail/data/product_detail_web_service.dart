import '../../../core/imports/common_imports.dart';

// class ProductDetailWebService {
//   final Dio _dio;
//   ProductDetailWebService(this._dio);
//
//   Future<ProductDetailModel> getProductDetails(int productId) async {
//     try {
//       final response = await _dio.get(
//         'https://dummyjson.com/products/$productId',
//       );
//       if (response.statusCode == 200) {
//         return ProductDetailModel.fromJson(response.data);
//       } else {
//         throw Exception("فشل في جلب تفاصيل المنتج");
//       }
//     } catch (e) {
//       throw Exception("خطأ في الاتصال: $e");
//     }
//   }
// }

class ProductDetailWebService {
  final Dio _dio;
  ProductDetailWebService(this._dio);

  Future<ProductDetailModel> getProductDetails(int productId) async {
    AppLogger.i("جاري طلب تفاصيل المنتج رقم: $productId من API");

    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/$productId',
      );

      if (response.statusCode == 200) {
        AppLogger.i("تم جلب بيانات المنتج بنجاح: ${response.data['title']}");
        return ProductDetailModel.fromJson(response.data);
      } else {
        AppLogger.w("فشل الطلب مع كود حالة: ${response.statusCode}");
        throw Exception("فشل في جلب تفاصيل المنتج");
      }
    } catch (e, stackTrace) {
      AppLogger.e(
        "حدث خطأ استثنائي أثناء الاتصال بـ API المنتج $productId",
        e,
        stackTrace,
      );
      throw Exception("خطأ في الاتصال: $e");
    }
  }
}
