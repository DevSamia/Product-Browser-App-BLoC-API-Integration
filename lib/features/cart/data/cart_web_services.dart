import 'package:dio/dio.dart';

class CartWebServices {
  final Dio dio;

  CartWebServices(this.dio);
  Future<Map<String, dynamic>> addToCart(
    int userId,
    int productId,
    int quantity,
  ) async {
    try {
      Response response = await dio.post(
        'https://dummyjson.com/carts/add',
        data: {
          'userId': userId,
          'products': [
            {'id': productId, 'quantity': quantity},
          ],
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
