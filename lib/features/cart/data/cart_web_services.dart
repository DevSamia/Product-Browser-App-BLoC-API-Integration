import '../../../core/imports/common_imports.dart';

class CartWebServices {
  final Dio dio;

  CartWebServices(this.dio);

  Future<Response> addToCart(int userId, int productId, int quantity) async {
    return await dio.post(
      addToCartUrl,
      data: {
        'userId': userId,
        'products': [
          {'id': productId, 'quantity': quantity},
        ],
      },
    );
  }
}
