import 'dart:convert';

import '../../../core/imports/common_imports.dart';

class CartRepository {
  final CartWebServices cartWebServices;
  final SharedPreferences sharedPreferences;
  static const String _cartKey = 'user_cart_v2';
  CartRepository(this.cartWebServices, this.sharedPreferences);

  Future<void> saveCart(List<CartItemModel> items) async {
    AppLogger.d("💾 Repository: Saving ${items.length} items to local storage");
    try {
      final String encodedData = jsonEncode(
        items.map((item) => item.toJson()).toList(),
      );
      await sharedPreferences.setString(_cartKey, encodedData);
      AppLogger.i("✅ Repository: Local cart updated successfully");
    } catch (e, stackTrace) {
      AppLogger.e("❌ Repository: Failed to save cart locally", e, stackTrace);
      rethrow;
    }
  }

  List<CartItemModel> loadCart() {
    AppLogger.d("📂 Repository: Loading cart from local storage...");
    final String? cartData = sharedPreferences.getString(_cartKey);

    if (cartData == null) {
      AppLogger.i("ℹ️ Repository: No local cart data found (Empty)");
      return [];
    }

    try {
      final List<dynamic> decodedData = jsonDecode(cartData);
      final List<CartItemModel> items = decodedData
          .map((item) => CartItemModel.fromJson(item))
          .toList();

      AppLogger.i(
        "✅ Repository: Loaded ${items.length} items from local storage",
      );
      return items;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository: Failed to parse local cart data",
        e,
        stackTrace,
      );
      throw Exception("Failed to parse local cart data");
    }
  }

  Future<CartItemModel> addItemToRemoteCart(
    int userId,
    int productId,
    int quantity,
  ) async {
    AppLogger.i(
      "🚀 Repository: Adding product $productId to remote cart for user $userId",
    );
    try {
      final response = await cartWebServices.addToCart(
        userId,
        productId,
        quantity,
      );

      final CartItemModel newItem = CartItemModel.fromJson(response.data);
      AppLogger.i(
        "✅ Repository: Product ${newItem.product.id} added to remote cart successfully",
      );
      return newItem;
    } catch (e, stackTrace) {
      AppLogger.e(
        "❌ Repository: Error adding item to remote cart",
        e,
        stackTrace,
      );
      rethrow;
    }
  }
}
