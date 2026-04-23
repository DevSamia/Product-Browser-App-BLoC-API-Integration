import '../../../core/imports/common_imports.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/message_model.dart';

class ChatScreen extends StatelessWidget {
  final String productId;

  const ChatScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    AppLogger.d("🎨 UI: Building ChatScreen for Product: $productId");

    return Scaffold(
      appBar: AppBar(title: const Text("Product Chat"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                AppLogger.d("📺 UI: Current ChatState is ${state.runtimeType}");

                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ChatError) {
                  AppLogger.w("⚠️ UI: Displaying Chat Error: ${state.message}");
                  return Center(child: Text("Error: ${state.message}"));
                }

                if (state is ChatLoaded) {
                  final messages = state.messages;

                  if (messages.isEmpty) {
                    AppLogger.i("ℹ️ UI: Chat is empty for this product");
                    return const Center(
                      child: Text("No messages yet. Start chatting!"),
                    );
                  }

                  AppLogger.i("✨ UI: Rendering ${messages.length} messages");

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _ChatBubble(message: message);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          _MessageInputField(productId: productId),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final MessageModel message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.senderId == "current_user_id"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.senderId == "current_user_id"
              ? AppColors.primary
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.senderId == "current_user_id"
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}

class _MessageInputField extends StatelessWidget {
  final String productId;
  _MessageInputField({required this.productId});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Type a message..."),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primary),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                AppLogger.d("🖱️ UI: User clicked send button");
                context.read<ChatBloc>().add(
                  SendMessageEvent(_controller.text, productId),
                );
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
