import 'package:product_browser_app/features/chat/view/widget/product_chat_screen_state.dart';

import '../../../../core/imports/common_imports.dart';

class ProductChatScreen extends StatefulWidget {
  final dynamic productModel;

  const ProductChatScreen({super.key, this.productModel});

  @override
  State<ProductChatScreen> createState() => ProductChatScreenState();
}
