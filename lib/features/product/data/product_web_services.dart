import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/constants/strings.dart';

class ProductWebServices {
  late Dio dio;

  ProductWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
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
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
