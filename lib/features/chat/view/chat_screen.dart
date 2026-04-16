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
