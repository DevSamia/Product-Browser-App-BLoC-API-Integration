import '../../../../core/di/injection_container.dart';
import '../../../../core/imports/common_imports.dart';

class ChatScreen extends StatefulWidget {
  final String productId;

  const ChatScreen({super.key, required this.productId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // بدء الاستماع للرسائل فور فتح الشاشة
    context.read<ChatBloc>().add(WatchMessagesEvent(widget.productId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الوصول لـ SharedPreferences عبر getIt الموحد
    final String currentUsername =
        getIt<SharedPreferences>().getString('chat_username') ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text("Product Chat"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ChatError) {
                  return Center(child: Text("Error: ${state.message}"));
                }

                if (state is ChatLoaded) {
                  final messages = state.messages;

                  if (messages.isEmpty) {
                    return const Center(
                      child: Text("No messages yet. Start chatting!"),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageBubble(
                        message: message,
                        isMe: message.senderUsername == currentUsername,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
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
              if (_controller.text.trim().isNotEmpty) {
                context.read<ChatBloc>().add(
                      SendMessageEvent(_controller.text.trim(), widget.productId),
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
