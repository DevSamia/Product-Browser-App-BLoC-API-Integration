import '../../../../core/imports/common_imports.dart';
import 'chat_bubble.dart';

Widget buildChatList(ScrollController controller) {
  return ListView(
    controller: controller,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    children: const [
      ChatBubble(
        isMe: false,
        message:
            "Hello! Welcome to the Nike Official Store. How can I help you today?",
        time: "09:12 AM",
        showAvatar: true,
      ),
      ChatBubble(
        isMe: true,
        message: "Hi! I'm interested in these. Do you have size 10 in stock?",
        time: "09:14 AM",
      ),
      ChatBubble(
        isMe: false,
        message: "Yes! We have exactly two pairs left in that size.",
        time: "09:15 AM",
        showAvatar: true,
      ),
    ],
  );
}
