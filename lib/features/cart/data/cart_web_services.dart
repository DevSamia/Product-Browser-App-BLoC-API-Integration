import '../../../core/imports/common_imports.dart';

class CartWebServices {
  final Dio dio;

  CartWebServices(this.dio);

  Future<Response> addToCart(int userId, int productId, int quantity) async {
    AppLogger.d(
      "🛒 API Request: Adding to cart | User: $userId, Product: $productId, Qty: $quantity",
    );

    try {
      final response = await dio.post(
        addToCartUrl,
        data: {
          'userId': userId,
          'products': [
            {'id': productId, 'quantity': quantity},
          ],
        },
      );

      AppLogger.i(
        "✅ API Success: Product $productId added to cart for user $userId",
      );

      return response;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ API Error: Failed to add product $productId to cart",
        e,
        stackTrace,
      );

      rethrow;
    }
  }
}
