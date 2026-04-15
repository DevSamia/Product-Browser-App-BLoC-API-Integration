import '../models/cart_tem_model.dart';
import 'cart_web_services.dart';

class CartRepository {
  final CartWebServices cartWebServices;

  CartRepository(this.cartWebServices);

  Future<bool> syncCartWithServer(List<CartItemModel> items) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
