import 'dart:convert';

import '../../../core/imports/common_imports.dart';

class CartRepository {
  final CartWebServices cartWebServices;
  final SharedPreferences sharedPreferences;
  static const String _cartKey = 'user_cart_v2';

  CartRepository(this.cartWebServices, this.sharedPreferences);

  Future<void> saveCart(List<CartItemModel> items) async {
    final String encodedData = jsonEncode(
      items.map((item) => item.toJson()).toList(),
    );
    await sharedPreferences.setString(_cartKey, encodedData);
  }

  List<CartItemModel> loadCart() {
    final String? cartData = sharedPreferences.getString(_cartKey);
    if (cartData == null) return [];

    try {
      final List<dynamic> decodedData = jsonDecode(cartData);
      return decodedData.map((item) => CartItemModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Failed to parse local cart data");
    }
  }

  Future<CartItemModel> addItemToRemoteCart(
    int userId,
    int productId,
    int quantity,
  ) async {
    final response = await cartWebServices.addToCart(
      userId,
      productId,
      quantity,
    );
    return CartItemModel.fromJson(response.data);
  }
}
