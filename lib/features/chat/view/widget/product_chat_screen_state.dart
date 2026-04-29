import 'package:product_browser_app/features/chat/view/widget/product_chat_screen.dart';
import 'package:product_browser_app/features/chat/view/widget/product_info_card.dart';

import '../../../../core/imports/common_imports.dart';
import 'build_app_bar.dart';
import 'build_chat_list.dart';
import 'build_message_input.dart';

class ProductChatScreenState extends State<ProductChatScreen> {
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            const ProductInfoCard(),
            Expanded(child: buildChatList(_scrollController)),
            buildMessageInput(_messageController),
          ],
        ),
      ),
    );
  }
}
