import 'dart:convert';

import '../../../core/imports/common_imports.dart';

class CartRepository {
  final CartWebServices cartWebServices;
  final SharedPreferences sharedPreferences;
  static const String _cartKey = 'user_cart';
  CartRepository(this.cartWebServices, this.sharedPreferences);
  // حفظ السلة
  Future<void> saveCart(List<ProductModel> products) async {
    final String encodedData = jsonEncode(
      products.map((item) => item.toJson()).toList(),
    );
    await sharedPreferences.setString(_cartKey, encodedData);
  }

  // تحميل السلة عند فتح التطبيق
  List<ProductModel> loadCart() {
    final String? cartData = sharedPreferences.getString(_cartKey);
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      return decodedData.map((item) => ProductModel.fromJson(item)).toList();
    }
    return [];
  }

  Future<bool> syncCartWithServer(List<CartItemModel> items) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
