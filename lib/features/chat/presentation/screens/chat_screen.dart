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
    context.read<ChatBloc>().add(ChatEvent.watchMessages(widget.productId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String currentUsername =
        getIt<SharedPreferences>().getString('chat_username') ?? '';

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: PrimaryText(
          "Product Chat",
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
                  error: (message) => Center(
                    child: PrimaryText(
                      "Error: $message",
                      color: colorScheme.error,
                    ),
                  ),
                  loaded: (messages) {
                    if (messages.isEmpty) {
                      return Center(
                        child: PrimaryText(
                          "No messages yet. Start chatting!",
                          color: colorScheme.onSurfaceVariant,
                        ),
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
                  },
                );
              },
            ),
          ),
          _buildInputArea(colorScheme),
        ],
      ),
    );
  }

  Widget _buildInputArea(ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: colorScheme.onSurface, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                ),
                fillColor: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
              ),
            ),
          ),
          AppSizes.w12,
          CircleAvatar(
            backgroundColor: colorScheme.primary,
            radius: 22.r,
            child: IconButton(
              icon: Icon(Icons.send, color: colorScheme.onPrimary, size: 20.sp),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  context.read<ChatBloc>().add(
                    ChatEvent.sendMessage(
                      _controller.text.trim(),
                      widget.productId,
                    ),
                  );
                  _controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
