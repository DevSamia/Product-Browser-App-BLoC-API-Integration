import '../../../core/imports/common_imports.dart';
import '../data/chat_service.dart';
import '../models/message_model.dart';

class ChatScreen extends StatelessWidget {
  final String productId;

  const ChatScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: ChatService().getMessages(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data ?? const [];

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(messages[index].text),
              subtitle: Text(messages[index].senderId),
            );
          },
        );
      },
    );
  }
}

class ProductChatScreen extends StatefulWidget {
  final dynamic productModel;

  const ProductChatScreen({super.key, this.productModel});

  @override
  State<ProductChatScreen> createState() => _ProductChatScreenState();
}

class _ProductChatScreenState extends State<ProductChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        // استخدام Column مع Expanded لمنع الـ Overflow
        child: Column(
          children: [
            const _ProductInfoCard(),
            Expanded(child: _buildChatList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // تأكدي أن الصورة موجودة في المسار الصحيح الموضح في الـ Project Tree
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFF1F4F8),
            backgroundImage: AssetImage('assets/images/user_image.png'),
          ),
          AppSizes.w12,
          Expanded(
            // لمنع الـ Overflow في العناوين الطويلة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryText(
                  "Nike Air Max 270",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D2125),
                ),
                Row(
                  children: [
                    PrimaryText(
                      "Official Store",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF67707A),
                    ),
                    AppSizes.w8,
                    PrimaryText(
                      "Online",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1D2125),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFFD143), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(60, 32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: Color(0xFFB58E14),
                ),
                AppSizes.w6,
                PrimaryText(
                  "View",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFB58E14),
                ),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xFFE5E7EB), height: 1),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: const [
        _ChatBubble(
          isMe: false,
          message:
              "Hello! Welcome to the Nike Official Store. How can I help you today?",
          time: "09:12 AM",
          showAvatar: true,
        ),
        _ChatBubble(
          isMe: true,
          message: "Hi! I'm interested in these. Do you have size 10 in stock?",
          time: "09:14 AM",
        ),
        _ChatBubble(
          isMe: false,
          message: "Yes! We have exactly two pairs left in that size.",
          time: "09:15 AM",
          showAvatar: true,
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.mic_none_outlined,
            color: Color(0xFF67707A),
            size: 24,
          ),
          AppSizes.w12,
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F8),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  AppSizes.w16,
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                          color: Color(0xFF67707A),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  const Icon(Icons.add, color: Color(0xFF67707A), size: 20),
                  AppSizes.w12,
                ],
              ),
            ),
          ),
          AppSizes.w12,
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFFFD143),
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductInfoCard extends StatelessWidget {
  const _ProductInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/user_image.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          AppSizes.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  "Nike Air Max 270",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                PrimaryText(
                  "\$150.00",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFFFD143),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD143),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(70, 30),
            ),
            child: const PrimaryText(
              "Buy Now",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final bool showAvatar;

  const _ChatBubble({
    required this.isMe,
    required this.message,
    required this.time,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            SizedBox(
              width: 30,
              child: showAvatar
                  ? const CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(
                        'assets/images/user_image.png',
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            AppSizes.w8,
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? const Color(0xFFFFD143)
                        : const Color(0xFFF1F4F8),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: Radius.circular(isMe ? 15 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 15),
                    ),
                  ),
                  child: PrimaryText(
                    message,
                    fontSize: 13.sp,
                    color: isMe ? Colors.white : Colors.black87,
                  ),
                ),
                AppSizes.h4,
                PrimaryText(time, fontSize: 10.sp, color: Colors.grey),
              ],
            ),
          ),
          if (isMe) AppSizes.w30,
        ],
      ),
    );
  }
}
