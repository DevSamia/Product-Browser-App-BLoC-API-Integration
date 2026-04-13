import 'package:dio/dio.dart';

class ProductWebServices {
  late Dio dio;

  ProductWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getProductsByCategory(String categoryName) async {
    try {
      Response response = await dio.get('products/category/$categoryName');
      return response.data['products'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
